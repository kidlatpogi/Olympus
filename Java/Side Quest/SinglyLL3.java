
// Java program to demonstrate the :
// * insertion of an element at the beginning of the list, 
// * insertion at the end of the list, 
// * insertion at a specified position of the list, 
// * deletion from the beginning of the list, 
// * deletion from the end of the list and deletion from the specified position of the list 
// * display the elements of the list as the output on the screen

public class SinglyLL3 {
	//defining a node in singly linked list
	class Node {
		private int data;  private Node next;
		public Node(int data) { this.data = data;
								this.next = null;
		}
	}
    public Node head = null;  
    
    //defining a method to insert an element at the beginning of the list
    public void insertionatthebeginning(int data)   {
        System.out.println("Adding a node at the beginning of the list with data " + data + "\n");

        //creating a new node called newNode 
        Node newNode = new Node(data);
        //checking if the given list is empty 
        if (this.head == null) {
        	//if the list is empty, making the newNode as the head of the list
        	this.head = newNode;
        } else { //otherwise the next pointer of the newNode is made the head
        	newNode.next = this.head;

        	//and then making the newNode as the head of the list
        	this.head = newNode;
        }
    } 

    //defining a method to insert an element at the end of the list
    public void insertionattheend(int data) {
        System.out.println("Adding a node at the end of the list with data " + data + "\n");

        //creating a new node called newNode 
        Node newNode = new Node(data);

        //checking if the given list is empty 
        if (this.head == null) {
        	//if the list is empty, making the newNode as the head of the list
        	this.head = newNode;
        } 
        else {
        	//otherwise create a new node called current and assign head of the list to the current node
        	Node current = this.head;

        	//and traverse till the end of the list
        	while (current.next != null) {
        		//and assign each node to the current node till the last node is reached
        		current = current.next;
        	}

        	//assigning the next pointer of the last node to the newNode
        	current.next = newNode;
        }

    } 

    public void insertionatpos(int position, int data) {
		System.out.println("Adding a node at the specified position " + position + " of the list with data " + data + "\n");
	
		if (position < 1) {
			System.out.println("Position must be greater than 0.\n");
			return;
		}
	
		Node newNode = new Node(data);
	
		if (position == 1) {
			newNode.next = head;
			head = newNode;
			return;
		}
	
		Node current = head;
		for (int i = 1; i < position - 1; i++) {
			if (current == null) {
				System.out.println("The position is out of bounds.\n");
				return;
			}
			current = current.next;
		}
	
		if (current == null) {
			System.out.println("The position is out of bounds.\n");
			return;
		}
	
		newNode.next = current.next;
		current.next = newNode;
	}
	

    //defining a method to delete an element from the beginning of the list
    public void deletionfromthebeginning()    {
         System.out.println("deleting a node from the beginning of the list: \n");

         //checking if the given list is empty
         if (this.head == null) {
        	 System.out.println("The given list is empty.\n");
         } 
         else {
        	 //otherwise removing head and making the first node as the head of the list
        	 head = head.next;
         }

    }

    //defining a method to delete an element from the end of the list
    public void deletionfromtheend() {
         System.out.println("Deleting a node from the end of the list: \n");

         //checking if the given list is empty
         if (this.head == null) {
        	 System.out.println("The given list is empty.\n");
         } 
         else {
        	 // otherwise creating a new node called current and 
        	 // assigning head to it to traverse through the list 
        	 // to reach the second last element of the list and 
        	 // then making its next pointer to point to null

        	 Node current = this.head;
        	 while (current.next.next != null) {
        		 current = current.next;
        	 }
        	 current.next = null;
         }
    }

    //defining a method to delete an element from the specified position of the list
    public void deletionfrompos(int position) {
		System.out.println("Deleting a node from the specified position " + position +  "\n");
	
		if (this.head == null) {
			System.out.println("The given list is empty.\n");
			return;
		}
	
		if (position < 1) {
			System.out.println("Position must be greater than 0.\n");
			return;
		}
	
		if (position == 1) {
			head = head.next;
			return;
		}
	
		Node current = head;
		for (int i = 1; i < position - 1; i++) {
			if (current == null || current.next == null) {
				System.out.println("The position is out of bounds.\n");
				return;
			}
			current = current.next;
		}
	
		if (current.next == null) {
			System.out.println("The position is out of bounds.\n");
			return;
		}
	
		current.next = current.next.next;
	}
	

	//defining displaylist() function to display the data in the list  
    public void displaylist() {
       //checking if the head/list is empty
	   if (this.head == null) {   
		   System.out.println("The given list is empty.\n");
	   } 
	   else {
		   //otherwise printing each element in the list
		   System.out.println("The elements of the Singly Linked List are : \n");		
		   Node current = this.head;
		   while (current != null) {
			   //printing each data in the list and next pointer pointing to the next node  
			   System.out.print(current.data + " -> ");
			   current = current.next;
		   }
		   System.out.println("NULL");
	   }
    }  
    
    public static void main(String[] args)  {
       //defining a new linked list
    	SinglyLL2 newlist = new SinglyLL2();

        //displaying the elements of the list before performing any operation on the list
    	System.out.println("The elements of the singly linked list before insertion operation     are: \n");

    	newlist.displaylist();

    	//performing various operations on the list and then displaying the elements of the list
    	newlist.insertionatthebeginning(1);
    	newlist.displaylist();

    	System.out.println("\n");

    	newlist.insertionatthebeginning(2);
    	newlist.displaylist();

    	System.out.println("\n");
    	newlist.insertionattheend(8);

    	newlist.displaylist();

    	System.out.println("\n");

    	newlist.insertionattheend(9);
    	newlist.displaylist();

    	System.out.println("\n");

        newlist.insertionatpos(2,3);
        newlist.displaylist();

        System.out.println("\n");

        newlist.insertionatpos(3,4);
        newlist.displaylist();

        System.out.println("\n");

        newlist.insertionatpos(4,100);
        newlist.insertionatpos(4,200);
        newlist.insertionatpos(4,300);
        newlist.insertionatpos(4,400);
        newlist.insertionatpos(4,500);
        newlist.displaylist();

        System.out.println("\n");

        newlist.deletionfromthebeginning();
        newlist.displaylist();

        System.out.println("\n");

        newlist.deletionfromtheend();
        newlist.displaylist();

        System.out.println("\n");

        newlist.deletionfrompos(3);
        newlist.displaylist();

        System.out.println("\n");
    }
}