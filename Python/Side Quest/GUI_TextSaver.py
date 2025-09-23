# A simple GUI application to input multi-line text and save it to a file.

# Import for GUI
import tkinter

# Import the CenterWindow module
import CenterWindow

# Import filedialog for file saving
from tkinter import filedialog

class TextSaver:
    def __init__(self, root):
        self.root = root

        # Window Title
        self.root.title("Text Saver")

        # Create a Text area for multiple lines of text/input
        self.text_area = tkinter.Text(root, wrap='word', font=("Arial", 12))
        self.text_area.pack(expand=False, fill='both', padx=10, pady=10)

        # Set size for the Text Area
        self.text_area.config(height=10, width=40)

        # Frame to hold buttons side by side
        button_frame = tkinter.Frame(root)
        button_frame.pack(pady=10)

        # Save Button
        self.save_button = tkinter.Button(button_frame, text="Save Text", command=self.save_text)

        # Put the button side by side with padding
        self.save_button.pack(side=tkinter.LEFT, padx=10)

        # Font and size for the button
        self.save_button.config(font=("Arial", 14))

        # Clear Button
        self.clear_button = tkinter.Button(button_frame, text="Clear Text", command=self.clear_text)

        # Put the button side by side with padding
        self.clear_button.pack(side=tkinter.LEFT, padx=10)

        # Font and size for the button
        self.clear_button.config(font=("Arial", 14))

        # Cancel Button to close the application
        self.cancel_button = tkinter.Button(button_frame, text="Cancel", command=self.quit)

        # Put the button side by side with padding
        self.cancel_button.pack(side=tkinter.LEFT, padx=10)

        # Font and size for the button
        self.cancel_button.config(font=("Arial", 14))

    def save_text(self):
        # Get the content from the Text area
        content = self.text_area.get("1.0", tkinter.END).strip()
        
        if content:
            # Ask the user where to save the file
            file_path = filedialog.asksaveasfilename(

            # Options for the file dialog
            defaultextension=".txt",
            filetypes=[("Text Files", "*.txt"), ("All Files", "*.*")],
            title="Save Text As"
            )

            # If a file path is selected, save the content to that file
            if file_path:

                # Write the content to the file
                with open(file_path, "w", encoding="utf-8") as file:
                    file.write(content)

                # Notify the user that the file has been saved
                print(f"Text saved to {file_path}")
            else:
                print("Save cancelled.")
        else:
            print("No text to save.")

    # Function to clear the text area
    def clear_text(self):
        self.text_area.delete("1.0", tkinter.END)

    # Function to quit the application
    def quit(self):
        self.root.quit()

root = tkinter.Tk()
TextSaver(root)
root.title("Text Saver")

CenterWindow.center_window(root, 400, 300)

root.mainloop()