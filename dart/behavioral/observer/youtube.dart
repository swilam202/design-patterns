//! Behavioral design pattern
//! observer
//! youtube

// the observer pattern is used to notify the observers about the changes in the subject
// think of it like state management bloc for example in flutter
// you save which widgets are listening to the state
// and notify them when the state changes

// in this example i have a youtube cannel subject
// and i have 4 observers > Ahmed, Ali, Mostafa, Mohammed > (Subscribers)
// they are subscribed to the youtube cannel subject
// and when the youtube cannel subject changes state(new video uploaded, new event)
// it notifies all the subscribers about the new state change

//! pitfalls
// 1. Tight Coupling

// the observer interface
abstract class Observer {
  // the name of the subscriber to identify it
  final String observerName;

  Observer(this.observerName);

  // the update method which will be called when the youtube cannel state changes
  void update(String newState);
}

// the subject interface
abstract class Subject {
  // the subscribers or observers which are subscribed to the youtube cannel
  List<Observer> _listeners = [];

  // add the subscriber to the listeners list
  void attach(Observer observer) {
    _listeners.add(observer);
  }

  // remove the subscriber from the listeners list
  void detach(Observer observer) {
    _listeners.remove(observer);
  }

  // notify all the subscribers about the new state change of the youtube cannel
  void notifyListeners(String newState) {
    // iterate over the subscribers and notify them all
    for (Observer observer in _listeners) {
      observer.update(newState);
    }
  }

  // set the new state of the youtube cannel
  void setState(String newState);
}

// the subject class
class Youtube extends Subject {
  // the current state of the youtube cannel
  String? state;

  @override
  void setState(String newState) {
    // update the current state of the youtube cannel
    state = newState;
    // notify all the subscribers about the new state change
    notifyListeners(newState);
  }
}

// the observer class
class Subscriber extends Observer {
  Subscriber(String name) : super(name);

  @override
  void update(String newState) {
    // print the new state changes in the subscriber to the console
    print('${super.observerName} got the message: $newState');
  }
}

void main() {
  // the subscribers
  final Observer listener1 = Subscriber('Ahmed');
  final Observer listener2 = Subscriber('Ali');
  final Observer listener3 = Subscriber('Mostafa');
  final Observer listener4 = Subscriber('Mohammed');

  // the youtube cannel subject
  final Subject youtube = Youtube();

  // add the subscribers to the youtube cannel listeners list
  youtube.attach(listener1);
  youtube.attach(listener2);
  youtube.attach(listener3);
  youtube.attach(listener4);

  // change the state of the youtube cannel subject
  youtube.setState('New video uploaded!');
}
