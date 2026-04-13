//! Creational design pattern
//! Prototype
//! User

// this pattern is used when you want to create a copy of an existing object
// without making the code depend on its concrete class.
// instead of instantiating a new object from scratch, you clone an existing one.
// this is especially useful when object creation is expensive or complex,
// and you want a new object that starts with the same state as an existing one.

// a real life example
// a document editor. instead of building a new document template from scratch every time,
// you clone a pre-configured template object that already has all the formatting,
// fonts, and layout set up.
// you get a fresh copy that you can then modify independently without affecting the original.

// in this example we use a User object
// we have a base abstract class called Prototype
// it declares a clone() method that every concrete class must implement.
// the User class implements Prototype and returns a new User
// with the same firstName and lastName as the original.
// the client code just calls clone() on any existing object to get a copy —
// no need to know the concrete class or call its constructor directly.

//! pitfalls
// 1. cloning objects that have circular references can be tricky.
// 2. deep vs shallow copy: if your object contains nested objects (like a List or another class),
//    a naive clone() only copies the reference, not the nested object itself.
//    you must manually deep-clone every nested field to avoid shared mutable state.
// 3. unlike factory or builder, the prototype pattern depends on having an existing object
//    to clone from — you still need to create the first instance the normal way.

// the base abstract class that defines the cloning contract.
// any class that wants to be cloneable must extend this and implement clone().
abstract class Prototype {
  Prototype clone();
}

// a concrete class that implements the Prototype contract.
// User holds simple value fields, so clone() can safely copy them directly.
class User extends Prototype {
  final String firstName;
  final String lastName;

  User({required this.firstName, required this.lastName});

  // creates and returns a new User instance with the same field values.
  // the caller gets an independent object — changes to the clone
  // won't affect the original, and vice versa.
  @override
  Prototype clone() {
    return User(firstName: firstName, lastName: lastName);
  }
}

void main() {
  // create the original object the normal way — you always need a starting instance.
  User user = User(firstName: 'Mahmoud', lastName: 'Swilam');

  // clone it — no constructor call, no knowledge of the concrete class needed.
  // we cast to User because clone() returns the base Prototype type.
  User user2 = user.clone() as User;

  // both objects hold the same values but are completely independent instances.
  print(user.lastName); // Swilam
  print(user2.lastName); // Swilam
}
