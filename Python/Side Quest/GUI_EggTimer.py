import tkinter
import CenterWindow

class EggTimer:
    def __init__(self, root):
        self.root = root
        self.root.title("Egg Timer")

        # Types of eggs dictionary
        soft_types = ["Jammy Egg", "Soft-Boiled"]
        hard_types = ["Medium-Hard", "Hard-Boiled"]

        # Choose Egg Type Label
        label = tkinter.Label(root, text="Choose Egg Type", font=("Arial", 20))
        label.pack(pady=10)

        # Create frames for left and right sides
        left_frame = tkinter.Frame(root)
        left_frame.pack(side="left", padx=20, pady=10, expand=True, fill="y")

        # Right frame for hard-boiled eggs
        right_frame = tkinter.Frame(root)
        right_frame.pack(side="right", padx=20, pady=10, expand=True, fill="y")

        # Load and display images for soft-boiled and hard-boiled eggs
        soft_boiled_img = tkinter.PhotoImage(file="IMG\\eggs\\soft_boiled.png")
        hard_boiled_img = tkinter.PhotoImage(file="IMG\\eggs\\hard_boiled.png")

        # Resize image to fit
        softImg = soft_boiled_img.subsample(5, 5)
        hardImg = hard_boiled_img.subsample(5, 5)

        # Display image in left frame
        soft_img_label = tkinter.Label(left_frame, image=softImg)
        soft_img_label.pack(pady=5)
        soft_img_label.image = softImg

        # Create buttons for each egg type in the left frame
        for egg_type in soft_types:
            button = tkinter.Button(left_frame, text=egg_type, compound="left",
                                command=lambda et=egg_type: self.start_timer(et))
            button.config(font=("Arial", 16), width=14)
            button.pack(pady=5)

        hard_img_label = tkinter.Label(right_frame, image=hardImg)
        hard_img_label.pack(pady=5)
        hard_img_label.image = hardImg

        for egg_type in hard_types:
            button = tkinter.Button(right_frame, text=egg_type, compound="left",
                                command=lambda et=egg_type: self.start_timer(et))
            button.config(font=("Arial", 16), width=14)
            button.pack(pady=5)

        # Store reference to prevent garbage collection
        self.soft_boiled_img = soft_boiled_img
        self.hard_boiled_img = hard_boiled_img

    # Start timer based on egg type
    def start_timer(self, egg_type):

        # Define cooking times for each egg type
        # 1 = second, 60 = 1 minute
        # 4 * 60 = 4 minutes
        times = {
            "Jammy Egg": 4 * 60,
            "Soft-Boiled": 6 * 60,
            "Medium-Hard": 8 * 60,
            "Hard-Boiled": 10 * 60
        }

        # Get the cooking time for the selected egg type
        if egg_type in times:
            total_seconds = times[egg_type]
            self.show_timer_frame(egg_type, total_seconds)

    # Show timer frame
    # Create a new frame to display the countdown timer
    # Hide the main window elements
    def show_timer_frame(self, egg_type, total_seconds):
        # Hide main frames
        for widget in self.root.winfo_children():
            widget.pack_forget()

        self.cooking_label = tkinter.Label(self.root, text=f"Cooking: {egg_type}", font=("Arial", 20))
        self.cooking_label.pack(pady=10)

        self.timer_frame = tkinter.Frame(self.root)
        self.timer_frame.pack(expand=True, fill="both")

        self.timer_label = tkinter.Label(self.timer_frame, text="", font=("Arial", 32))
        self.timer_label.pack(side="top", pady=30)

        self.cancel_button = tkinter.Button(self.timer_frame, text="Cancel", font=("Arial", 16),
                                            command=self.back_to_main)
        self.cancel_button.pack(pady=10)

        # Initialize countdown
        self.current_seconds = total_seconds
        self.countdown(egg_type)

    # Countdown function to update the timer every second
    def countdown(self, egg_type):

        # Calculate minutes and seconds
        mins, secs = divmod(self.current_seconds, 60)

        # Format time as MM:SS
        time_format = f"{mins:02}:{secs:02}"

        # Update the timer label
        self.timer_label.config(text=time_format)

        # If there is still time left, call this function again after 1 second
        if self.current_seconds > 0:
            self.current_seconds -= 1
            self.root.after(1000, self.countdown, egg_type)
        else:
            self.timer_label.config(text="Egg is ready!")
            self.cancel_button.pack_forget()
            
            # Add Snooze and Exit buttons
            button_frame = tkinter.Frame(self.timer_frame)
            button_frame.pack(pady=10)

            self.snooze_button = tkinter.Button(button_frame, text="Snooze", font=("Arial", 16), width=10,
                                                command=lambda: self.snooze(egg_type))
            self.snooze_button.pack(side="left", padx=5)
            self.exit_button = tkinter.Button(button_frame, text="Exit", font=("Arial", 16), width=10,
                                                command=self.back_to_main)
            self.exit_button.pack(side="left", padx=5)

    # Snooze function to add 1 minute to the timer
    def snooze(self, egg_type):
        # Snooze for 1 minute
        self.snooze_button.pack_forget()
        self.exit_button.pack_forget()

        # Add 60 seconds to current time and restart countdown
        self.current_seconds += 60
        self.countdown(egg_type)

        # Re-add the cancel button
        self.cancel_button = tkinter.Button(self.timer_frame, text="Cancel", font=("Arial", 16),
                                            command=self.back_to_main)
        self.cancel_button.pack(pady=10)

    # Function to return to the main window
    # Destroys the timer frame and recreates the main window layout
    def back_to_main(self):
        self.timer_frame.destroy()

        # Destroy cooking label if it exists
        if hasattr(self, 'cooking_label'):
            self.cooking_label.destroy()
        # Recreate the main window layout
        self.__init__(self.root)

root = tkinter.Tk()

CenterWindow.center_window(root, 400, 300)
EggTimer(root)

root.mainloop()