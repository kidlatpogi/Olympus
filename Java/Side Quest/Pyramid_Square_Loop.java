import java.util.*;
public class Pyramid_Square_Loop {

    public static void main(String[] args) {
        
        Scanner scanner = new Scanner(System.in);

        // Pyramid
        System.out.print("Enter the number of rows: ");
        int rows = scanner.nextInt();
        for(int i = 0; i < rows; i++){
            for (int j = 0;j <= i;j++) {
                System.out.print("+ ");
            }
            System.out.println();
        }

        // Reverse Pyramid
        System.out.print("\nEnter the number of rows: ");
        int rows2 = scanner.nextInt();
        for(int i = rows2; i >= 1; i--){
            for (int j = 0;j < i; j++) {
                System.out.print("# ");
            }
            System.out.println();
        }
        // int rows2 = 3
        // i >= j (false) = ### 3
        // i >= j (false) = ## 3-1
        // i >= j (fale) = # 3-2
        // i >= j (false) = 3-3

        // Square
        System.out.print("\nEnter the number of rows: ");
        int rows3 = scanner.nextInt();
        for(int i = 0; i <= rows3; i++){
            for (int j = 0;j < rows3; j++) {
                System.out.print("= ");
            }
            System.out.println();
        }
    }
    
}
