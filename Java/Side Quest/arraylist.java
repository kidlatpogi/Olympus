import java.util.*;
public class arraylist {

    public static void main(String[] args) {
        
        Scanner scanner = new Scanner(System.in);

        ArrayList<String> cars = new ArrayList<String>();
        cars.add("BMW");
        cars.add("Volvo");
        cars.add("Ford");
        cars.add("Audi");
        System.out.println(cars);
        
        while (true) { 
            
            System.out.println("\n");
            System.out.println("Type 1 to ADD");
            System.out.println("Type 2 to DELETE");
            System.out.println("Type 3 to EXIT");

            int choose = scanner.nextInt();

            switch (choose) {

                case 1:{
                // Scanner of newCar
                    System.out.print("\nEnter the new car: ");
                    String newCar = scanner.next();

                    // add new car in the arraylist
                    cars.add(newCar);

                    // print the new cars
                    System.out.println("\nThe new Cars are: ");
                    System.out.println("\n");

                    for (int i = 0; i < cars.size(); i++) {
                        System.out.println(cars.get(i));
                    }
                    continue;
                }

                case 2:{
                    // Scanner of deleteCar
                    System.out.print("\nEnter the car you want to delete: ");
                    String deleteCar = scanner.next();

                    // delete the car in the arraylist CAR EQUALS TO deletecar
                    cars.remove(deleteCar);

                    System.out.println("\nThe new Cars are: ");
                    System.out.println("\n");
                    for (int i = 0; i < cars.size(); i++) {
                        System.out.println(cars.get(i));
                    }
                    continue;
                }

                case 3:{

                    System.out.println("\nThe new Cars are: ");
                    System.out.println("\n");
                    for (int i = 0; i < cars.size(); i++) {
                        System.out.println(cars.get(i));
                    }

                    System.exit(choose);

                }
                }
        }
    }
    
}
