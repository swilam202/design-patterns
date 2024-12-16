
package command;

public class Tv implements Device{

    @Override
    public void turn_on() {
        System.out.println("Tv is truned on!");
    }

    @Override
    public void turn_off() {
         System.out.println("Tv is truned off!"); 
    }
    
}
