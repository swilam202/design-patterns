//! Structural design pattern
//! Decorator
//! Coffee

// this pattern is used to attach new behaviors or responsibilities to an object
// dynamically, without modifying its class or using subclassing.
// decorators wrap an existing object, implement the same interface,
// and add their own behavior before or after delegating to the wrapped object.
// this allows behaviors to be stacked in any combination at runtime.

// a real life example
// think of ordering a pizza: you start with a base pizza and then add toppings one by one —
// extra cheese, mushrooms, olives. each topping wraps the previous state,
// adding its own cost and description on top without changing
// how the pizza itself was made.

// in this example i use a coffee ordering system
// we start with a plain SimpleCoffee that has a fixed description and price.
// instead of creating subclasses for every possible combination
// (CoffeeWithMilk, CoffeeWithSugar, CoffeeWithMilkAndSugar, etc.),
// we use decorators that wrap the coffee object and extend it dynamically.
// MilkDecorator wraps any Coffee and adds "+ milk" to the description and +5 to the price.
// SugarDecorator wraps any Coffee and adds "+ sugar" to the description and +2 to the price.
// decorators can be stacked in any order, giving us flexible combinations at runtime.

//! pitfalls
// 1. stacking many decorators can make the object hard to inspect or debug,
//    since the actual type is hidden behind several layers of wrappers.
// 2. the order in which decorators are applied matters and can produce different results.

// the component interface — defines the contract that all coffees and decorators must follow
// this shared interface is what allows decorators to be used interchangeably with real coffees
abstract class Coffee {
  String get description;
  int get price;
}

// the concrete component — the base object being decorated
// it represents the simplest form of coffee with no additions
class SimpleCoffee extends Coffee {
  @override
  String get description => 'Simple coffee';

  @override
  int get price => 10;
}

// the base decorator — implements the Coffee interface and wraps another Coffee object
// it doesn't add behavior itself; concrete decorators extend this to add their own
abstract class CoffeeDecorator implements Coffee {
  // the wrapped coffee — can be a SimpleCoffee or another decorator (enabling stacking)
  final Coffee _coffee;

  CoffeeDecorator(this._coffee);
}

// a concrete decorator — adds milk to any coffee it wraps
// it extends the wrapped coffee's description and increases its price
class MilkDecorator extends CoffeeDecorator {
  MilkDecorator(Coffee coffee) : super(coffee);

  @override
  // delegates to the wrapped coffee then appends its own addition
  String get description => '${_coffee.description} with milk';

  @override
  // delegates to the wrapped coffee's price and adds the milk surcharge
  int get price => _coffee.price + 5;
}

// a concrete decorator — adds sugar to any coffee it wraps
class SugarDecorator extends CoffeeDecorator {
  SugarDecorator(Coffee coffee) : super(coffee);

  @override
  // delegates to the wrapped coffee then appends its own addition
  String get description => '${_coffee.description} with sugar';

  @override
  // delegates to the wrapped coffee's price and adds the sugar surcharge
  int get price => _coffee.price + 2;
}

void main() {
  // start with the base object — a plain coffee (price: 10)
  Coffee coffee = SimpleCoffee();
  print('Description: ${coffee.description}, Price: ${coffee.price}');

  // wrap it with MilkDecorator — the decorator adds its behavior on top (price: 15)
  coffee = MilkDecorator(coffee);
  print('Description: ${coffee.description}, Price: ${coffee.price}');

  // wrap it again with SugarDecorator — stacking a second layer of behavior (price: 17)
  // each call to description or price cascades through all decorator layers
  coffee = SugarDecorator(coffee);
  print('Description: ${coffee.description}, Price: ${coffee.price}');
}
