
package observer;

import java.util.ArrayList;
import java.util.List;

public class Weather implements Subject{
    private List<Observer> observers = new ArrayList();
    
    String weather_state;

    @Override
    public void add_observer(Observer observer) {
        observers.add(observer);
    }

    @Override
    public void remove_observer(Observer observer) {
        observers.remove(observer);
    }

    @Override
    public void set_state(String new_weather) {
        weather_state = new_weather;
        notify_observers();
        
    }

    @Override
    public void notify_observers() {
        for(Observer observer : observers){
            observer.update_weather(weather_state);
        }
    }
    
   
}
