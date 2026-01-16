package hashmap_101024;
import java.util.Hashtable;
import java.util.Scanner;

public class insertSearchDel {

    public static final String Blue = "\u001B[34m";
    public static final String Red = "\u001B[31m";
    public static final String Green = "\u001B[32m";
    public static final String White = "\u001B[37m";

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        Hashtable<Integer, Integer> hashTable = new Hashtable<>();
        int choice;

        do {
            System.out.println("\nChoose an operation:");
            System.out.println("1. Insert");
            System.out.println("2. Search");
            System.out.println("3. Delete");
            System.out.println("4. Display Hash Table");
            System.out.println("5. Calculate Hash Value");
            System.out.println("6. Exit");
            System.out.print("Enter your choice: ");
            choice = scanner.nextInt();

            switch (choice) {
                case 1:
                    System.out.print(Green + "\nEnter key (integer): " + White);
                    int key = scanner.nextInt();
                    System.out.print(Green + "Enter value (integer): " + White);
                    int value = scanner.nextInt();
                    insert(hashTable, key, value);
                    break;
                case 2:
                    System.out.print(Green + "\nEnter key (integer) to search: " + White);
                    int searchKey = scanner.nextInt();
                    search(hashTable, searchKey);
                    break;
                case 3:
                    System.out.print(Red + "\nEnter key (integer) to delete: " + White);
                    int deleteKey = scanner.nextInt();
                    delete(hashTable, deleteKey);
                    break;
                case 4:
                    System.out.println(White + "\nHash Table Contents: " + hashTable);
                    break;
                case 5:
                    System.out.println("\nChoose a hashing technique:");
                    System.out.println("1. Division Method");
                    System.out.println("2. Mid-Square Method");
                    System.out.println("3. Folding Method");
                    System.out.print("Enter your choice: ");
                    int hashChoice = scanner.nextInt();
                    System.out.print("\nEnter key (integer) to hash: ");
                    int hashKey = scanner.nextInt();
                    switch (hashChoice) {
                        case 1:
                            divisionMethod(hashTable, hashKey);
                            break;
                        case 2:
                            midSquareMethod(hashTable, hashKey);
                            break;
                        case 3:
                            foldingMethod(hashTable, hashKey);
                            break;
                        default:
                            System.out.println(Red + "Invalid choice for hashing technique." + White);
                    }
                    break;
                case 6:
                    System.out.println(Red + "\nExiting...");
                    break;
                default:
                    System.out.println(Red + "\nInvalid choice. Please try again.");
            }
        } while (choice != 6);

        scanner.close();
    }

    public static void insert(Hashtable<Integer, Integer> hashTable, int key, int value) {
        hashTable.put(key, value);
        System.out.println(Green + "\nInserted " + White + "(" + key + ", " + value + ")" + Green +
                " into the hash table." + White);
    }

    public static void search(Hashtable<Integer, Integer> hashTable, int key) {
        if (hashTable.containsKey(key)) {
            System.out.println("Value: " + White + hashTable.get(key));
        } else {
            System.out.println(Red + "No such key in the hash table.");
        }
    }

    public static void delete(Hashtable<Integer, Integer> hashTable, int key) {
        if (hashTable.containsKey(key)) {
            hashTable.remove(key);
            System.out.println(Red + "Deleted " + key + " from the hash table." + White);
        } else {
            System.out.println(Red + "Key not found in the hash table.");
        }
    }

    // Division Method
    public static void divisionMethod(Hashtable<Integer, Integer> hashTable, int key) {
        int size = hashTable.size() > 0 ? hashTable.size() : 1; 
        System.out.println(Blue + "Division Method");
        System.out.println(Red + "Key\tValue\tKey HashCode\tBucket");
        
        for (Integer k : hashTable.keySet()) {
            int bucket = Math.abs(k.hashCode() % size); 
            System.out.println(k + "\t" + hashTable.get(k) + "\t" + k.hashCode() + "\t\t" + bucket);
        }
        System.out.println("Hash value for key " + key + ": " + (Math.abs(key % size)));
    }

    // Mid-Square Method
    public static void midSquareMethod(Hashtable<Integer, Integer> hashTable, int key) {
        int size = hashTable.size() > 0 ? hashTable.size() : 1; 
        System.out.println(Blue + "Mid-Square Method");
        System.out.println(Red + "Key\tValue\tKey HashCode\tKey Square\tMid Square Bucket");
        
        for (Integer k : hashTable.keySet()) {
            long keySquare = (long) k * k;
            String strKeySquare = Long.toString(keySquare);
            
            int mid = strKeySquare.length() / 2;
            String midDigits = strKeySquare.length() > 1 ? strKeySquare.substring(mid - 1, mid + 1) : strKeySquare;
            int bucket = Math.abs(Integer.parseInt(midDigits) % size); // Corrected bucket calculation
            
            System.out.println(k + "\t" + hashTable.get(k) + "\t" + k.hashCode() + "\t\t" + keySquare + "\t\t" + bucket);
        }
        
        long keySquare = (long) key * key;
        String strKeySquare = Long.toString(keySquare);
        int mid = strKeySquare.length() / 2;
        String midDigits = strKeySquare.length() > 1 ? strKeySquare.substring(mid - 1, mid + 1) : strKeySquare;
        int bucket = Math.abs(Integer.parseInt(midDigits) % size);
        System.out.println("Hash value for key " + key + ": " + bucket);
    }

    // Folding Method
    public static void foldingMethod(Hashtable<Integer, Integer> hashTable, int key) {
        int size = hashTable.size() > 0 ? hashTable.size() : 1; 
        System.out.println(Blue + "Folding Method");
        System.out.println(Red + "Key\tValue\tKey HashCode\tBucket\tFolding Method");
        
        for (Integer k : hashTable.keySet()) {
            int sum = 0;
            int tempKey = Math.abs(k); 
            while (tempKey > 0) {
                sum += tempKey % 10;
                tempKey /= 10;
            }
            int bucket = Math.abs(sum % size); 
            
            System.out.println(k + "\t" + hashTable.get(k) + "\t" + k.hashCode() + "\t\t" + bucket + "\t\t" + sum);
        }

        int sum = 0;
        int tempKey = Math.abs(key);
        while (tempKey > 0) {
            sum += tempKey % 10;
            tempKey /= 10;
        }
        int bucket = Math.abs(sum % size);
        System.out.println("Hash value for key " + key + ": " + bucket);
    }
}
