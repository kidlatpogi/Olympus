# Countdown Timer
from colorama import Fore, init

init(autoreset=True)

num = int(input("Enter a number to start the countdown: "))

for i in range(num, -1, -1):
    print(Fore.GREEN + str(i))
    if i == 0:
        print(Fore.RED + "BOOOOOOOOM!!!!!!!!!!!!!")