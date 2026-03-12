
package chain_of_responsibilites;

/// have less authorities than the ceo

public class supervisor implements messageing{
    int max = 50000;
    messageing msg;

    supervisor(messageing msg){
        this.msg = msg;
    }

    @Override
    public void ask_for_bonus(int bonus) {
        if(bonus < max){
            System.out.println("Bonus was accepted by Supervisor");
        }
        else{
            msg.ask_for_bonus(bonus);
        }
    }

  
    
}
