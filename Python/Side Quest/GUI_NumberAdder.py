# Import necessary libraries
import tkinter

# Import the CenterWindow module 
import CenterWindow

class NumberAdder:
    def __init__(self, root):

        # Initialize the main window
        self.root = root

        # Set window size
        root.geometry("400x200")

        # Total set to 0 initially
        self.total = 0

        # Create and pack the label to display the total
        self.label = tkinter.Label(root, text="Total: 0", font=("Arial", 25))
        self.label.pack()

        # Create and pack the entry widget or input box for number input
        self.entry = tkinter.Entry(root, font=("Arial", 20))
        self.entry.pack()

        # Create a frame to hold the buttons
        # So that I can pack them side by side
        button_frame = tkinter.Frame(root)
        button_frame.pack(pady=10)

        # Create and pack the Add button
        self.add_button = tkinter.Button(button_frame, text="Add", command=self.add_number)
        self.add_button.config(font=("Arial", 20))
        self.add_button.pack(side="left", padx=10)

        # Create and pack the Clear button
        self.clear_button = tkinter.Button(button_frame, text="Clear", command=self.clear_total)
        self.clear_button.config(font=("Arial", 20))
        self.clear_button.pack(side="left", padx=10)

        # Bind Enter key to add_number
        self.entry.bind("<Return>", lambda event: self.add_number())

        # Bind Delete key to clear_total
        self.entry.bind("<Delete>", lambda event: self.clear_total())

    def add_number(self):
        try:
            # Get the number from the entry widget
            number = float(self.entry.get())

            # Add the number to the total and update the label
            self.total += number

            # Update the label to show the new total
            self.label.config(text=f"Total: {self.total}")

            # Clear the input field for the next input
            self.entry.delete(0, tkinter.END)

        except ValueError:

            # If input is not a valid number or a letter, show an error message
            self.label.config(text="Please enter a number.")

            # Clear the invalid input
            self.entry.delete(0, tkinter.END)

    def clear_total(self):

        # Reset the total to 0 and update the label
        self.total = 0
        self.label.config(text="Total: 0")

        # Clear the input field
        self.entry.delete(0, tkinter.END)

root = tkinter.Tk()
root.title("Number Adder")
NumberAdder(root)

# Center the window on the screen
CenterWindow.center_window(root, 400, 200)

root.mainloop()