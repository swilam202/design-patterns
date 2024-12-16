
package command;

public class FridgeTurnOffCommand implements Command{

    Fridge fridge;
    public FridgeTurnOffCommand(Fridge fridge){
        this.fridge = fridge;
    }
    
    @Override
    public void execute() {
        fridge.turn_off();
    }
    
}
