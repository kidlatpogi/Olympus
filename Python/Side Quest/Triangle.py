
print("----------------------------------------------------------------------------")
#Pyramid
print("This program will print a Pyramid based on the number input of the user")
Pyramid = int(input("Enter the Number: "))
print("The entered number is " , Pyramid)
print()

for i in range(Pyramid):
    for j in range(i + 1):
        print("*"  , end = " ")
    print()

print("----------------------------------------------------------------------------")
#reverse Pyramid
print("This program will print a reverse Pyramid based on the number input of the user")
reversedPyramid = int(input("Enter the Number: "))
print("The entered number is " , reversedPyramid)
print()

for k in range(reversedPyramid, 0 , -1):
    for l in range(0, k):
        print("+" , end = " ")
    print()

print("----------------------------------------------------------------------------")
#Square
print("This program will print a square based on the number input of the user")
square = int(input("Enter a Number: "))
print("The entered number is " , square)
print()

for n in range(square):
    for m in range(square):
        print("□" , end=" ")
    print()
