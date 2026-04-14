//! Structural design pattern
//! Adapter
//! User

// this pattern is used when you have incompatible interfaces that need to work together.
// basically, it acts as a middleman that translates requests from a client to a format
// that a service class can understand.
// so it's just a wrapper class that catches calls and transforms them into a recognizable format.

// a real life example
// a power supply adapter. you travel from the US to Europe, but the wall sockets are different.
// you can't plug your laptop directly into the European socket.
// instead, you use an adapter that has an American socket on one side and a European plug on the other.

// in this example i use different API responses for user data
// we have a unified User class that our application expects.
// however, we receive data from two different APIs with different structures.
// we define an abstract UserAdaptor interface with a getUser() method.
// then we create concrete adapters (API1Adaptor, API2Adaptor) that map the specific API fields
// to the properties expected by our standard User class.
// the client code can now simply call getUser() on any adapter to get a consistently formatted User object.

//! pitfalls
// 1. the overall complexity of the code increases because you need to introduce new interfaces and classes.
// 2. sometimes it's simpler to change the service class so that it matches the rest of your code.

// hypothetical API 1 response format:
//{
//   "name": "Ahmed",
//   "age": 25
// }

// hypothetical API 2 response format:
//   {
//   "full_name": "Ahmed Ali",
//   "years": 25
// }

// the target class that our application works with
class User {
  final String name;
  final int age;

  User(this.name, this.age);
  @override
  String toString() {
    return 'User(Name: $name, Age: $age)';
  }
}

// the abstract target interface defining the common method for getting a user
abstract class UserAdaptor {
  User getUser();
}

// concrete adapter subclass connecting API 1 response to the User class
class API1Adaptor extends UserAdaptor {
  final String name;
  final int age;

  API1Adaptor({required this.name, required this.age});

  @override
  User getUser() {
    return User(name, age);
  }
}

// concrete adapter subclass connecting API 2 response to the User class
class API2Adaptor extends UserAdaptor {
  final String fullName;
  final int years;

  API2Adaptor({required this.fullName, required this.years});

  @override
  User getUser() {
    return User(fullName, years);
  }
}

void main() {
  // the client code works with adapters to get consistently formatted user objects
  final API1Adaptor api1adaptor = API1Adaptor(name: 'Mahmoud', age: 24);
  final API2Adaptor api2adaptor = API2Adaptor(
    fullName: 'Mahmoud Swilam',
    years: 24,
  );

  print(api1adaptor.getUser());
  print(api2adaptor.getUser());
}
