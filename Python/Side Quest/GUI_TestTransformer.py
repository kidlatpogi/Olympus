# Let you transform text from Lower to Upper case and vice versa.
# Import necessary libraries
import tkinter

# Import the CenterWindow module 
import CenterWindow

class TextTransformer:
    def __init__(self, root):

        # Initialize the main window
        self.root = root

        # Label to prompt user input
        self.label = tkinter.Label(root, text="Enter text to transform:", font=("Arial", 15))
        self.label.pack()

        # Input field for user text
        self.entry = tkinter.Entry(root, font=("Arial", 20))
        self.entry.pack()

        # Frame to hold buttons side by side
        button_frame = tkinter.Frame(root)
        button_frame.pack(pady=10)

        # Transform button to change case of text
        self.transform_button = tkinter.Button(button_frame, text="Transform", command=self.transform_text)
        self.transform_button.pack(side=tkinter.LEFT, padx=5)

        # Clear button to reset the input field
        self.clear_button = tkinter.Button(button_frame, text="Clear", command=self.clear_text)
        self.clear_button.pack(side=tkinter.LEFT, padx=5)

    # Function to transform text case
    def transform_text(self):

            # Get the text from the entry widget
            text = self.entry.get()

            # Transform text to upper case if it's lower case, and vice versa
            if text.islower():
                transformed = text.upper()
            else:
                transformed = text.lower()
            self.entry.delete(0, tkinter.END)
            self.entry.insert(0, transformed)

    def clear_text(self):
            self.entry.delete(0, tkinter.END)

root = tkinter.Tk()
TextTransformer(root)
root.title("Text Transformer")

# Center the window on the screen
CenterWindow.center_window(root, 400, 150)

root.mainloop()