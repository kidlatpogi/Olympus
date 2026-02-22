import cv2 as cv
import mediapipe as mp
from mediapipe.tasks import python
from mediapipe.tasks.python import vision
import numpy as np
import time
import random
import math

# Hand connections (pairs of landmark indices to draw lines between)
HAND_CONNECTIONS = [
    (0, 1), (1, 2), (2, 3), (3, 4),  # Thumb
    (0, 5), (5, 6), (6, 7), (7, 8),  # Index finger
    (5, 9), (9, 10), (10, 11), (11, 12),  # Middle finger
    (9, 13), (13, 14), (14, 15), (15, 16),  # Ring finger
    (13, 17), (0, 17), (17, 18), (18, 19), (19, 20)  # Pinky
]

# ===== SMOKE POOF EFFECT =====
class SmokeParticle:
    def __init__(self, x, y, burst=False):
        angle = random.uniform(0, 2 * math.pi)
        speed = random.uniform(3, 12) if burst else random.uniform(1, 4)
        self.x = x + random.uniform(-30, 30)
        self.y = y + random.uniform(-30, 30)
        self.vx = math.cos(angle) * speed
        self.vy = math.sin(angle) * speed - random.uniform(0.5, 2)
        self.size = random.uniform(15, 50)
        self.life = random.uniform(0.7, 1.0)
        self.decay = random.uniform(0.015, 0.03)
        self.grow = random.uniform(0.8, 2.0)
        shade = random.randint(200, 255)
        self.color = (shade, shade, shade)

    def update(self):
        self.x += self.vx
        self.y += self.vy
        self.vx *= 0.96
        self.vy *= 0.96
        self.life -= self.decay
        self.size += self.grow

    def is_alive(self):
        return self.life > 0

    def draw(self, image):
        if self.life <= 0:
            return
        alpha = max(0, min(1.0, self.life))
        overlay = image.copy()
        cv.circle(overlay, (int(self.x), int(self.y)), int(self.size), self.color, -1)
        cv.addWeighted(overlay, alpha * 0.4, image, 1.0 - alpha * 0.4, 0, image)

def detect_clone_jutsu(detection_result):
    """
    Detect the Kage Bunshin no Jutsu (Shadow Clone) hand sign.
    Requires TWO hands detected, both with index+middle fingers extended
    and other fingers curled, hands close together forming a cross (+) shape.
    """
    if not detection_result.hand_landmarks or len(detection_result.hand_landmarks) < 2:
        return False
    
    hands_in_sign = 0
    hand_centers = []
    
    for hand_landmarks in detection_result.hand_landmarks:
        # Landmark indices
        # Tips: thumb=4, index=8, middle=12, ring=16, pinky=20
        # PIPs: index=6, middle=10, ring=14, pinky=18
        # MCPs: index=5, middle=9, ring=13, pinky=17
        
        index_tip = hand_landmarks[8]
        index_pip = hand_landmarks[6]
        middle_tip = hand_landmarks[12]
        middle_pip = hand_landmarks[10]
        ring_tip = hand_landmarks[16]
        ring_pip = hand_landmarks[14]
        pinky_tip = hand_landmarks[20]
        pinky_pip = hand_landmarks[18]
        wrist = hand_landmarks[0]
        
        # Index and middle must be extended (tip above PIP)
        index_up = index_tip.y < index_pip.y
        middle_up = middle_tip.y < middle_pip.y
        
        # Ring and pinky must be curled (tip below PIP or close to palm)
        ring_down = ring_tip.y > ring_pip.y
        pinky_down = pinky_tip.y > pinky_pip.y
        
        if index_up and middle_up and ring_down and pinky_down:
            hands_in_sign += 1
            # Track center of hand (use middle MCP - landmark 9)
            hand_centers.append((hand_landmarks[9].x, hand_landmarks[9].y))
    
    if hands_in_sign < 2 or len(hand_centers) < 2:
        return False
    
    # Check that hands are close together (crossing)
    dx = abs(hand_centers[0][0] - hand_centers[1][0])
    dy = abs(hand_centers[0][1] - hand_centers[1][1])
    hands_close = dx < 0.25 and dy < 0.25
    
    return hands_close

def draw_hand_landmarks(image, hand_landmarks):
    """Draw hand landmarks and connections on the image."""
    height, width, _ = image.shape
    
    # Draw connections
    for connection in HAND_CONNECTIONS:
        start_idx, end_idx = connection
        if start_idx < len(hand_landmarks) and end_idx < len(hand_landmarks):
            start_point = hand_landmarks[start_idx]
            end_point = hand_landmarks[end_idx]
            
            start_px = (int(start_point.x * width), int(start_point.y * height))
            end_px = (int(end_point.x * width), int(end_point.y * height))
            
            cv.line(image, start_px, end_px, (0, 255, 0), 2)
    
    # Draw landmarks
    for landmark in hand_landmarks:
        px = int(landmark.x * width)
        py = int(landmark.y * height)
        cv.circle(image, (px, py), 5, (0, 0, 255), -1)

# Initialize the Hands model using the new tasks API
base_options = python.BaseOptions(model_asset_path='hand_landmarker.task')
options = vision.HandLandmarkerOptions(
    base_options=base_options,
    num_hands=2,
    min_hand_detection_confidence=0.5,
    min_hand_presence_confidence=0.5,
    min_tracking_confidence=0.5
)
detector = vision.HandLandmarker.create_from_options(options)

# Open the camera
cam = cv.VideoCapture(0)

# Check if camera opened successfully
if not cam.isOpened():
    print("Error: Could not open camera 0, trying camera 1...")
    cam = cv.VideoCapture(1)
    if not cam.isOpened():
        print("Error: Could not open any camera. Please check:")
        print("1. Camera is connected")
        print("2. No other application is using the camera")
        print("3. Camera permissions are granted")
        exit()

print("Camera opened successfully!")

# Set camera properties for better performance
cam.set(cv.CAP_PROP_FRAME_WIDTH, 640)
cam.set(cv.CAP_PROP_FRAME_HEIGHT, 480)
cam.set(cv.CAP_PROP_FPS, 30)

# Give camera time to initialize
time.sleep(1)
print("Starting hand detection...")
print("Make the Shadow Clone hand sign (both hands, index+middle fingers up, crossed) to activate!")

frame_count = 0
error_count = 0
max_errors = 10

# Clone effect variables
NUM_CLONES = 5  # Total bodies on screen (you + 4 clones)
clone_active = False
clone_timer = 0
clone_duration = 200  # ~10 seconds at 30fps
clone_snapshot = None  # Captured frame when gesture triggers
clone_appear_frame = 0  # Frame counter for appear animation
smoke_particles = []

def spawn_smoke_burst(w, h, num_clones):
    """Spawn a big smoke poof across the screen when clones appear."""
    particles = []
    # Create smoke at each clone position
    for i in range(num_clones):
        cx = int((i + 0.5) * w / num_clones)
        cy = h // 2
        for _ in range(40):  # 40 particles per clone position
            particles.append(SmokeParticle(cx, cy, burst=True))
        # Extra particles at top and bottom
        for _ in range(15):
            particles.append(SmokeParticle(cx, random.randint(0, h), burst=True))
    return particles

while cam.isOpened():
    # Read a frame from the camera
    success, frame = cam.read()

    # If the frame is not available, skip this iteration
    if not success:
        error_count += 1
        if error_count <= 3:
            print(f"Warning: Camera frame not available (attempt {error_count})")
        if error_count > max_errors:
            print("Too many consecutive errors. Exiting...")
            break
        time.sleep(0.1)
        continue
    
    # Reset error count on successful frame read
    error_count = 0
    frame_count += 1

    # Flip the frame horizontally to correct mirroring
    frame = cv.flip(frame, 1)

    # Convert the frame to RGB (required by MediaPipe)
    rgb_frame = cv.cvtColor(frame, cv.COLOR_BGR2RGB)
    
    # Create MediaPipe Image object
    mp_image = mp.Image(image_format=mp.ImageFormat.SRGB, data=rgb_frame)
    
    # Process the frame for hand detection and tracking
    detection_result = detector.detect(mp_image)

    # Check for Kage Bunshin no Jutsu hand sign (two hands crossing)
    gesture_detected = detect_clone_jutsu(detection_result)
    
    # Activate clone effect when gesture is detected
    if gesture_detected and not clone_active:
        clone_active = True
        clone_timer = clone_duration
        clone_snapshot = frame.copy()
        clone_appear_frame = 0
        h, w = frame.shape[:2]
        smoke_particles = spawn_smoke_burst(w, h, NUM_CLONES)
        print("Kage Bunshin no Jutsu! Clone effect activated! (10 seconds)")
    
    # Apply clone effect: place full-size copies of yourself side by side
    if clone_active:
        clone_timer -= 1
        clone_appear_frame += 1
        
        if clone_timer <= 0:
            clone_active = False
            clone_snapshot = None
            smoke_particles = []
        else:
            h, w = frame.shape[:2]
            
            # Build the cloned frame: NUM_CLONES copies side by side
            # Each clone is a full-height strip
            strip_w = w // NUM_CLONES
            
            # Determine which slot is the "live" one (center)
            live_slot = NUM_CLONES // 2
            
            result = np.zeros_like(frame)
            
            for i in range(NUM_CLONES):
                dst_x1 = i * strip_w
                dst_x2 = dst_x1 + strip_w if i < NUM_CLONES - 1 else w
                actual_strip_w = dst_x2 - dst_x1
                
                # All clones show the live feed
                src = frame
                
                # Crop center strip from source
                src_cx = w // 2
                src_x1 = max(0, src_cx - actual_strip_w // 2)
                src_x2 = src_x1 + actual_strip_w
                if src_x2 > w:
                    src_x2 = w
                    src_x1 = w - actual_strip_w
                
                result[:, dst_x1:dst_x2] = src[:h, src_x1:src_x2]
            
            # Fade-in during first 15 frames
            if clone_appear_frame < 15:
                alpha = clone_appear_frame / 15.0
                frame = cv.addWeighted(result, alpha, frame, 1.0 - alpha, 0)
            # Fade-out during last 2 seconds (60 frames)
            elif clone_timer < 60:
                alpha = clone_timer / 60.0
                frame = cv.addWeighted(result, alpha, frame, 1.0 - alpha, 0)
            else:
                frame = result
    
    # Update and draw smoke particles
    alive = []
    for p in smoke_particles:
        p.update()
        if p.is_alive():
            alive.append(p)
            p.draw(frame)
    smoke_particles = alive

    # Draw landmarks on the frame if hands are detected
    if detection_result.hand_landmarks:
        for hand_landmarks in detection_result.hand_landmarks:
            draw_hand_landmarks(frame, hand_landmarks)
    
    # Show status text
    if clone_active:
        remaining = clone_timer / 30
        cv.putText(frame, f"SHADOW CLONE JUTSU! ({remaining:.0f}s)",
                  (10, 50), cv.FONT_HERSHEY_SIMPLEX, 1.0, (0, 255, 255), 2)

    # Display the frame with annotations
    cv.imshow("Show Video", frame)

    # Exit the loop if 'q' key is pressed
    if cv.waitKey(20) & 0xff == ord('q'):
        break

# Release the camera and close the detector
cam.release()
detector.close()
cv.destroyAllWindows()