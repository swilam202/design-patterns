
package observer;

import java.util.Scanner;

/**

 */
public class Main {

    public static void main(String[] args) {
        
        Scanner input = new Scanner(System.in);
        
        Subject w = new Weather();
     
        
        Observer[] citizens = {new Citizen(),new Citizen(),new Citizen(),new Citizen(),};
        
        for(int i = 0;i < citizens.length;i++){
            w.add_observer(citizens[i]);
        }

        System.out.println("Enter the new weather");
        String new_weather = input.next();
        
        w.set_state(new_weather);
        
        
    }
    
}
