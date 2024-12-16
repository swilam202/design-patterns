
package observer;

public class Citizen implements Observer{
    
    String current_weather;

    @Override
    public void update_weather(String new_weather) {
        current_weather = new_weather;
        print_weather_data();
    }

    @Override
    public void print_weather_data() {
        System.out.println("the current weather now is : " + current_weather);
    }
    
}
