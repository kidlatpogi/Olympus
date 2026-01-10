import java.util.Scanner;

public class BasicActiveRecall {

    public static void main(String[] args) {
        
        String MAINFRAME = "MAINFRAME";
        String MiniComp = "MINICOMPUTER";
        String MicroComp = "MICROCOMPUTER";
        String WorkStation = "WORKSTATION";
        String SuperComp = "SUPERCOMPUTER";
        String PDA = "PERSONAL DIGITAL ASSISTANCE";

        Scanner scanner = new Scanner(System.in);

        System.out.println("\nAnswer all the questions: ");

        int Score = 0;

        while (Score != 6) {
            // Mainframe

            if(Score == 6){
                break;
            }
            System.out.print("It is a machine that handles large amount of data? ");
            String mainframe = scanner.nextLine();
                if (MAINFRAME.equals(mainframe) || mainframe.equals(mainframe.toLowerCase()) || mainframe.equals(mainframe.toUpperCase())) {
                    System.out.println("Correct!");
                    Score++;
                }
                else {
                    System.out.println("Wrong!");
                }

            //Mini Computer
            System.out.print("It is a machine that is used by small industries? ");
            String MINI = scanner.nextLine();
                if (MiniComp.equals(MINI) || MiniComp.equals(MINI.toLowerCase()) || MiniComp.equals(MINI.toUpperCase())) {
                    System.out.println("Correct!");
                    Score++;
                }
                else {
                    System.out.println("Wrong!");
                }

            //Micro Computer
            System.out.print("It is a machine that is used by only one user? ");
            String MICRO = scanner.nextLine();
                if (MicroComp.equals(MICRO) || MicroComp.equals(MICRO.toLowerCase()) || MicroComp.equals(MICRO.toUpperCase())) {
                    System.out.println("Correct!");
                    Score++;
                }
                else {
                    System.out.println("Wrong!");
                }

            //Workstation Computer
            System.out.print("It is a machine that is used by institutions, educational, and government? ");
            String WORK = scanner.nextLine();
                if (WorkStation.equals(WORK) || WorkStation.equals(WORK.toLowerCase()) || WorkStation.equals(WORK.toUpperCase())) {
                    System.out.println("Correct!");
                    Score++;
                }
                else {
                    System.out.println("Wrong!");
                }

            //Super Computer
            System.out.print("It is a machine that is used by to solver complex mathical problems? ");
            String SUPER = scanner.nextLine();
                if (SuperComp.equals(SUPER) || SuperComp.equals(SUPER.toLowerCase()) || SuperComp.equals(SUPER.toUpperCase())) {
                    System.out.println("Correct!");
                    Score++;
                }
                else {
                    System.out.println("Wrong!");
                }

            //PDA Computer
            System.out.print("A small hand held device? ");
            String PERSONALDA = scanner.nextLine();
                if (PDA.equals(PERSONALDA) || PDA.equals(PERSONALDA.toLowerCase()) || PDA.equals(PERSONALDA.toUpperCase())) {
                    System.out.println("Correct!");
                    Score++;
                }
                else {
                    System.out.println("Wrong!");
                }
            
    }

            System.out.println("Your score is: " + Score );
            scanner.close();
}
}