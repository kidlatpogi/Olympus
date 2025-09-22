import tkinter as tk

class ClickCounter:
    def __init__ (self,root):
        self.count = 0

        self.label = tk.Label(root, text="Clicks: 0", font=("Arial", 40))
        self.label.pack()

        self.button = tk.Button(root, text="Click me!", command=self.increment)
        self.button.config(font=("Arial", 20))
        self.button.pack()

    def increment(self):
        self.count += 1
        self.label.config(text=f"Clicks: {self.count}")

root = tk.Tk()
root.title("Click Counter")

# Set window size
root.geometry("400x200")

# Center the window on the screen
root.update_idletasks()
width = root.winfo_width()
height = root.winfo_height()
x = (root.winfo_screenwidth() // 2) - (width // 2)
y = (root.winfo_screenheight() // 2) - (height // 2)
root.geometry(f"{width}x{height}+{x}+{y}")

ClickCounter(root)
root.mainloop()