//! Creational design pattern
//! Builder
//! User

// this pattern is used when you need to create complex objects step by step.
// it separates the construction of a complex object from its representation,
// allowing the same construction process to create different representations.
// it's especially useful when an object has many optional parameters or variations.

// a real life example
// building a custom PC. you can choose different components: CPU, RAM, storage, GPU.
// instead of having one huge constructor that takes all possible parts (many of which might be optional),
// you use a builder. you tell the builder step-by-step: "add i7 CPU", "add 16GB RAM",
// and when you are done, you ask the builder to "build" the final PC.

// in this example i use a User object.
// the User class has multiple fields: firstName, lastName, age, city, and gender.
// passing all these to a standard constructor can become confusing,
// especially if some are optional and you have to pass nulls, mixing up parameter order.
// the UserBuilder class helps us build the User object piece by piece.
// it has methods like setFirstName and setAge, which return the builder instance itself,
// allowing us to chain the method calls elegantly (fluent interface).
// finally, the build() method gathers all the accumulated data and creates the User instance.

//! pitfalls
// 1. the overall complexity of the code increases since the pattern requires creating multiple new classes.
// 2. the builder pattern may be overkill to use if the objects being built are relatively simple.

// the product class that we want to build. it contains many fields.
class User {
  // the attributes of the user
  final String? firstName;
  final String? lastName;
  final int? age;
  final String? city;
  final String? gender;

  // a constructor that takes all the optional parameters to create the user
  User({this.firstName, this.lastName, this.age, this.city, this.gender});

  @override
  String toString() {
    return 'User{firstName: $firstName, lastName: $lastName, age: $age, city: $city, gender: $gender}';
  }
}

// the builder class that contains the step-by-step methods to configure and assemble the User object.
class UserBuilder {
  // properties matching the User class, initially null
  String? _firstName;
  String? _lastName;
  int? _age;
  String? _city;
  String? _gender;

  // builder methods to set individual fields. they return the builder itself to allow method chaining.

  // set the first name and return the builder
  UserBuilder setFirstName(String firstName) {
    _firstName = firstName;
    return this;
  }

  // set the last name and return the builder
  UserBuilder setLastName(String lastName) {
    _lastName = lastName;
    return this;
  }

  // set the age and return the builder
  UserBuilder setAge(int age) {
    _age = age;
    return this;
  }

  // set the city and return the builder
  UserBuilder setCity(String city) {
    _city = city;
    return this;
  }

  // set the gender and return the builder
  UserBuilder setGender(String gender) {
    _gender = gender;
    return this;
  }

  // the final step that constructs the actual product using the accumulated data.
  User build() {
    return User(
      firstName: _firstName,
      lastName: _lastName,
      city: _city,
      gender: _gender,
      age: _age,
    );
  }
}

// the client code that builds the object using the builder.
// we chain the configuration methods and finally call build() to get the result.
void main() {
  // instantiate the builder, chain the needed configurations, and call build at the end
  User user = UserBuilder()
      .setAge(23)
      .setCity('Zayed')
      .setFirstName('Mahmoud')
      .setLastName('Swilam')
      .setGender('Male')
      .build();

  // print the generated user object
  print(user);
}
