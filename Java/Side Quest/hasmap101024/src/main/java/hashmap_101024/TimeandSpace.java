package hashmap_101024;

import java.util.HashMap;
import java.util.Hashtable;
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
        size *= 2; 
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
        size *= 2;
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
        size *= 2; 
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

public class TimeandSpace {
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

        int choice;
        do {
            System.out.println(Green + "\nChoose an operation:" + White);
            System.out.println("1. Insert");
            System.out.println("2. Search");
            System.out.println("3. Delete");
            System.out.println("4. Display Division Hash Table");
            System.out.println("5. Display Mid-Square Hash Table");
            System.out.println("6. Display Folding Hash Table");
            System.out.println(Red + "7. Compare Time Complexity with Java HashMap");
            System.out.println("8. Exit" + White);
            System.out.print(Blue + "\nEnter your choice: " + White);
            choice = scanner.nextInt();

            switch (choice) {
                case 1:
                    System.out.print(Green + "\nEnter key: " + White);
                    int insertKey = scanner.nextInt();
                    System.out.print(Green + "Enter value: " + White);
                    int insertValue = scanner.nextInt();

                    long divisionStartTime = System.nanoTime();
                    divisionHashTable.insert(insertKey, insertValue);
                    long divisionEndTime = System.nanoTime();
                    System.out.println("Division Method Insertion Time: " + (divisionEndTime - divisionStartTime) + " ns");

                    long midSquareStartTime = System.nanoTime();
                    midSquareHashTable.insert(insertKey, insertValue);
                    long midSquareEndTime = System.nanoTime();
                    System.out.println("Mid-Square Method Insertion Time: " + (midSquareEndTime - midSquareStartTime) + " ns");

                    long foldingStartTime = System.nanoTime();
                    foldingHashTable.insert(insertKey, insertValue);
                    long foldingEndTime = System.nanoTime();
                    System.out.println("Folding Method Insertion Time: " + (foldingEndTime - foldingStartTime) + " ns");
                    break;

                case 2:
                    System.out.print(Green + "\nEnter key to search: " + White);
                    int searchKey = scanner.nextInt();

                    long divisionSearchStartTime = System.nanoTime();
                    Integer searchResultDivision = divisionHashTable.search(searchKey);
                    long divisionSearchEndTime = System.nanoTime();
                    System.out.println("Division Method Search Time: " + (divisionSearchEndTime - divisionSearchStartTime) + " ns");
                    System.out.println("Search Result: " + (searchResultDivision != null ? searchResultDivision : "Not found"));

                    long midSquareSearchStartTime = System.nanoTime();
                    Integer searchResultMidSquare = midSquareHashTable.search(searchKey);
                    long midSquareSearchEndTime = System.nanoTime();
                    System.out.println("Mid-Square Method Search Time: " + (midSquareSearchEndTime - midSquareSearchStartTime) + " ns");
                    System.out.println("Search Result: " + (searchResultMidSquare != null ? searchResultMidSquare : "Not found"));

                    long foldingSearchStartTime = System.nanoTime();
                    Integer searchResultFolding = foldingHashTable.search(searchKey);
                    long foldingSearchEndTime = System.nanoTime();
                    System.out.println("Folding Method Search Time: " + (foldingSearchEndTime - foldingSearchStartTime) + " ns");
                    System.out.println("Search Result: " + (searchResultFolding != null ? searchResultFolding : "Not found"));
                    break;

                case 3:
                    System.out.print(Green + "\nEnter key to delete: " + White);
                    int deleteKey = scanner.nextInt();

                    long divisionDeleteStartTime = System.nanoTime();
                    divisionHashTable.delete(deleteKey);
                    long divisionDeleteEndTime = System.nanoTime();
                    System.out.println("Division Method Deletion Time: " + (divisionDeleteEndTime - divisionDeleteStartTime) + " ns");

                    long midSquareDeleteStartTime = System.nanoTime();
                    midSquareHashTable.delete(deleteKey);
                    long midSquareDeleteEndTime = System.nanoTime();
                    System.out.println("Mid-Square Method Deletion Time: " + (midSquareDeleteEndTime - midSquareDeleteStartTime) + " ns");

                    long foldingDeleteStartTime = System.nanoTime();
                    foldingHashTable.delete(deleteKey);
                    long foldingDeleteEndTime = System.nanoTime();
                    System.out.println("Folding Method Deletion Time: " + (foldingDeleteEndTime - foldingDeleteStartTime) + " ns");
                    break;

                case 4:
                    divisionHashTable.display();
                    break;

                case 5:
                    midSquareHashTable.display();
                    break;

                case 6:
                    foldingHashTable.display();
                    break;

                case 7:
                    System.out.println(Red + "Comparing time complexity with Java HashMap..." + White);
                    
                    HashMap<Integer, String> javaHashMap = new HashMap<>((int) size, (float) loadFactor);
                    
                    long javaStartTime = System.nanoTime();
                    for (int i = 0; i < 1000; i++) {
                        javaHashMap.put(i, "Value" + i);
                    }
                    long javaEndTime = System.nanoTime();
                    System.out.println("Java HashMap Insertion time: " + (javaEndTime - javaStartTime) / 1_000_000.0 + " milliseconds");
                    
                    long javaSearchStartTime = System.nanoTime();
                    for (int i = 0; i < 1000; i++) {
                        javaHashMap.get(i);
                    }
                    long javaSearchEndTime = System.nanoTime();
                    System.out.println("Java HashMap Search time: " + (javaSearchEndTime - javaSearchStartTime) / 1_000_000.0 + " milliseconds");
                    
                    long javaDeleteStartTime = System.nanoTime();
                    for (int i = 0; i < 1000; i++) {
                        javaHashMap.remove(i);
                    }
                    long javaDeleteEndTime = System.nanoTime();
                    System.out.println("Java HashMap Deletion time: " + (javaDeleteEndTime - javaDeleteStartTime) / 1_000_000.0 + " milliseconds");
                    
                    System.out.println("Java HashMap Total Space Usage: " + (javaHashMap.size() * (Integer.BYTES + 20)) / 1024.0 + " KB"); // Rough estimate
                    break;

                case 8:
                    System.out.println(Red + "Exiting..." + White);
                    break;

                default:
                    System.out.println(Red + "Invalid choice, please try again." + White);
            }
        } while (choice != 8);

        scanner.close();
    }
}

