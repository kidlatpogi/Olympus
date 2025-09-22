import tkinter as tk  # Import the tkinter library for GUI

class Stopwatch:
    def __init__(self, root):
        # The stopwatch is not running initially
        self.running = False

        # Time starts at 0 (measured in centiseconds, 1/100th of a second)
        self.time = 0 

        # Create the label to display the time, set its font and add to the window
        self.label = tk.Label(root, text="00:00:00.00", font=("Arial", 40))
        self.label.pack()

        # Create and add the Start button, which calls self.start when clicked
        self.start_btn = tk.Button(root, text="Start", command=self.start)
        self.start_btn.pack(side="left")

        # Create and add the Stop button, which calls self.stop when clicked
        self.stop_btn = tk.Button(root, text="Stop", command=self.stop)
        self.stop_btn.pack(side="left")

        # Create and add the Reset button, which calls self.reset when clicked
        self.reset_btn = tk.Button(root, text="Reset", command=self.reset)
        self.reset_btn.pack(side="left")

        # Start the clock update loop
        self.update_clock()

    def update_clock(self):
        # If the stopwatch is running, increment time by 1 centisecond
        if self.running:
            self.time += 1

        # Calculate centiseconds, seconds, minutes, and hours from self.time
        centiseconds = self.time % 100
        total_seconds = self.time // 100
        mins, secs = divmod(total_seconds, 60)
        hours, mins = divmod(mins, 60)

        # Update the label to show the formatted time
        self.label.config(text=f"{hours:02}:{mins:02}:{secs:02}.{centiseconds:02}")

        # Schedule the next update after 10 milliseconds
        self.label.after(10, self.update_clock)

    # Start the stopwatch
    def start(self):
        self.running = True

    # Stop/pause the stopwatch
    def stop(self):
        self.running = False

    # Reset the stopwatch to zero and update the label
    def reset(self):
        self.running = False
        self.time = 0
        self.label.config(text="00:00:00.00")

# Create the main application window
root = tk.Tk()
root.title("Stopwatch")

# Set window size
root.geometry("300x100")

# Center the window on the screen
root.update_idletasks()
width = root.winfo_width()
height = root.winfo_height()
x = (root.winfo_screenwidth() // 2) - (width // 2)
y = (root.winfo_screenheight() // 2) - (height // 2)
root.geometry(f"{width}x{height}+{x}+{y}")

# Create and display the Stopwatch in the window
Stopwatch(root)

# Start the GUI event loop
root.mainloop()