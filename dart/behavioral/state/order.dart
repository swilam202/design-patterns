//! Behavioral design pattern
//! State
//! Order

// this pattern is used to allow an object to alter its behavior when its internal state changes
// the object will appear to change its class
// it is useful when an object's behavior depends on its state, and it must change its behavior at run-time depending on that state

// a real life example
// if you have certain books shelf
// and when the reader told you to get the next book
// it's very time consuming if you do it in the if else solution
// the if else solution if the book is science then the next book is math
// if the book is math then the next is english
// it's not very good solution instead
// in each book store it's next
// so that when the reader told you to get the next book
// you know it you don't have to search

// in this example i use an order workflow
// an order goes through different states (Idle, Shipping, Delivered)
// moving to the next state depends on the current state of the order
// instead of having huge switch statements, each state is a class that knows how to move to the next state

//! pitfalls
// 1. the state pattern can lead to a large number of classes if the object has many states


// the order class or called the context
// it holds the order state
class Order {
  // the current state of the order, initially set to Idle
  State _state = IdleState();

  // used to change the state by the state classes themselves
  void setState(State newState) {
    _state = newState;
  }

  // makes the current state calls it's next
  // without the context knowing the next state
  // thanks to this pattern each state knows what is the next state
  void moveNext() {
    _state.nextState(this);
  }

  // returns the current state status message
  String getStatus() {
    return 'the order is ${_state.name}';
  }
}

// this is the base state class
abstract class State {
  // the name of the state
  final String name;

  // method to go to the next state of the order
  void nextState(Order order);

  State(this.name);
}

// concrete state representing an idle order
class IdleState extends State {
  IdleState() : super('Idle');

  @override
  void nextState(Order order) {
    // moves the order to the next state which is Shipping
    order.setState(ShippingState());
  }
}

// concrete state representing a shipping order
class ShippingState extends State {
  ShippingState() : super('Shipping');

  @override
  void nextState(Order order) {
    // moves the order to the next state which is Delivered
    order.setState(DeliveredState());
  }
}

// concrete state representing a delivered order
class DeliveredState extends State {
  DeliveredState() : super('Delivered');

  @override
  void nextState(Order order) {
    // no next state since delivered is the final state
  }
}

void main() {
  // the order context which holds the current state
  Order order = Order();

  // moves from Idle to Shipping state
  order.moveNext();
  // prints the current state: the order is Shipping
  print(order.getStatus());

  // moves from Shipping to Delivered state
  order.moveNext();
  // prints the current state: the order is Delivered
  print(order.getStatus());
}
