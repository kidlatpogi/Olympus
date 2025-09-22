import tkinter as tk

import CenterWindow

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

ClickCounter(root)

CenterWindow.center_window(root, 400, 200)

root.mainloop()