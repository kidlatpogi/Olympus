import random
from re import match
from unittest import case
from colorama import Fore, init
import time

# 6 in 1 Application
# Multiplication Generator
# Number Guessing Game
# Odd or Even
# Simple Countdown
# Sum of N
# Triangle Patterns

# Multiplication Generator
def multiplication_generator(num):

    for i in range(1, 11):
        print(f"{num} x {i} = {num * i}")

# Number Guessing Game
def number_guessing_game():
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

# Odd or Even
def odd_or_even():
    num = int(input("Enter a number to check if it's odd or even: "))
    if num % 2 == 0:
        print(f"{num} is Even.")
    else:
        print(f"{num} is Odd.")

# Simple Countdown
def simple_countdown():
    init(autoreset=True)

    num = int(input("Enter a number to start the countdown: "))

    for i in range(num, -1, -1):
        print(Fore.GREEN + str(i))
        if i == 0:
            print(Fore.RED + "BOOOOOOOOM!!!!!!!!!!!!!")

# Sum of N
def sum_of_n():
    num = int(input("Enter a positive integer: "))

    for i in range(1, num + 1):
        print(f"{num} + {i} = {num + i}")

# Triangle Patterns
def triangle_patterns():
    Pyramid = int(input("Enter the height of the pyramid: "))
    print()

    for i in range(Pyramid):
        for j in range(i + 1):
            print("*"  , end = " ")
        print()

print(Fore.GREEN+ "----------------------------------------------------------------------------")
print("Welcome to the 6 in 1 Application!")
print("Choose a program to run (1-7): ")
print("----------------------------------------------------------------------------" + Fore.RESET)
print(Fore.BLUE+ "----------------------------------------------------------------------------")
print("1. Multiplication Generator")
print("2. Number Guessing Game")
print("3. Odd or Even")
print("4. Simple Countdown")
print("5. Sum of N")
print("6. Triangle Patterns" + Fore.RESET)
print(Fore.RED + "7. Exit" + Fore.RESET)
print(Fore.BLUE + "----------------------------------------------------------------------------" + Fore.RESET)

choice = int(input("Enter the number of the Application (1-6):"))
print("\nLoading...\n")

time.sleep(0.5)

while choice != 7:
    match choice:
        case 1:
            print(Fore.CYAN + "-> Multiplication Generator\n" + Fore.RESET)
            num = int(input("Enter a number to generate its multiplication table:"))
            print()
            multiplication_generator(num)

        case 2:
            print(Fore.CYAN + "-> Number Guessing Game\n" + Fore.RESET)
            number_guessing_game()

        case 3:
            print(Fore.CYAN + "-> Odd or Even\n" + Fore.RESET)
            odd_or_even()

        case 4:
            print(Fore.CYAN + "-> Simple Countdown\n" + Fore.RESET)
            simple_countdown()

        case 5:
            print(Fore.CYAN + "-> Sum of N\n" + Fore.RESET)
            sum_of_n()

        case 6:
            print(Fore.CYAN + "-> Triangle Patterns\n" + Fore.RESET)
            triangle_patterns()

        case _:
            print(Fore.RED + "Invalid choice. Please select a number between 1 and 6." + Fore.RESET)

    choice = int(input("\nEnter the number of the Application (1-6): "))

    print("\nLoading...\n")
    time.sleep(0.5)

print(Fore.RED + "-> Application Exited... Goodbye!" + Fore.RESET)
exit()