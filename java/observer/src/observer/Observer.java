
package observer;

//the interface for citizens
public interface Observer {
     //update their current weather
     public void update_weather(String new_weather);
     //print the new weather to citizens
     public void print_weather_data();
}
