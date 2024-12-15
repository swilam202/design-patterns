
package chain_of_responsibilites;

import java.util.Scanner;

/*
The Chain of Responsibility is a Behavioral Design Pattern.

the main idea of this pattern is that when the user sends a request it doesn't matter which node will responde
and also nodes doesn't care about how the reques is sent
here an example of an employee asking for a bouns
depending on how much the bonus amout each node has it's maximum limit of accepting bounus
*/
public class Main {

    public static void main(String[] args) {
        
        Scanner input = new Scanner(System.in);
        
        messageing m1 = new ceo();
        messageing m2 = new supervisor(m1);
        messageing m3 = new manager(m2);
        
        System.out.println("How much bonus you want? ");
        int amount = input.nextInt();
        
        m3.ask_for_bonus(amount);
        
       
        
    }
    
}
