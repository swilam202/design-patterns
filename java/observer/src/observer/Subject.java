
package observer;

//the main interface for weather company
public interface Subject {
    //add new citizens
    public void add_observer(Observer observer);
    //remove citizens from the list
    public void remove_observer(Observer observer);
    //change the new weather
    public void set_state(String new_state);
    //tell all citizens about new changes
    public void notify_observers();
}
