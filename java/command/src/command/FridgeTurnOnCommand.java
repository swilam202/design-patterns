
package command;

public class FridgeTurnOnCommand implements Command{
    
    Fridge fridge;
    public FridgeTurnOnCommand(Fridge fridge){
        this.fridge = fridge;
    }

    @Override
    public void execute() {
        fridge.turn_on();
    }
    
}
