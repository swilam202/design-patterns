
package command;


/*

 */
public class Main {

    public static void main(String[] args) {
        
        Fridge f = new Fridge();
        Tv t = new Tv();
        
        Command cfo = new FridgeTurnOffCommand(f);
        Command cff = new FridgeTurnOffCommand(f);
        Command cto = new TvTurnOffCommand(t);
        Command ctf = new TvTurnOffCommand(t);
        
        Remote r = new Remote();
        r.execute(cfo);
    }
    
}
