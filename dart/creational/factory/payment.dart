//! Creational design pattern
//! Factory
//! Payment

// this pattern is used when you have a superclass with multiple subclasses and based on input, you need to return one of the subclasses.
// basically, it moves the responsibility of initializing a new class from the client to a particular factory class.
// so it's just a class that takes the input and returns the appropriate object based on your input.

// a real life example
// a logistics company. initially they only use trucks for land transportation.
// later they want to add sea transportation using ships.
// instead of changing the whole code to accommodate ships, they use a factory to create transport objects (trucks and ships)
// based on the transportation type needed.

// in this example i use different payment methods
// we have a base abstract class called PaymentService
// and several concrete implementations like PayPalPayment, CreditCardPayment, etc.
// the PaymentFactory class has a static method createPaymentService that takes a string input
// and returns the corresponding PaymentService implementation object.
// the client code doesn't need to know the specific class, it just asks the factory for a payment service.

//! pitfalls
// 1. the code may become more complicated since you need to introduce new subclasses to implement the pattern.
// 2. the factory method can become a large switch-case statement if there are many types of objects to create.

// the abstract class defining the common interface for all payment services
abstract class PaymentService {
  // the method that will be implemented by specific payment methods
  void pay(double amount);
}

// concrete subclass implementing the PayPal payment
class PayPalPayment extends PaymentService {
  @override
  void pay(double amount) {
    print('Paid $amount from PayPal');
  }
}

// concrete subclass implementing the Credit Card payment
class CreditCardPayment extends PaymentService {
  @override
  void pay(double amount) {
    print('Paid $amount from Credit Card');
  }
}

// concrete subclass implementing the Apple Pay payment
class ApplePayPayment extends PaymentService {
  @override
  void pay(double amount) {
    print('Paid $amount from Apple Pay');
  }
}

// concrete subclass implementing the Google Pay payment
class GooglePayPayment extends PaymentService {
  @override
  void pay(double amount) {
    print('Paid $amount from Google Pay');
  }
}

// the factory class that creates the payment objects based on the input
class PaymentFactory {
  // a static method to create the payment service
  static PaymentService createPaymentService(String service) {
    // it uses a switch case to determine which concrete class to create
    switch (service) {
      case 'PayPal':
        return PayPalPayment();
      case 'Credit Card':
        return CreditCardPayment();
      case 'Apple Pay':
        return ApplePayPayment();
      case 'Google Pay':
        return GooglePayPayment();
      default:
        throw Exception('Invalid payment method');
    }
  }
}

void main() {
  // the client asks the factory for a specific payment method
  // the client doesn't need to instantiate the GooglePayPayment directly
  PaymentService payment = PaymentFactory.createPaymentService('Google Pay');

  // calls the common method from the interface
  payment.pay(200);
}
