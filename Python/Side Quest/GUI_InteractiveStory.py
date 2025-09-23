import tkinter
import CenterWindow

class InteractiveStory:
    def __init__(self, root):
        self.root = root
        self.root.title("Interactive Story")
        
        intro = "You find yourself in a dark forest. Two paths lie ahead. Left or Right?"

        self.label = tkinter.Label(root, text=intro, font=("Arial", 14), wraplength=480)
        self.label.pack(pady=20)

        button_frame = tkinter.Frame(root)
        button_frame.pack(pady=10)

        self.left_button = tkinter.Button(button_frame, text="Left", command=self.choose_left)
        self.left_button.config(width=15, font=("Arial", 12))
        self.left_button.pack(side="left", padx=10)

        self.right_button = tkinter.Button(button_frame, text="Right", command=self.choose_right)
        self.right_button.config(width=15, font=("Arial", 12))
        self.right_button.pack(side="right", padx=10)

    # Left Button Path
    def choose_left(self):
        self.label.config(text="You find a flowing river. Drink or Keep Walking?")
        self.left_button.config(text="Drink", command=self.drink)
        self.right_button.config(text="Keep Walking", command=self.keep_walking)

    def choose_right(self):
        self.label.config(text="You see glowing eyes… it’s a wolf! Fight or Run?")

    def drink(self):
        self.label.config(text="The water was poisoned! Game Over.")
        self.left_button.config(text="Play Again", command=self.play_again)
        self.right_button.config(text="Quit", command=self.quit)

    def keep_walking(self):
        self.label.config(text="You discover a hidden village. Good Ending!")
        self.left_button.config(text="Play Again", command=self.play_again)
        self.right_button.config(text="Quit", command=self.quit)

    # Rifht Button Path
    def choose_right(self):
        self.label.config(text="You see glowing eyes… it’s a wolf! Fight or Run?")
        self.left_button.config(text="Fight", command=self.fight)
        self.right_button.config(text="Run", command=self.run)

    def fight(self):
        self.label.config(text="The wolf overpowers you. Game Over")
        self.left_button.config(text="Play Again", command=self.play_again)
        self.right_button.config(text="Quit", command=self.quit)

    def run(self):
        self.label.config(text="You escape and see two another path: left or right?")
        self.left_button.config(text="Left", command=self.run_left)
        self.right_button.config(text="Right", command=self.run_right)

    def run_left(self):
        self.label.config(text="You stumble upon a pack of wolves. You got mauled and Died. Game Over.")
        self.left_button.config(text="Play Again", command=self.play_again)
        self.right_button.config(text="Quit", command=self.quit)

    def run_right(self):
        self.label.config(text="You find the way out of the forest. You Win!")
        self.left_button.config(text="Play Again", command=self.play_again)
        self.right_button.config(text="Quit", command=self.quit)

    def play_again(self):
        self.label.config(text="You find yourself in a dark forest. Two paths lie ahead. Left or Right?")
        self.left_button.config(text="Left", command=self.choose_left)
        self.right_button.config(text="Right", command=self.choose_right)

    def quit(self): 
        self.root.quit()

root = tkinter.Tk()
InteractiveStory(root)

CenterWindow.center_window(root, 500, 300)
root.mainloop()