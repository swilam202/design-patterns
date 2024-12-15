
package chain_of_responsibilites;

/// the CEO has all the authorities

public class ceo implements messageing{
    
    
    public ceo(){
    }
    
    int max = 100000;

    @Override
    public void ask_for_bonus(int bonus) {
        if(bonus < max){
            System.out.println("Bonus was accepted by CEO");;
        }
        else{
            System.out.println("Too much to accept");;
        }
    }
     
}
