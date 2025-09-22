# Imports
import tkinter as tk
import random
import colorsys

import CenterWindow

class ColorChanger:
    def __init__(self, root):
        self.root = root

        # Set initial background color to white
        self.root.config(bg="#ffffff")

        # Set window size
        root.geometry("400x200")

        # Initial color before any button press
        color = "#ffffff"

        # Create and pack the label to display the current color
        self.label = tk.Label(root, text="This Color is: " + color, font=("Arial", 30))

        # Set label background to match initial window background
        self.label.config(bg="#ffffff")
        self.label.pack(anchor="center", pady=20)

        # Create and pack the button to change the color
        self.button = tk.Button(root, text="Change Color", command=self.change_color)

        # Set button font and pack it
        self.button.config(font=("Arial", 15))
        self.button.pack(anchor="center", pady=10)

    def change_color(self):

        # Generate a random color in HSV space and convert to RGB
        h = random.random()
        s = 0.7 + 0.3 * random.random()
        v = 0.7 + 0.3 * random.random()
        r, g, b = colorsys.hsv_to_rgb(h, s, v)

        # Convert RGB values to hex format
        new_color = '#{:02x}{:02x}{:02x}'.format(int(r*255), int(g*255), int(b*255))

        # Update the label and window background with the new color
        new_color = random.choice([new_color])

        # Update the label and window background with the new color
        self.label.config(text="This Color is: " + new_color)
        self.root.config(bg=new_color)
        self.label.config(bg=new_color)

        # Adjust text color based on brightness for better visibility
        brightness = (r*255*0.299 + g*255*0.587 + b*255*0.114)
        if brightness > 160:
            self.label.config(fg="black")
        else:
            self.label.config(fg="white")

root = tk.Tk()
root.title("Color Changer")
ColorChanger(root)

CenterWindow.center_window(root, 400, 200)

root.mainloop()