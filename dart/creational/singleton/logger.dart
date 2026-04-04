//! Creational design pattern
//! singleton
//! logger

// singleton is a creational design pattern that is used to create only one instance of a class
// its known implementation in flutter is <getIt>
// the use of singleton is no matter how you want to create new instances of a class
// it will always return the same instance

// in this example i have a logger class and i want to create only one instance of it
// no matter how many times i create it
// it always returns the same instance

//! pitfalls
// 1. hard to test

class Logger {
  // here i make the constructor private
  // to prevent creating new instances of the class
  Logger._();

  // here i create a static variable to store the instance if found
  static Logger? _instance;

  // here i create a static getter to get the instance
  // if the instance is null, it will create a new instance
  // else it will return the same instance
  static Logger get instance => _instance ??= Logger._();

  // here i create a method to log messages
  // and i print the hashCode of the instance
  // to make sure it's the same instance
  void log(String message) {
    print('log $message from ${this.hashCode}');
  }
}

void main() {
  // here i create three instances of the logger

  Logger log1 = Logger.instance;
  Logger log2 = Logger.instance;
  Logger log3 = Logger.instance;

  // here i log messages from each instance
  // and i print the hashCode of the instance
  // to make sure it's the same instance
  log1.log('message 1');
  log2.log('message 2');
  log3.log('message 3');
}
