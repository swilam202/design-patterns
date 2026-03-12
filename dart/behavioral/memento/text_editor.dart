//! Behavioral design pattern
//! Mediator
//! Text editor

// this pattern is used to store snapshots of your current state
// for say you are inside a game and you want to save your current progress
// when you save the game you take a snapshot of your current progress
// because if you closed the game or somehow you missed up in a mission
// you can rollback to the last progress

// in this example i use the text editor
// like any editor you use there is a ctrl+z & ctrl+shift+z
// those shortcuts are used to roll back if you wrote something wrong
// you hit the ctrl+z buttons and the last update is removed
// the mechanism of this function is when every you hit the save button or you stop typing
// the editor stores the current text of the file in a stack
// why stack because when you rollback you get the last saved snapshot (last in first out)
// and store it over the current text

//! pitfalls
// 1. The history object can grow very large.

// this is the class contains the data to be saved each time you save a state
class Memento {
  // here we only save the text of the file only
  // in other cases there maybe other data needs to be stored
  final String text;
  Memento(this.text);
}

// this is the text editor base class
abstract class TextEditor {
  // has the method save which stores a memento in the stack (ctrl+s)
  void save(String message);
  // the restore which rolls back to the last state (ctrl+z)
  void restore();
  // return the current text in the file
  String print();
}

class TextEditor1 extends TextEditor {
  // the current text of the file
  String text = '';

  // the stack history which holds the previous states
  final History history;

  TextEditor1(this.history);

  @override
  void save(message) {
    // the save method is used to add the new text that was written
    // to the current text
    text += ' $message';
    // and store it in the stack as memento
    history.save(Memento(text));
  }

  // the restore works by getting the last memento in the history
  // and set the editor text with it
  @override
  void restore() {
    text = history.restore().text;
  }

  @override
  String print() {
    return text;
  }
}

// the history class which holds the memento and controls it
class History {
  // the stack
  List<Memento> _history = [];

  // adds new memento to the stack
  void save(Memento memento) {
    _history.add(memento);
  }

  // pops the last memento in the stack
  // and returns it
  Memento restore() {
    return _history.removeLast();
  }
}

void main() {
  // the history controller which holds the mementos
  History history = History();

  // the text editor
  TextEditor textEditor = TextEditor1(history);

  // saving a new 2 states to the history
  textEditor.save('hello');
  textEditor.save('Hi, there');

  // when we print it shows the concatenation between the last to states
  print(textEditor.print());

  // when we restore it removes the last memento "Hi, there"
  // and shows the "hello"
  textEditor.restore();

  // this will be shown in the print
  print(textEditor.print());
}
