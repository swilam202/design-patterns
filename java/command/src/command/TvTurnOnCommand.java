
package command;

public class TvTurnOnCommand implements Command{

    Tv tv;
    public TvTurnOnCommand(Tv tv){
        this.tv = tv;
    }
    
    @Override
    public void execute() {
        tv.turn_on();
    }
    
}
