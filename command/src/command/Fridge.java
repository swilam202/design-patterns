
package command;

public class Fridge implements Device{

    @Override
    public void turn_on() {
        System.out.println("Fridge is truned on!");
    }

    @Override
    public void turn_off() {
        System.out.println("Fridge is truned off!");
    }
    
}
