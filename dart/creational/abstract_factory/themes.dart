//! Creational design pattern
//! Abstract Factory
//! Themes

// this pattern is used when you need to create families of related or dependent objects
// without specifying their concrete classes.
// basically, it provides an interface for creating a group of related objects,
// leaving the actual creation process to the concrete factory classes.
// so instead of just creating one type of object (like the Factory Method),
// it creates an entire family of objects that go together.

// a real life example
// a furniture shop that sells chairs, sofas, and coffee tables.
// they have different styles: modern, victorian, and art deco.
// instead of selling a modern chair with an art deco sofa, you want matching sets.
// you use an abstract factory (FurnitureFactory) to get a family of matching furniture pieces.
// the concrete factories (ModernFurnitureFactory, VictorianFurnitureFactory) create the matching sets.

// in this example i use UI themes (Light and Dark)
// we have a family of products: Button and Dialog.
// these are the abstract classes defining the common interface for UI elements.
// we have concrete implementations for LightTheme (LightButton, LightDialog)
// and DarkTheme (DarkButton, DarkDialog).
// the ThemeFactory abstract class declares the creation methods for the whole family of products.
// the concrete factories (LightTheme, DarkTheme) implement these methods to create the matching UI elements.
// the client code (UIBuilder) doesn't need to know the specific UI element classes,
// it just asks the factory for the elements, and it's guaranteed they will match the chosen theme.

//! pitfalls
// 1. introducing a new product to an existing family is difficult because you need to update the
// abstract factory interface and all of its concrete implementations.
// 2. the code may become more complicated than it should be, since you introduce many new interfaces and classes.

// the abstract classes defining the common interface for the UI elements
abstract class Button {
  // the method that will be implemented by specific buttons
  void render();
}

abstract class Dialog {
  // the method that will be implemented by specific dialogs
  void show();
}

// concrete subclass implementing the light button
class LightButton extends Button {
  @override
  void render() {
    print('Rendered light button');
  }
}

// concrete subclass implementing the dark button
class DarkButton extends Button {
  @override
  void render() {
    print('Rendered dark button');
  }
}

// concrete subclass implementing the light dialog
class LightDialog extends Dialog {
  @override
  void show() {
    print('Showed light dialog');
  }
}

// concrete subclass implementing the dark dialog
class DarkDialog extends Dialog {
  @override
  void show() {
    print('Showed dark dialog');
  }
}

// the abstract factory class that declares methods to create a family of products
abstract class ThemeFactory {
  // methods to create abstract products
  Button createButton();
  Dialog createDialog();
}

// concrete factory implementing the creation methods for the light theme family
class LightTheme extends ThemeFactory {
  @override
  Button createButton() {
    return LightButton();
  }

  @override
  Dialog createDialog() {
    return LightDialog();
  }
}

// concrete factory implementing the creation methods for the dark theme family
class DarkTheme extends ThemeFactory {
  @override
  Button createButton() {
    return DarkButton();
  }

  @override
  Dialog createDialog() {
    return DarkDialog();
  }
}

// the client code that builds the UI using the factory
class UIBuilder {
  // it takes the abstract factory as an argument and builds elements using it
  static void build(ThemeFactory theme) {
    // creating matching products from the same family
    final Button button = theme.createButton();
    final Dialog dialog = theme.createDialog();

    button.render();
    dialog.show();
  }
}

void main() {
  // the client asks the factory to create a matching theme
  ThemeFactory theme = DarkTheme();

  // the client code doesn't need to know the specific UI element classes
  UIBuilder.build(theme);
}
