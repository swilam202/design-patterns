//! Behavioral design pattern
//! observer
//! Weather

// the observer pattern is used to notify the observers about the changes in the subject
// think of it like state management bloc for example in flutter
// you save which widgets are listening to the state
// and notify them when the state changes

// in this example i have a weather subject
// and i have three observers phone, computer, tv
// when the weather changes i notify all the observers

//! pitfalls
// 1. Tight Coupling

// the observer interface
abstract class Observer {
  void update(String newState);
}

// the subject interface
abstract class Subject {
  // the listeners or observers which are listening to the subject
  List<Observer> _listeners = [];

  // add the observer to the list
  void attach(Observer observer) {
    _listeners.add(observer);
  }

  // remove the observer from the list
  void detach(Observer observer) {
    _listeners.remove(observer);
  }

  // notify all the observers
  void notifyListeners(String newState) {
    // iterate over the listeners and notify them all
    for (Observer observer in _listeners) {
      observer.update(newState);
    }
  }

  // set the new state of the subject
  void setState(String newState);
}

// the subject class
class Weather extends Subject {
  // the current state of the subject
  String? state;

  @override
  void setState(String newState) {
    // update the current state of the subject
    state = newState;
    // and notify all the observers
    notifyListeners(newState);
  }
}

// the observer class
class PhoneObserver extends Observer {
  //what to do when the state changes
  @override
  void update(String newState) {
    print('Phone got the new weather state: $newState');
  }
}

class ComputerObserver extends Observer {
  @override
  void update(String newState) {
    print('Computer got the new weather state: $newState');
  }
}

class TVObserver extends Observer {
  @override
  void update(String newState) {
    print('TV got the new weather state: $newState');
  }
}

void main() {
  // the observers
  final Observer phone = PhoneObserver();
  final Observer computer = ComputerObserver();
  final Observer tv = TVObserver();

  // the subject
  final Subject weather = Weather();

  // add the observers or the listeners to the subject list
  weather.attach(phone);
  weather.attach(computer);
  weather.attach(tv);

  // change the state of the subject
  weather.setState('The current temperature is 30 degrees');
}
