# Multiplication Generator

# Prompt the user to enter a number and convert the input to an integer
num = int(input("Enter a number to generate its multiplication table: "))

# Loop through numbers 1 to 10 (inclusive)
for i in range(1, 11):
    # Print the multiplication result in a formatted string
    print(f"{num} x {i} = {num * i}")