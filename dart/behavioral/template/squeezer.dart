//! Behavioral design pattern
//! Template Method
//! Squeezer

// this pattern is used if you have different objects but they share a common steps
// so instead of making each object separately
// you define the common steps in a base class
// and you make the sub classes implement the steps that are different

// a real life example
// building a house. the steps for building a house are generally the same (foundation, walls, roof)
// however, the materials or specific implementations for each step might differ (wooden walls vs brick walls)
// the base builder defines the template (the order of steps), and specific builders implement the details

// in this example i use a fruit squeezer
// the process of squeezing juice is an algorithm (grab fruit, prepare fruit, squeeze fruit, brew)
// the order of these steps (the template method) is fixed in the base Squeezer class
// but the 'prepareFruit' step varies depending on the fruit type (cutting orange, peeling banana)
// each specific squeezer overrides prepareFruit to implement the specific fruit preparation
// and the other steps are shared

//! pitfalls
// 1. template methods tend to be harder to maintain the more steps they have
// 2. you might violate the Liskov Substitution Principle by suppressing a default step implementation via a subclass

// the abstract class defining the template method and the steps of the algorithm
abstract class Squeezer {
  // the name of the fruit
  final String fruitName;

  Squeezer(this.fruitName);

  // a concrete step already implemented by the base class
  void grabFruit() {
    print('Grabbing $fruitName');
  }

  // an abstract step that MUST be implemented by subclasses
  // this is where the variation happens
  void prepareFruit();

  // another concrete step
  void squeezeFruit() {
    print('Squeezing $fruitName');
  }

  // another concrete step
  void brew() {
    print('brewing $fruitName');
  }

  // this is the method to be called by squeezers to make juice
  // it outlines the steps of the algorithm and their exact execution order
  // subclasses cannot override this method because it's the core skeleton
  void prepare() {
    grabFruit();
    prepareFruit();
    squeezeFruit();
    brew();
  }
}

// concrete subclass implementing the variant steps for Orange
class OrangeSqueezer extends Squeezer {
  OrangeSqueezer() : super('Orange');

  // implements the abstract step
  // the oranges needs to be cut in half in order to be squeezed
  @override
  void prepareFruit() {
    print('Cutting orange in half');
  }
}

// concrete subclass implementing the variant steps for Banana
class BananaSqueezer extends Squeezer {
  BananaSqueezer() : super('Banana');

  // the bananas needs to be peeled in order to be squeezed
  @override
  void prepareFruit() {
    print('Peeling banana');
  }
}

// concrete subclass implementing the variant steps for Strawberry
class StrawberrySqueezer extends Squeezer {
  StrawberrySqueezer() : super('Strawberry');

  // the strawberries needs to be hull in order to be squeezed
  @override
  void prepareFruit() {
    print('Hulling strawberry');
  }
}

void main() {
  // instantiate different squeezers types
  Squeezer orange = OrangeSqueezer();
  Squeezer banana = BananaSqueezer();
  Squeezer strawberry = StrawberrySqueezer();

  // executing the template method on the banana squeezer
  banana.prepare();
}
