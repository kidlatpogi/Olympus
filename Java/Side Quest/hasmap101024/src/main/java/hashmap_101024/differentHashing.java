package hashmap_101024;

import java.util.Hashtable;
import java.util.Scanner;

public class differentHashing {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.print("Enter the hash table size: ");
        int tableSize = scanner.nextInt(); 
        System.out.println("Choose hashing technique:");
        System.out.println("1. Division Method");
        System.out.println("2. Mid-Square Method");
        System.out.println("3. Folding Method");
        int technique = scanner.nextInt();
        
        switch (technique) {
            case 1:
                HashTableDivision divisionTable = new HashTableDivision(tableSize);
                manageHashTable(scanner, divisionTable);
                break;

            case 2:
                HashTableMidSquare midSquareTable = new HashTableMidSquare(tableSize);
                manageHashTable(scanner, midSquareTable);
                break;

            case 3:
                HashTableFolding foldingTable = new HashTableFolding(tableSize);
                manageHashTable(scanner, foldingTable);
                break;

            default:
                System.out.println("Invalid technique selected.");
                break;
        }

        scanner.close();
    }

    private static void manageHashTable(Scanner scanner, HashTableInterface table) {
        int choice;
        do {
            System.out.println("\nChoose an operation:");
            System.out.println("1. Insert");
            System.out.println("2. Search");
            System.out.println("3. Delete");
            System.out.println("4. Display Hash Table");
            System.out.println("5. Exit");
            System.out.print("Enter your choice: ");
            choice = scanner.nextInt();

            switch (choice) {
                case 1:
                    System.out.print("Enter key: ");
                    int key = scanner.nextInt();
                    System.out.print("Enter value: ");
                    int value = scanner.nextInt();
                    table.insert(key, value);
                    break;
                case 2:
                    System.out.print("Enter key to search: ");
                    int searchKey = scanner.nextInt();
                    Integer searchValue = table.search(searchKey);
                    if (searchValue != null) {
                        System.out.println("Value: " + searchValue);
                    }
                    break;
                case 3:
                    System.out.print("Enter key to delete: ");
                    int deleteKey = scanner.nextInt();
                    table.delete(deleteKey);
                    break;
                case 4:
                    table.display();
                    break;
                case 5:
                    System.out.println("Exiting...");
                    break;
                default:
                    System.out.println("Invalid choice. Please try again.");
            }
        } while (choice != 5);
    }
}

interface HashTableInterface {
    void insert(int key, int value);
    Integer search(int key);
    void delete(int key);
    void display();
}

// Division method
class HashTableDivision implements HashTableInterface {
    private final int size;
    private final Hashtable<Integer, Integer> table;

    public HashTableDivision(int size) {
        this.size = size;
        this.table = new Hashtable<>(size);
    }

    private int hashFunction(int key) {
        return Math.abs(key % size);  
    }

    public void insert(int key, int value) {
        int hash = hashFunction(key);
        table.put(hash, value); 
        System.out.println("Inserted (" + key + ", " + value + ") at bucket: " + hash);
    }

    public Integer search(int key) {
        int hash = hashFunction(key);
        if (table.containsKey(hash)) {
            return table.get(hash);
        } else {
            System.out.println("Key " + key + " not found.");
            return null;
        }
    }

    public void delete(int key) {
        int hash = hashFunction(key);
        if (table.containsKey(hash)) {
            table.remove(hash);
            System.out.println("Deleted key " + key + " from bucket " + hash);
        } else {
            System.out.println("Key " + key + " not found.");
        }
    }

    public void display() {
        System.out.printf("%-10s %-10s %-15s %-10s%n", "Key", "Value", "Key HashCode", "Bucket");
        for (Integer key : table.keySet()) {
            int hash = hashFunction(key);
            System.out.printf("%-10d %-10d %-15d %-10d%n", key, table.get(key), key.hashCode(), hash);
        }
    }
}

// Folding method
class HashTableFolding implements HashTableInterface {
    private final int size;
    private final Hashtable<Integer, Integer> table;

    public HashTableFolding(int size) {
        this.size = size;
        this.table = new Hashtable<>(size);
    }

    public void insert(int key, int value) {

        String keyStr = String.valueOf(key);
        int sum = 0;

        for (int i = 0; i < keyStr.length(); i += 3) {
            String part = keyStr.substring(i, Math.min(i + 3, keyStr.length()));
            sum += Integer.parseInt(part); 
        }

        int hash = sum % size;
        table.put(hash, value); 
        System.out.println("Inserted (" + key + ", " + value + ") at bucket: " + hash);
    }

    public Integer search(int key) {
        String keyStr = String.valueOf(key);
        int sum = 0;


        for (int i = 0; i < keyStr.length(); i += 3) {
            String part = keyStr.substring(i, Math.min(i + 3, keyStr.length()));
            sum += Integer.parseInt(part); 
        }

        int hash = sum % size; 
        if (table.containsKey(hash)) {
            return table.get(hash);
        } else {
            System.out.println("Key " + key + " not found.");
            return null;
        }
    }

    public void delete(int key) {

        String keyStr = String.valueOf(key);
        int sum = 0;


        for (int i = 0; i < keyStr.length(); i += 3) {
            String part = keyStr.substring(i, Math.min(i + 3, keyStr.length()));
            sum += Integer.parseInt(part); 
        }

        int hash = sum % size; 
        if (table.containsKey(hash)) {
            table.remove(hash);
            System.out.println("Deleted key " + key + " from bucket " + hash);
        } else {
            System.out.println("Key " + key + " not found.");
        }
    }

    public void display() {
        System.out.printf("%-10s %-10s %-15s %-10s%n", "Key", "Value", "Key HashCode", "Bucket");
        for (Integer key : table.keySet()) {
            String keyStr = String.valueOf(key);
            int sum = 0;

            for (int i = 0; i < keyStr.length(); i += 3) {
                String part = keyStr.substring(i, Math.min(i + 3, keyStr.length()));
                sum += Integer.parseInt(part);
            }

            int hash = sum % size; 
            System.out.printf("%-10d %-10d %-15d %-10d%n", key, table.get(key), key.hashCode(), hash);
        }
    }
}

// Midsquare method
class HashTableMidSquare implements HashTableInterface {
    private final int size;
    private final Hashtable<Integer, Integer> table;

    public HashTableMidSquare(int size) {
        this.size = size;
        this.table = new Hashtable<>(size);
    }

    public void insert(int key, int value) {
        long keySquare = (long) key * key;
        String strKeySquare = Long.toString(keySquare); 
        int mid = strKeySquare.length() / 2; 
        
        String midDigits;
        if (strKeySquare.length() % 2 == 0) {
            midDigits = strKeySquare.substring(mid - 1, mid + 1); 
        } else {
            
            midDigits = strKeySquare.substring(mid, mid + 2); 
        }

        long hashValue = Long.parseLong(midDigits); 
        int hash = (int) (hashValue % size); 
        table.put(hash, value); 
        System.out.println("Inserted (" + key + ", " + value + ") at bucket: " + hash);
    }

    public Integer search(int key) {
        long keySquare = (long) key * key; 
        String strKeySquare = Long.toString(keySquare); 
        int mid = strKeySquare.length() / 2; 
        
        String midDigits;
        if (strKeySquare.length() % 2 == 0) {
            
            midDigits = strKeySquare.substring(mid - 1, mid + 1); 
        } else {
            
            midDigits = strKeySquare.substring(mid, mid + 2); 
        }

        long hashValue = Long.parseLong(midDigits); 
        int hash = (int) (hashValue % size); 
        if (table.containsKey(hash)) {
            return table.get(hash);
        } else {
            System.out.println("Key " + key + " not found.");
            return null;
        }
    }

    public void delete(int key) {
        long keySquare = (long) key * key; 
        String strKeySquare = Long.toString(keySquare); 
        int mid = strKeySquare.length() / 2; 
        
        String midDigits;
        if (strKeySquare.length() % 2 == 0) {

            midDigits = strKeySquare.substring(mid - 1, mid + 1);
        } else {

            midDigits = strKeySquare.substring(mid, mid + 2);
        }

        long hashValue = Long.parseLong(midDigits); 
        int hash = (int) (hashValue % size); 
        if (table.containsKey(hash)) {
            table.remove(hash);
            System.out.println("Deleted key " + key + " from bucket " + hash);
        } else {
            System.out.println("Key " + key + " not found.");
        }
    }

    public void display() {
        System.out.printf("%-15s %-15s %-20s %-15s %-20s%n", "Key", "Value", "Key HashCode", "Key Square", "Mid Square Bucket");
        for (Integer key : table.keySet()) {
            long keySquare = (long) key * key; 
            String strKeySquare = Long.toString(keySquare); 
            int mid = strKeySquare.length() / 2; 
            
            
            String midDigits;
            if (strKeySquare.length() % 2 == 0) {
                
                midDigits = strKeySquare.substring(mid - 1, mid + 1); 
            } else {
                
                midDigits = strKeySquare.substring(mid, mid + 2); 
            }

            long hashValue = Long.parseLong(midDigits);
            System.out.printf("%-15d %-15d %-20d %-15d %-20d%n", key, table.get(key), key.hashCode(), keySquare, (hashValue % size));
        }
    }
}
