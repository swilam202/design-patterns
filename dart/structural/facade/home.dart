//! Structural design pattern
//! Facade
//! Home

// this pattern is used when you need a simple interface to a complex system of classes, a library, or a framework.
// basically, it provides a simplified higher-level interface that makes the subsystem easier to use.
// so it's just a class that bundles together multiple complex interactions into simple, easy-to-understand methods.

// a real life example
// ordering food at a restaurant. you don't go to the kitchen to talk to the chef, the sous-chef,
// and the dishwasher to coordinate your meal. instead, you interact with the waiter (the facade).
// the waiter takes your simple order and handles all the complex interactions with the kitchen staff on your behalf.

// in this example i use a smart home system
// we have a complex subsystem consisting of several individual devices: TV, Lights, and AC.
// to do a simple task like "returning home", we would normally have to interact with all three devices
// individually (turn on lights, turn on AC, turn on TV, etc.).
// instead, we create a HomeFacade class that wraps these complex interactions.
// it provides straightforward methods like returnHome() and leaveHome() that internally orchestrate the entire subsystem.
// the client code now only needs to interact with the HomeFacade, completely hiding the underlying complexity.

//! pitfalls
// 1. a facade can become a "god object" coupled to all classes of an app if it grows too large.
// 2. it adds an extra layer of abstraction, which might be overkill if the subsystem is already simple enough.

// a complex subsystem component representing a TV
class TV{
  void trunOn(){
    print('TV is turned on!');
  }
  void trunOff(){
    print('TV is turned off!');
  }
  void playMovie(){
    print('Movie is now playing');
  }
  
}

// a complex subsystem component representing Lights
class Lights{
  void turnOn(){
    print('Lights are on');
  }
  void turnOff(){
    print('Lights are off');
  }
}

// a complex subsystem component representing an AC unit
class AC{
  void turnOn(){
    print('AC are on');
  }
  void turnOff(){
    print('AC are off');
  }

  void setTemp(){
    print('AC is set to 24 degress');
  }
}

// the facade class that provides a simple interface to the complex smart home subsystem
class HomeFacade{
  final TV _tv;
  final Lights _lights;
  final AC _ac;

  HomeFacade(this._tv,this._lights,this._ac);

  void returnHome(){
    _lights.turnOn();
    _ac.turnOn();
    _ac.setTemp();
    _tv.trunOn();
    _tv.playMovie();
  }
  
  void leaveHome(){
    _lights.turnOff();
    _ac.turnOff();
    _tv.trunOff();
  }

}

void main(){
  // the client code works with the facade, instead of interacting with the complex subsystem directly
  final TV _tv = TV();
  final AC _ac = AC();
  final Lights _lights = Lights();

  HomeFacade home = HomeFacade(_tv, _lights, _ac);

  home.returnHome();

}