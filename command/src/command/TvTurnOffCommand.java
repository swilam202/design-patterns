
package command;

public class TvTurnOffCommand implements Command{
      Tv tv;
    public TvTurnOffCommand(Tv tv){
        this.tv = tv;
    }
    
    @Override
    public void execute() {
        tv.turn_off();
    }
}
