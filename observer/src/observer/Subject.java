
package observer;

public interface Subject {
    public void add_observer(Observer observer);
    public void remove_observer(Observer observer);
    public void set_state(String new_state);
    public void notify_observers();
}
