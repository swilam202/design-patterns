//! Behavioral design pattern
//! chain of responsibility
//! Loggers

// Chain of Responsibility is a behavioral design pattern
// it is used to pass the request along the chain of potential handlers
// until one of them handles it

// in this example i want the system to print the message based on it's level
// each log type extends of the logger class
// each child of the logger class must have level of priority,
// color(to print the message in different colors in the console)
// and the successor if found!
//
// first step give the message to the child with the lowest priority level,
// and if it can't handle then give it to the next successor

//! pitfalls
// 1. the chain of responsibility can become long and complex

// class for the logs
class Log {
  // the message to be printed
  final String message;
  // the level on which it will determine which successor will handle it
  final int level;
  Log(this.level, this.message);
}

// the base class for handlers

abstract class Logger {
  // the successor if found
  final Logger? successor;
  // the color which the message will be printed on
  final String color;
  // and the current logger level
  final int level;

  Logger({this.successor, required this.color, required this.level});

  // abstract method for the handler
  void handleLog(Log log);
}

class InfoLogger extends Logger {
  // providing logger data such as it's color, level and the successor
  InfoLogger({Logger? successor})
    : super(successor: successor, color: '\x1B[32m', level: 1);

  @override
  void handleLog(Log log) {
    // if the current log level is higher is then give it to the next successor
    if (log.level > level) {
      successor?.handleLog(log);
    }
    // else handle it here
    else {
      print('$color Info: ${log.message}');
    }
  }
}

class WarningLogger extends Logger {
  WarningLogger({Logger? successor})
    : super(successor: successor, color: '\x1B[33m', level: 2);

  @override
  void handleLog(Log log) {
    if (log.level > level) {
      successor?.handleLog(log);
    } else {
      print('$color Warning: ${log.message}');
    }
  }
}

class ErrorLogger extends Logger {
  ErrorLogger({Logger? successor})
    : super(successor: successor, color: '\x1B[31m', level: 3);

  @override
  void handleLog(Log log) {
    if (log.level > level) {
      successor?.handleLog(log);
    } else {
      print('$color Error: ${log.message}');
    }
  }
}

void main() {
  // the log which to be handled
  final Log log = Log(3, 'something went wrong!');

  // the Logger children
  final Logger error = ErrorLogger();
  final Logger warning = WarningLogger(successor: error);
  final Logger info = InfoLogger(successor: warning);

  // handle the log from the lowest priority one
  info.handleLog(log);
}
