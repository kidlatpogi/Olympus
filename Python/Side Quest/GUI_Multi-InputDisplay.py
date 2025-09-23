import tkinter
import CenterWindow

# tkcalendar import
# kailangan ng "pip install tkcalendar" sa terminal
from tkcalendar import DateEntry

class MultiInputDisplay:
    def __init__(self, root):
        self.root = root

        # Window title
        self.root.title("Multi Input Display")

        # Dictionary to hold text field references
        self.entries = {}

        # Define fields based on platform
        fields = [
                    ("First Name", "First Name:"),
                    ("Middle Name", "Middle Name:"),
                    ("Last Name", "Last Name:"),
                    ("Date of Birth", "Date of Birth:"),
                    ("Email", "Email:")
                ]

        # Main frame to hold all text fields + button
        main_frame = tkinter.Frame(root)
        main_frame.pack(expand=True, fill="both")

        # Iterate over fields to create labels and entries
        for field_key, label_text in fields:

            # Frame for each label-entry pair
            frame = tkinter.Frame(main_frame)
            frame.pack(pady=10, anchor="center")

            # Labels and Text Fields
            label = tkinter.Label(frame, text=label_text, font=("Arial", 9), anchor="center", width=12)
            label.pack(side=tkinter.LEFT, padx=5)

            # Use DateEntry for Date of Birth, else use standard Entry
            if field_key == "Date of Birth":
                entry = DateEntry(frame, font=("Arial", 14), width=18, justify="center", date_pattern="yyyy-mm-dd")
            else:
                entry = tkinter.Entry(frame, font=("Arial", 14), justify="center", width=20)
            entry.pack(side=tkinter.LEFT, padx=5)
            self.entries[field_key] = entry

        # Button
        self.display_button = tkinter.Button(main_frame, text="Submit", command=self.display_info)

        # Button styling
        self.display_button.config(font=("Arial", 16, "bold"))
        self.display_button.pack(pady=20)

        # Result Label or holder para sa info
        self.result_label = tkinter.Label(main_frame, text="", font=("Arial", 12), justify="center")
        self.result_label.pack(pady=10)

    def display_info(self):
        # Check if any field is empty
        if any(self.entries[field].get() == "" for field in self.entries):

            # Throw error message if any field is empty
            self.result_label.config(text="Please fill all the fields.")

        # If not empty, display the info
        else:

            # getters
            first_name = self.entries["First Name"].get()
            middle_name = self.entries["Middle Name"].get()
            last_name = self.entries["Last Name"].get()
            dob = self.entries["Date of Birth"].get()
            email = self.entries["Email"].get()

            # Display the collected information
            self.result_label.config(text=  f"Name: {first_name} {middle_name} {last_name}\n"
                                            f"Date of Birth: {dob}\n"
                                            f"Email: {email}")

root = tkinter.Tk()
app = MultiInputDisplay(root)

CenterWindow.center_window(root, 500, 400)

root.mainloop()
