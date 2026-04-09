//! Creational design pattern
//! Factory
//! Authentication

// this pattern is used when you have a superclass with multiple subclasses and based on input, you need to return one of the subclasses.
// basically, it moves the responsibility of initializing a new class from the client to a particular factory class.
// so it's just a class that takes the input and returns the appropriate object based on your input.

// a real life example
// a restaurant kitchen. you order a meal (e.g., burger, pizza) from the waiter.
// the waiter passes the order to the kitchen (the factory). the kitchen decides which chef prepares your meal based on the order type.
// you don't need to know the specific chef, you just get the meal you asked for.

// in this example i use different authentication methods
// we have a base abstract class AuthenticationProvider that defines the authenticate method.
// concrete classes (GoogleAuthentication, etc.) implement this method.
// the AuthenticationFactory class takes the requested method as a string and instantiates the proper authentication provider.
// this centralizes the creation logic and makes it easy to add new authentication providers in the future without modifying the client code.

//! pitfalls
// 1. it violates the open/closed principle if the factory method needs to be modified every time a new class is added.
// 2. it can lead to an explosion of subclasses if the hierarchy is already complex.

// the abstract class defining the common authentication interface
abstract class AuthenticationProvider {
  // the method that will be implemented by specific authentication providers
  void authenticate(String email, String password);
}

// concrete subclass implementing the Google authentication
class GoogleAuthentication extends AuthenticationProvider {
  @override
  void authenticate(String email, String password) {
    print('Successfully logged in with google $email account');
  }
}

// concrete subclass implementing the Apple authentication
class AppleAuthentication extends AuthenticationProvider {
  @override
  void authenticate(String email, String password) {
    print('Successfully logged in with apple $email account');
  }
}

// concrete subclass implementing the Facebook authentication
class FacebookAuthentication extends AuthenticationProvider {
  @override
  void authenticate(String email, String password) {
    print('Successfully logged in with facebook $email account');
  }
}

// the factory class that creates the authentication objects based on the input
class AuthenticationFactory {
  // a static method to create the authentication provider
  static AuthenticationProvider create(String method) {
    // it uses a switch case to determine which concrete class to instantiate
    switch (method) {
      case 'Google':
        return GoogleAuthentication();
      case 'Apple':
        return AppleAuthentication();
      case 'Facebook':
        return FacebookAuthentication();
      default:
        throw Exception('Not a Valid Provider');
    }
  }
}

void main() {
  // the client asks the factory for a specific authentication provider
  // the client doesn't need to instantiate the AppleAuthentication directly
  AuthenticationProvider provider = AuthenticationFactory.create('Apple');

  // calls the common method from the interface
  provider.authenticate('mahmoud@gmail.com', '12345678');
}
