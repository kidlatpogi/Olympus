package hashmap_101024;

import java.util.Hashtable;
import java.util.LinkedList;
import java.util.Scanner;

// Division Method
class DivisionHashTable {
    private Hashtable<Integer, Integer> table;
    private int size;
    private int count;
    private double loadFactor;

    public DivisionHashTable(int size, double loadFactor) {
        this.size = size;
        this.loadFactor = loadFactor;
        this.table = new Hashtable<>(size);
        this.count = 0;
    }

    public void insert(int key, int value) {
        if ((double) count / size >= loadFactor) {
            resize();
        }
        table.put(key, value);
        count++;
    }

    public Integer search(int key) {
        return table.get(key);
    }

    public void delete(int key) {
        if (table.remove(key) != null) {
            count--;
        }
    }

    private void resize() {
        size *= 2; // Double the size
        Hashtable<Integer, Integer> newTable = new Hashtable<>(size);
        for (Integer key : table.keySet()) {
            newTable.put(key, table.get(key));
        }
        table = newTable;
    }

    public void display() {
        System.out.println("\nDivision Method Hash Table:");
        System.out.println("Key\tValue\tKey HashCode\tBucket");
        for (Integer key : table.keySet()) {
            int bucket = key % size; 
            System.out.println(key + "\t" + table.get(key) + "\t" + key.hashCode() + "\t\t" + bucket);
        }
    }
}

// Mid-Square Method 
class MidSquareHashTable {
    private Hashtable<Integer, Integer> table;
    private int size;
    private int count;
    private double loadFactor;

    public MidSquareHashTable(int size, double loadFactor) {
        this.size = size;
        this.loadFactor = loadFactor;
        this.table = new Hashtable<>(size);
        this.count = 0;
    }

    public void insert(int key, int value) {
        if ((double) count / size >= loadFactor) {
            resize();
        }
        table.put(key, value);
        count++;
    }

    public Integer search(int key) {
        return table.get(key);
    }

    public void delete(int key) {
        if (table.remove(key) != null) {
            count--;
        }
    }

    private void resize() {
        size *= 2; // Double the size
        Hashtable<Integer, Integer> newTable = new Hashtable<>(size);
        for (Integer key : table.keySet()) {
            newTable.put(key, table.get(key));
        }
        table = newTable;
    }

    public void display() {
        System.out.println("\nMid-Square Method Hash Table:");
        System.out.println("Key\tValue\tKey HashCode\tKey Square\tMid Square Bucket");
        for (Integer key : table.keySet()) {
            long keySquare = key * key;
            String strKeySquare = Long.toString(keySquare);
            int mid = strKeySquare.length() / 2; 
            String midDigits;
            if (strKeySquare.length() % 2 == 0) {
                midDigits = strKeySquare.substring(mid - 1, mid + 1); 
            } else {
                midDigits = strKeySquare.substring(mid, Math.min(mid + 2, strKeySquare.length())); 
            }

            long hashValue = Long.parseLong(midDigits); 
            long bucket = hashValue % size; 
            System.out.println(key + "\t" + table.get(key) + "\t" + key.hashCode() + "\t\t" + keySquare + "\t\t" + bucket);
        }
    }
}

// Folding Method 
class FoldingHashTable {
    private Hashtable<Integer, Integer> table;
    private int size;
    private int count;
    private double loadFactor;

    public FoldingHashTable(int size, double loadFactor) {
        this.size = size;
        this.loadFactor = loadFactor;
        this.table = new Hashtable<>(size);
        this.count = 0;
    }

    public void insert(int key, int value) {
        if ((double) count / size >= loadFactor) {
            resize();
        }
        table.put(key, value);
        count++;
    }

    public Integer search(int key) {
        return table.get(key);
    }

    public void delete(int key) {
        if (table.remove(key) != null) {
            count--;
        }
    }

    private void resize() {
        size *= 2; // Double the size
        Hashtable<Integer, Integer> newTable = new Hashtable<>(size);
        for (Integer key : table.keySet()) {
            newTable.put(key, table.get(key));
        }
        table = newTable;
    }

    public void display() {
        System.out.println("\nFolding Method Hash Table:");
        System.out.println("Key\tValue\tKey HashCode\tBucket\tFolding Method");
        for (Integer key : table.keySet()) {
            String keyStr = key.toString();
            int sum = 0;
            for (int i = 0; i < keyStr.length(); i += 3) {
                String part = keyStr.substring(i, Math.min(i + 3, keyStr.length()));
                sum += Integer.parseInt(part);
            }
            int bucket = sum % size;
            System.out.println(key + "\t" + table.get(key) + "\t" + key.hashCode() + "\t\t" + bucket + "\t" + sum);
        }
    }
}

// Chaining Method
class Chaining {
    private LinkedList<Entry>[] table;
    private int size;

    public Chaining(int size) {
        this.size = size;
        table = new LinkedList[size];
    }

    private int hashFunction(int key) {
        return key % size;
    }

    public void put(int key, int value) {
        int index = hashFunction(key);
        if (table[index] == null) {
            table[index] = new LinkedList<>();
        }
        table[index].add(new Entry(key, value));
    }

    public Integer get(int key) {
        int index = hashFunction(key);
        if (table[index] == null) {
            return null; // Key not found
        }
        for (Entry entry : table[index]) {
            if (entry.key == key) {
                return entry.value;
            }
        }
        return null; // Key not found
    }

    public void remove(int key) {
        int index = hashFunction(key);
        if (table[index] != null) {
            for (int i = 0; i < table[index].size(); i++) {
                if (table[index].get(i).key == key) {
                    table[index].remove(i);
                    break;
                }
            }
        }
    }

    class Entry {
        int key;
        int value;

        public Entry(int key, int value) {
            this.key = key;
            this.value = value;
        }
    }

    public void display() {
        System.out.println("\nChaining Hash Table:");
        System.out.println("Index\tKey\tValue");
        for (int i = 0; i < size; i++) {
            if (table[i] != null) {
                for (Entry entry : table[i]) {
                    System.out.println(i + "\t" + entry.key + "\t" + entry.value);
                }
            }
        }
    }
}

public class chain { // Updated class name to Chaining
    public static final String Blue = "\u001B[34m";
    public static final String Red = "\u001B[31m";
    public static final String Green = "\u001B[32m";
    public static final String White = "\u001B[37m";

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.print(Blue + "\nEnter size of hash table: " + White);
        int size = scanner.nextInt();
        System.out.print(Green + "Enter load factor (e.g., 0.75): " + White);
        double loadFactor = scanner.nextDouble();

        DivisionHashTable divisionHashTable = new DivisionHashTable(size, loadFactor);
        MidSquareHashTable midSquareHashTable = new MidSquareHashTable(size, loadFactor);
        FoldingHashTable foldingHashTable = new FoldingHashTable(size, loadFactor);
        Chaining chainingHashTable = new Chaining(size); // Create an instance of the Chaining hash table

        int choice;
        do {
            System.out.println(Green + "\nChoose an operation:" + White);
            System.out.println("1. Insert");
            System.out.println("2. Search");
            System.out.println("3. Delete");
            System.out.println("4. Display Division Hash Table");
            System.out.println("5. Display Mid-Square Hash Table");
            System.out.println("6. Display Folding Hash Table");
            System.out.println("7. Display Chaining Hash Table"); // Display option for Chaining
            System.out.println(Red + "8. Exit" + White);
            choice = scanner.nextInt();

            switch (choice) {
                case 1: {
                    System.out.print("Enter key: ");
                    int key = scanner.nextInt();
                    System.out.print("Enter value: ");
                    int value = scanner.nextInt();
                    divisionHashTable.insert(key, value);
                    midSquareHashTable.insert(key, value);
                    foldingHashTable.insert(key, value);
                    chainingHashTable.put(key, value); // Insert into Chaining hash table
                    break;
                }
                case 2: {
                    System.out.print("Enter key to search: ");
                    int key = scanner.nextInt();
                    System.out.println("Division Hash Table: " + divisionHashTable.search(key));
                    System.out.println("Mid-Square Hash Table: " + midSquareHashTable.search(key));
                    System.out.println("Folding Hash Table: " + foldingHashTable.search(key));
                    System.out.println("Chaining Hash Table: " + chainingHashTable.get(key)); // Search in Chaining
                    break;
                }
                case 3: {
                    System.out.print("Enter key to delete: ");
                    int key = scanner.nextInt();
                    divisionHashTable.delete(key);
                    midSquareHashTable.delete(key);
                    foldingHashTable.delete(key);
                    chainingHashTable.remove(key); // Remove from Chaining hash table
                    break;
                }
                case 4: {
                    divisionHashTable.display();
                    break;
                }
                case 5: {
                    midSquareHashTable.display();
                    break;
                }
                case 6: {
                    foldingHashTable.display();
                    break;
                }
                case 7: {
                    chainingHashTable.display(); // Display the Chaining hash table
                    break;
                }
                case 8:
                    System.out.println("Exiting...");
                    break;
                default:
                    System.out.println("Invalid choice. Please try again.");
                    break;
            }
        } while (choice != 8);

        scanner.close();
    }
}
