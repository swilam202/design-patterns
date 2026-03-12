//! Behavioral design pattern
//! chain of responsibility
//! ATM

// Chain of Responsibility is a behavioral design pattern
// it is used to pass the request along the chain of potential handlers
// until one of them handles it

// in this example i have an ATM that has cassettes of different paper values
// the ATM has cassettes of 200, 100, 50, 20, 10, 5
// the ATM has a request to withdraw a certain amount of money
// the ATM will try to withdraw the amount of money from the cassettes
// starting from the highest value to the lowest value
// if the amount is less than the cassette paper value or the cassette is empty, it will try the next lower value
// if the amount is not divisible by any of the cassette values, it will return the remaining

//! pitfalls
// 1. the chain of responsibility can become long and complex

// class for the request to be handled
class Request {
  double amount;
  Request(this.amount);
}

// base class for the cassette which each paper will implement
abstract class Cassette {
  // the amount of papers available in this cassette
  final int availablePapers;
  // the value of each paper
  final int paperValue;
  Cassette({required this.availablePapers, required this.paperValue});
  // setter for the next cassette successor
  void setSuccessor(Cassette cassette);
  // the request handler
  Map? handleRequest(Request request, {required Map? total});
}

// the first implementation for the 200 paper
class Cassette200 extends Cassette {
  Cassette200(int availablePapers)
    // initializing the cassette data such as paper value and amount
    : super(paperValue: 200, availablePapers: availablePapers);

  // successor cassette if found
  Cassette? successor;

  @override
  void setSuccessor(Cassette cassette) {
    successor = cassette;
  }

  // the handler
  @override
  Map? handleRequest(Request request, {required Map? total}) {
    // the total number of papers which will be taken form this cassette
    int totalPapers = 0;

    while (true) {
      // if the amount is 0 then get out of the loop
      if (request.amount == 0) {
        break;
      }
      // if the amount is less than paper value or the available papers are 0
      // then handle the request in the next cassette
      else if (request.amount < paperValue || availablePapers == 0) {
        total = successor?.handleRequest(request, total: total);
        break;
      } else {
        // else if the amount value is bigger than the paper value and the available papers are not 0
        // then increment the total papers and decrement the amount the current amount
        // then iterate to the next loop iteration
        totalPapers++;
        request.amount -= paperValue;
      }
    }
    // after finishing the loop add the total papers to the map

    if (totalPapers != 0) total?['200'] = totalPapers;
    return total;
  }
}

class Cassette100 extends Cassette {
  Cassette100(int availablePapers)
    : super(paperValue: 100, availablePapers: availablePapers);

  Cassette? successor;

  @override
  void setSuccessor(Cassette cassette) {
    successor = cassette;
  }

  @override
  Map? handleRequest(Request request, {required Map? total}) {
    int totalPapers = 0;

    while (true) {
      if (request.amount == 0) {
        break;
      } else if (request.amount < paperValue || availablePapers == 0) {
        total = successor?.handleRequest(request, total: total);
        break;
      } else {
        totalPapers++;
        request.amount -= paperValue;
      }
    }
    if (totalPapers != 0) total?['100'] = totalPapers;

    return total;
  }
}

class Cassette50 extends Cassette {
  Cassette50(int availablePapers)
    : super(paperValue: 50, availablePapers: availablePapers);

  Cassette? successor;

  @override
  void setSuccessor(Cassette cassette) {
    successor = cassette;
  }

  @override
  Map? handleRequest(Request request, {required Map? total}) {
    int totalPapers = 0;

    while (true) {
      if (request.amount == 0) {
        break;
      } else if (request.amount < paperValue || availablePapers == 0) {
        total = successor?.handleRequest(request, total: total);
        break;
      } else {
        totalPapers++;
        request.amount -= paperValue;
      }
    }
    if (totalPapers != 0) total?['50'] = totalPapers;
    return total;
  }
}

class Cassette20 extends Cassette {
  Cassette20(int availablePapers)
    : super(paperValue: 20, availablePapers: availablePapers);

  Cassette? successor;

  @override
  void setSuccessor(Cassette cassette) {
    successor = cassette;
  }

  @override
  Map? handleRequest(Request request, {required Map? total}) {
    int totalPapers = 0;

    while (true) {
      if (request.amount == 0) {
        break;
      } else if (request.amount < paperValue || availablePapers == 0) {
        total = successor?.handleRequest(request, total: total);
        break;
      } else {
        totalPapers++;
        request.amount -= paperValue;
      }
    }
    if (totalPapers != 0) total?['20'] = totalPapers;
    return total;
  }
}

class Cassette10 extends Cassette {
  Cassette10(int availablePapers)
    : super(paperValue: 10, availablePapers: availablePapers);

  Cassette? successor;

  @override
  void setSuccessor(Cassette cassette) {
    successor = cassette;
  }

  @override
  Map? handleRequest(Request request, {required Map? total}) {
    int totalPapers = 0;

    while (true) {
      if (request.amount == 0) {
        break;
      } else if (request.amount < paperValue || availablePapers == 0) {
        total = successor?.handleRequest(request, total: total);
        break;
      } else {
        totalPapers++;
        request.amount -= paperValue;
      }
    }
    if (totalPapers != 0) total?['10'] = totalPapers;
    return total;
  }
}

class Cassette5 extends Cassette {
  Cassette5(int availablePapers)
    : super(paperValue: 5, availablePapers: availablePapers);

  Cassette? successor;

  @override
  void setSuccessor(Cassette cassette) {
    successor = cassette;
  }

  @override
  Map? handleRequest(Request request, {required Map? total}) {
    int totalPapers = 0;

    while (true) {
      if (request.amount == 0) {
        break;
      }
      // here this is lowest paper value
      // if the remaining is less than the paper value which is 5
      // then you can't withdrawal from this cassette or any other cassette
      // in this case show the remaining
      else if (request.amount < paperValue || availablePapers == 0) {
        total?['remaining'] = request.amount;
        break;
      } else {
        totalPapers++;
        request.amount -= paperValue;
      }
    }
    if (totalPapers != 0) total?['5'] = totalPapers;
    return total;
  }
}

void main() {
  // the request with the amount to be withdraw
  final Request request = Request(551);

  // map to show the output of each cassette
  Map? total = {};

  //setting up available cassettes
  Cassette c200 = Cassette200(0);
  Cassette c100 = Cassette100(50);
  Cassette c50 = Cassette50(50);
  Cassette c20 = Cassette20(50);
  Cassette c10 = Cassette10(50);
  Cassette c5 = Cassette5(50);

  // setting up the successors of each successor
  c200.setSuccessor(c100);
  c100.setSuccessor(c50);
  c50.setSuccessor(c20);
  c20.setSuccessor(c10);
  c10.setSuccessor(c5);

  // handle the request form the biggest paper value cassette
  total = c200.handleRequest(request, total: total);

  print(total);
}
