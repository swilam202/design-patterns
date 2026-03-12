//! Behavioral design pattern
//! Strategy
//! Payment

// this pattern is used to define a family of algorithms, encapsulate each one, and make them interchangeable
// strategy lets the algorithm vary independently from clients that use it
// it is useful when you have multiple algorithms for a specific task and the client decides which algorithm to use at runtime

// a real life example
// traveling to an airport. you can take a bus, a taxi, or ride a bicycle
// you choose the transportation strategy based on specific factors like budget or time constraints
// the destination is identical, but the route and cost vary between strategies

// another real life example
// the car centers
// if you want to disassemble a car you can get a worker and tell him how every car is disassembled
// and this will be too many workload on the worker
// instead you get an engineer
// the engineer splits every disassemble strategy into separate algorithms
// and then hands the worker the the algorithm that he will use to work

// in this example i use a payment processor
// an order can be paid using different payment methods (PayPal, Credit Card, VCash)
// instead of writing different if-else or switch cases inside the order to process the payment
// the order delegates the payment processing to a payment method object which follows a common interface
// this is better because every payment method has different required data like card requires card number
// wallets requires phone number etc...
// so the solution is to make every payment has it's own separate algorithm
// and the order just calls the algorithm that the user chooses

//! pitfalls
// 1. clients must be aware of different strategies and understand how they differ to select the right one
// 2. increases the number of objects in an application as each strategy is a new class

// the strategy interface common to all supported algorithms
// the context uses this interface to call the algorithm defined by a concrete strategy
abstract class PaymentMethod {
  void pay(double amount);
}

// strategy implementing a specific algorithm (PayPal payment)
class PayPalPayment implements PaymentMethod {
  // the payPal requires only the email
  String email;
  PayPalPayment(this.email);

  // here it handles the payment process
  @override
  void pay(double amount) {
    print('Paid $amount from PayPal account "$email"');
  }
}

// strategy implementing a specific algorithm (Credit Card payment)
class CreditCardPayment implements PaymentMethod {
  // the credit card requires only the card number
  String card;
  CreditCardPayment(this.card);

  // here it handles the payment process
  @override
  void pay(double amount) {
    print('Paid $amount from credit card "$card"');
  }
}

// strategy implementing a specific algorithm (Vodafone Cash payment)
class VCashPayment implements PaymentMethod {
  // the vCash requires only the phone number
  String phoneNumber;
  VCashPayment(this.phoneNumber);

  // here it handles the payment process
  @override
  void pay(double amount) {
    print('Paid $amount from Vodafone wallet "$phoneNumber"');
  }
}

// the context class
// the order class takes the payment method selected by the user
// and make the checkout with it
class Order {
  // the reference to a strategy
  final PaymentMethod _method;
  Order(this._method);

  // calls the payment method to process the payment
  void checkout(double amount) {
    _method.pay(amount);
  }
}

void main() {
  // instantiate different payment strategies
  PaymentMethod payPal = PayPalPayment('user@example.com');
  PaymentMethod creditCard = CreditCardPayment('0000 0000 0000 0000');
  PaymentMethod vCash = VCashPayment('01123456789');

  // order context configured with the credit card strategy
  Order order = Order(creditCard);
  // executes the payment strategy
  order.checkout(500);
}
