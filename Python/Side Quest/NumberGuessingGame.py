# Number Guessing Game

import random

randomNumber = random.randint(1, 10)
guess = int(input("Guess a number between 1 and 10: "))

for attempt in range(3):
    if guess < randomNumber:
        print("Too low!")
    elif guess > randomNumber:
        print("Too high!")
    else:
        print("Congratulations! You've guessed the number!")
        break
    if attempt < 2:
        guess = int(input("Try again: "))