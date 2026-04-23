//! Structural design pattern
//! Bridge
//! Shapes

// this pattern is used to split a large class (or a set of closely related classes)
// into two separate hierarchies — abstraction and implementation —
// that can be developed and extended independently of each other.
// instead of binding an abstraction tightly to its implementation through inheritance,
// the abstraction holds a reference to an implementation object and delegates work to it.

// a real life example
// think of a TV remote control (the abstraction) and a TV (the implementation).
// the remote doesn't care which brand of TV it controls — Samsung, LG, Sony.
// you can swap the TV without changing the remote, and you can design a new remote
// without changing the TV. both sides evolve independently through a shared interface.

// in this example i use shapes and colors
// without the bridge pattern, supporting every combination would require a separate class:
// RedCircle, BlueCircle, RedTriangle, BlueTriangle — an explosion of subclasses.
// instead, we split the two dimensions into separate hierarchies:
//   - Shape hierarchy (abstraction): Circle, Triangle
//   - Color hierarchy (implementation): Red, Blue
// Shape holds a reference to a Color object and delegates color application to it.
// this way, you can freely combine any shape with any color without creating new classes.

//! pitfalls
// 1. applying the pattern to a highly cohesive class can make the code more complicated.
// 2. it introduces more interfaces and indirection, which can be harder to follow initially.

// the implementor interface — defines the contract for the implementation side (colors)
// all concrete colors must implement this, so shapes can use any color interchangeably
abstract class Color {
  String applyColor();
}

// a concrete implementor — provides the Blue color implementation
class Blue extends Color {
  @override
  String applyColor() {
    return 'Applied blue color';
  }
}

// a concrete implementor — provides the Red color implementation
class Red extends Color {
  @override
  String applyColor() {
    return 'Applied red color';
  }
}

// the abstraction — defines the high-level shape behavior
// it holds a reference to a Color (the implementor) instead of inheriting from it,
// which is the key idea of the bridge: composition over inheritance
abstract class Shape {
  // the bridge — a reference to the implementation side (Color)
  final Color color;

  // the color is injected at construction time, making it easy to swap
  Shape(this.color);

  void draw();
}

// a refined abstraction — extends Shape with Circle-specific drawing logic
// it doesn't know or care which concrete Color it holds, only that it can applyColor()
class Circle extends Shape {
  Circle(Color color) : super(color);

  @override
  void draw() {
    // delegates color application to the implementor held by the bridge
    print('Drawing ${color.applyColor()} Circle');
  }
}

// a refined abstraction — extends Shape with Triangle-specific drawing logic
class Triangle extends Shape {
  Triangle(Color color) : super(color);

  @override
  void draw() {
    // same delegation pattern — the shape doesn't need to know how colors work
    print('Drawing ${color.applyColor()} Triangle');
  }
}

void main() {
  // combine any shape with any color freely — no new subclass needed
  // a Circle bridged with the Red implementation
  Shape redCircle = Circle(Red());

  // a Triangle bridged with the Blue implementation
  Shape blueTriangle = Triangle(Blue());

  // each shape delegates color rendering to its bridged Color implementor
  redCircle.draw();
  blueTriangle.draw();
}
