
package chain_of_responsibilites;

///has less authorities than the supervisor
public class manager implements messageing{
     int max = 10000;
    messageing msg;

    manager(messageing msg){
        this.msg = msg;
    }

    @Override
    public void ask_for_bonus(int bonus) {
        if(bonus < max){
            System.out.println("Bonus was accepted by Manager");
        }
        else{
            msg.ask_for_bonus(bonus);
        }
    }
}
