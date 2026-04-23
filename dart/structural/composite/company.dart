//! Structural design pattern
//! Composite
//! Company

// this pattern is used when you need to treat individual objects and groups of objects
// uniformly through the same interface.
// it lets you compose objects into tree structures to represent part-whole hierarchies.
// the key idea is that the client code doesn't need to know whether it's dealing
// with a single leaf object or a complex composite — it calls the same method on both.

// a real life example
// think of a file system: a folder can contain files and other folders.
// whether you right-click a single file or an entire folder and select "get info",
// the OS handles both through the same operation.
// the folder (composite) delegates the operation recursively to everything it contains,
// while a file (leaf) handles it directly.

// in this example i use a company organisational structure
// a Company can contain individual Employees and also other Companies (sub-departments).
// when you call showDetails() on a Company, it prints its own info and then
// recursively calls showDetails() on every item in its list —
// be it a leaf Employee or a nested Company.
// the client treats both through the shared EmployeeComponent interface,
// without needing to know what each item actually is.

//! pitfalls
// 1. it can be hard to restrict which components can be added to a composite,
//    since everything shares the same interface.
// 2. very deep trees can lead to hard-to-debug recursive calls.

// the component interface — the common contract for both leaves and composites
// it allows the client to treat individual employees and whole companies uniformly
abstract class EmployeeComponent {
  void showDetails();
}

// the leaf — represents a single employee with no children
// it implements the component interface directly without any delegation
class Employee extends EmployeeComponent {
  final String name;

  Employee(this.name);

  @override
  void showDetails() {
    // a leaf simply handles the operation itself — no recursion needed
    print('showing employee $name details');
  }
}

// the composite — represents a company that can hold any number of EmployeeComponents
// it can contain leaves (Employee) or other composites (Company), forming a tree
class Company extends EmployeeComponent {
  final String name;

  // the children list can hold any mix of Employees and nested Companies
  final List<EmployeeComponent> employees;

  Company(this.name, this.employees);

  @override
  void showDetails() {
    // print the composite's own info first
    print('showing company $name details');

    // then recursively delegate to every child in the tree —
    // each child handles the call in its own way (leaf or composite)
    for (EmployeeComponent component in employees) {
      component.showDetails();
    }
  }
}


void main() {
  // leaves — individual employees with no children
  Employee employee1 = Employee('John');
  Employee employee2 = Employee('Jane');
  Employee employee3 = Employee('Bob');

  // composites — companies that group employees (and can also nest other companies)
  Company company1 = Company('Company 1', [employee1, employee2]);
  Company company2 = Company('Company 2', [employee3]);

  // calling showDetails() on the composite triggers a recursive traversal of the whole tree
  // the client doesn't need to distinguish between leaves and composites
  company1.showDetails();
}