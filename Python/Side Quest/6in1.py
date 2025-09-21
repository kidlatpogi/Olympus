import random
from unittest import case
from colorama import Fore, init

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

print(Fore.GREEN+ "----------------------------------------------------------------------------")
print("Welcome to the 6 in 1 Application!")
print("Choose a program to run (1-7): ")
print("----------------------------------------------------------------------------" + Fore.RESET)

print("1. Multiplication Generator")
print("2. Number Guessing Game")
print("3. Odd or Even")
print("4. Simple Countdown")
print("5. Sum of N")
print("6. Triangle Patterns")
print("7. Exit\n")

choice = int(input("Enter your choice (1-7):"))
print("")

match choice:
    case 1:
        print("Multiplication Generator\n")
        num = int(input("Enter a number to generate its multiplication table: "))
        multiplication_generator(num)
    case 2:
        print("Number Guessing Game\n")
    case 3:
        print("Odd or Even\n")
    case 4:
        print("Simple Countdown\n")
    case 5:
        print("Sum of N\n")
    case 6:
        print("Triangle Patterns\n")
    case 7:
        print("Exiting the application. Goodbye!")
        exit()