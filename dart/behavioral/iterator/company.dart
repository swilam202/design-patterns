//! Behavioral design pattern
//! iterator
//! Company

// the iterator pattern is used to show meaningful data
// despite different data

// in this example i have a company with different employees types hourly, daily and monthly salary
// each of them has it's own salary calculator
// the main idea in the pattern here is we go through a list of employees
// and each of them calculates it's own salary and returns it

//! pitfalls
// 1. Unnecessary Abstraction for Simple Collections
// 2. Synchronization Problems

// the base class for the types of employees
// all of them share the name and job
abstract class Employee {
  final String name;
  final String job;

  Employee(this.name, this.job);

  // this is how each type shows it's data

  String showSalary();
}

// the hourly rate employee
class HourlyRatedEmployee extends Employee {
  // the number of hours he worked
  final int hours;
  // hour rate
  final double hourlyRate;
  HourlyRatedEmployee(String name, String job, this.hours, this.hourlyRate)
    : super(name, job);

  // implementation of the show salary
  @override
  String showSalary() {
    return '${super.name} works as ${super.job} will get ${hourlyRate * hours}';
  }
}

// the daily rate employee
class DailyRatedEmployee extends Employee {
  // the number of days he worked
  final int days;
  // day rate
  final double dailyRate;
  DailyRatedEmployee(String name, String job, this.days, this.dailyRate)
    : super(name, job);

  @override
  String showSalary() {
    return '${super.name} works as ${super.job} will get ${dailyRate * days}';
  }
}

// the monthly rate employee
class MonthlyEmployee extends Employee {
  // monthly salary
  final double monthlyRate;
  MonthlyEmployee(String name, String job, this.monthlyRate) : super(name, job);

  @override
  String showSalary() {
    return '${super.name} works as ${super.job} will get ${monthlyRate}';
  }
}

// the company that has the list of employees
class Company {
  List<Employee> _employees = [];

  // method to add employee to the employees list
  void addEmployee(Employee e) {
    _employees.add(e);
  }

  // create an iterator that will iterate over the employees and show their salaries
  EmployeeIterator addIterator() => EmployeeIterator(_employees);
}

// the iterator that will loops over the employees and display it's data
class EmployeeIterator {
  final List<Employee> _employees;
  // the index is -1 for not started the iteration yet
  int index = -1;

  EmployeeIterator(this._employees);

  // shows if there is a next item
  bool moveNext() {
    index++;
    return index < _employees.length;
  }

  // returns the current employee by the index
  Employee get current => _employees[index];
}

void main() {
  // instance of the company
  Company company = Company();

  // add the employees depending on their type
  company.addEmployee(HourlyRatedEmployee('Ali', 'Plumber', 150, 300.0));
  company.addEmployee(DailyRatedEmployee('Mostafa', 'IT', 25, 870.0));
  company.addEmployee(MonthlyEmployee('Ahmed', 'Engineer', 11500));

  // create the iterator that will loop over the company
  final EmployeeIterator iterator = company.addIterator();

  print('Salaries');
  // show the salaries of the employees
  while (iterator.moveNext()) {
    print(iterator.current.showSalary());
  }
}
