
package observer;

import java.util.Scanner;

/*
    The observer design pattern is a behavioral pattern

    this pattern is used to add listerners to something when this thing changes all listeners listen to this change

    it's made of 2 parts 
    the Subject which is the main interface that you want other objects listens to it
    and the Observer which is the interface for objects that listens to the Subject

    the example here is you act as weather company which implements the subject interface to tell people about the current weather
    and the citizen which implements the observer interface to listen for weather changes
    when the weather company changes the current weather it notifiy all registered citizens
 */

public class Main {

    public static void main(String[] args) {
        
        Scanner input = new Scanner(System.in);
        
        // create object of the weather company
        Subject w = new Weather();
     
        // an array of citizens that will register to the weather company
        Observer[] citizens = {new Citizen(),new Citizen(),new Citizen(),new Citizen()};
        
        //iterate on all citizens to register then to the weather company
        for(int i = 0;i < citizens.length;i++){
            w.add_observer(citizens[i]);
        }
        
        //act as weather company and input the new weather to notify ctizens
        System.out.println("Enter the new weather");
        String new_weather = input.next();
        
       //change the current weather with new input
        w.set_state(new_weather);
        
        
    }
    
}
