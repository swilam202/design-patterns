//! Behavioral design pattern
//! chain of responsibility
//! Company

// Chain of Responsibility is a behavioral design pattern
// it is used to pass the request along the chain of potential handlers
// until one of them handles it

// in this example i have a company and the company has employees as handlers
// the handlers are team lead, manager, ceo
// the team lead can handle requests up to 5000
// the manager can handle requests up to 10000
// the ceo can handle requests up to infinity

// the request is sent with the amount money required and sent to the team lead
// which is the lowest authority here
// the request is passed to the manager if the amount exceed the team lead authority
// and the request is passed to the ceo if the amount exceed the manager authority

//! pitfalls
// 1. the chain of responsibility can become long and complex

// the request class
class Request {
  final double amount;
  Request(this.amount);
}

// the base class for the handler which the employees will extend
abstract class Handler {
  // setter for the next successor
  void setSuccessor(Handler handler);

  //handler for handling the request
  void handleRequest(Request request);
}

// the team lead class which extends the handler
class TeamLeader extends Handler {
  // the successor if found
  Handler? successor;

  @override
  void setSuccessor(Handler handler) {
    successor = handler;
  }

  @override
  void handleRequest(Request request) {
    // if the amount exceed its authority pass it to the next successor
    if (request.amount > 5000.0) {
      successor?.handleRequest(request);
      // else handle it if can be handled
    } else {
      print('Team lead handled the request');
    }
  }
}

class Manager extends Handler {
  Handler? successor;

  @override
  void setSuccessor(Handler handler) {
    successor = handler;
  }

  @override
  void handleRequest(Request request) {
    if (request.amount > 10000.0) {
      successor?.handleRequest(request);
    } else {
      print('Manager handled the request');
    }
  }
}

class CEO extends Handler {
  Handler? successor;

  @override
  void setSuccessor(Handler handler) {
    successor = handler;
  }

  @override
  void handleRequest(Request request) {
    print('CEO handled the request');
  }
}

void main() {
  // the request which to be sent
  Request request = Request(7000);

  // the handlers
  Handler teamLead = TeamLeader();
  Handler manager = Manager();
  Handler ceo = CEO();

  // setters for the successors of each handler
  teamLead.setSuccessor(manager);
  manager.setSuccessor(ceo);

  teamLead.handleRequest(request);
}
