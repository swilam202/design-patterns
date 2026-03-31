//! Behavioral design pattern
//! Visitor
//! Insurance

// this pattern is used when you need to perform an operation on a group of similar kind of objects
// without changing the classes of the elements on which it operates
// it allows adding new operations to existing object structures without modifying those structures

// a real life example
// an insurance agent visits different types of buildings (residential, bank, cafe)
// each building type requires a different kind of insurance inspection policy
// instead of adding an 'inspect()' method to every building class (which would bloat them and violate Single Responsibility)
// we create a separate InsuranceAgent (Visitor) that travels to each building
// the buildings just need an 'accept()' method to let the agent in

//! pitfalls
// 1. whenever a new element class is added, all visitors need to be updated with a new visit method
// 2. visitors might not have the required access to the private fields and methods of the elements they are supposed to work with

// the visitor interface declaring a visiting method for each concrete element class
abstract class InsuranceAgent {
  final String name;
  InsuranceAgent(this.name);

  void visitResdentialBuilding(ResidentialBuilding building);
  void visitBankBuilding(BankBuilding building);
  void visitCafeBuilding(CafeBuilding building);
}

// the base element interface
abstract class Building {
  final String name;
  Building(this.name);

  // method that takes the base visitor interface as an argument
  // this is the core of the double dispatch mechanism
  void accept(InsuranceAgent agent);
}

// concrete element implementing the accept method
class ResidentialBuilding extends Building {
  ResidentialBuilding(String name) : super(name);

  // redirects the call to the proper visitor's method that corresponds to the current element class
  @override
  void accept(InsuranceAgent agent) {
    agent.visitResdentialBuilding(this);
  }
}

// concrete element implementing the accept method
class BankBuilding extends Building {
  BankBuilding(String name) : super(name);

  @override
  void accept(InsuranceAgent agent) {
    agent.visitBankBuilding(this);
  }
}

// concrete element implementing the accept method
class CafeBuilding extends Building {
  CafeBuilding(String name) : super(name);

  @override
  void accept(InsuranceAgent agent) {
    agent.visitCafeBuilding(this);
  }
}

// concrete visitor implementing different versions of the same behavior
class SpecializedAgent extends InsuranceAgent {
  SpecializedAgent(String name) : super(name);

  @override
  void visitResdentialBuilding(ResidentialBuilding building) {
    print('visited building ${building.name} by $name');
  }

  @override
  void visitBankBuilding(BankBuilding building) {
    print('visited bank ${building.name} by $name');
  }

  @override
  void visitCafeBuilding(CafeBuilding building) {
    print('visited cafe ${building.name} by $name');
  }
}

void main() {
  // instantiate the objects (elements)
  List<Building> area = [
    ResidentialBuilding('villa 141'),
    BankBuilding('Ahly bank'),
    CafeBuilding('Starbucks'),
  ];

  // instantiate the visitor
  InsuranceAgent agent = SpecializedAgent('Agent ali');

  // executing the operation on elements via their accept method
  for (var building in area) {
    building.accept(agent);
  }
}
