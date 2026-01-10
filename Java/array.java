import java.util.*;
public class array {
    
    public static void main(String[] args) {
        
        Scanner scanner = new Scanner(System.in);
        String cars[] = {"BMW", "Volvo", "Ford", "Tesla", "Audi"};

        
        while(true){
            
            System.out.println("Type 1 to ADD");
            System.out.println("Type 2 to DELETE");
            System.out.println("Type 3 to EXIT");
            int choose = scanner.nextInt();

            switch (choose) {
                case 1:

                    System.out.print("\nEnter the new car: ");
                    String newCar = scanner.next();

                    // mag a-add ng bagong element kay array
                    String[] temp = new String[cars.length + 1];

                    // copy the elements of the cars array to the temp array
                    // this is done in order to add the new element to the end of the array
                    for(int i = 0; i < cars.length; i++){
                        temp[i] = cars[i];
                    }

                    // add the new car to the end of the array
                    temp[cars.length] = newCar;

                    // assign the temp array to the cars array
                    cars = temp;

                    // print the cars and the new car
                    System.out.println("\nThe new Cars are: ");
                    for(int i = 0; i <cars.length; i++){
                        System.out.println(cars[i]);
                    }
                    
                    continue;

                case 2:

                    System.out.print("\nEnter the car you want to delete: ");
                    String deleteCar = scanner.next();

                    // if the car to be deleted is the last element in the array
                    // create a new array with a length one less than the current array
                    if(deleteCar == cars[cars.length - 1]){
                        String[] temp2 = new String[cars.length - 1];
                    }

                    // loop through the array and check if the current element is equal to the car to be deleted
                    // if it is, shift all the elements after it to the left by one position
                    for(int i = 0; i < cars.length; i++){
                        if(cars[i] == deleteCar){
                            for(int j = i; j < cars.length - 1; j++){
                                cars[j] = cars[j + 1];
                            }
                        }
                    }

                    // print the cars
                    System.out.println("\nThe new Cars are: ");
                    for(int i = 0; i <cars.length; i++){
                        System.out.println(cars[i]);
                    }

                    continue;

                case  3:

                // print the cars
                for(int i = 0; i <cars.length; i++){
                    System.out.println("\n");
                    System.out.println(cars[i]);
                }

                // exit the program
                System.exit(choose);
            }

        }


    }
    
}
