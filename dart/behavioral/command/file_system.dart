//! Behavioral design pattern
//! command
//! file system

// command serves as a bridge between the sender and receiver
// command pattern is used to decouple the sender and receiver
// it is also used to implement undo and redo functionality
// it encapsulates the request in a command object
// so it just pass the command object to the receiver and the receiver will execute it

// real life exam
// think of a remote control for a tv
// the remote control is the invoker
// the tv is the receiver
// the button press is the command
// the remote control just pass the command to the tv and the tv will execute it

// in this example i have a file system and i want to perform operations on it
// like create, update, delete
// and i want to be able to undo and redo these operations

//! pitfalls
// 1. the command pattern can become complex if there are many commands

// the receiver
class FileSystem {
  // the map of the files
  Map<String, dynamic> _files = {};

  // create file
  void createFile(MapEntry file) {
    // you just add the file to the map
    _files[file.key] = file.value;
    print(_files);
  }

  // update file
  void updateFile(MapEntry file) {
    // update the file if found
    if (_files.containsKey(file.key)) {
      _files[file.key] = file.value;
      print(_files);
    }
  }

  void deleteFile(MapEntry file) {
    // delete the file if found
    if (_files.containsKey(file.key)) {
      _files.remove(file.key);
      print(_files);
    }
  }
}

// the command interface
abstract class Command {
  void execute();
  void undo();
}

// create file command
class CreateFileCommand implements Command {
  // instance of the receiver
  final FileSystem fileSystem;
  // the file to be created
  final MapEntry<String, dynamic> file;

  CreateFileCommand(this.fileSystem, {required this.file});

  // backup of the file
  MapEntry<String, dynamic>? _backup;

  @override
  void execute() {
    // execute the command
    fileSystem.createFile(file);
    // backup the file
    _backup = file;
  }

  @override
  void undo() {
    // check if the backup is not null
    if (_backup != null) {
      // delete the file
      fileSystem.deleteFile(_backup!);
      // clear the backup
      _backup = null;
    }
  }
}

class UpdateFileCommand implements Command {
  final FileSystem fileSystem;
  final MapEntry<String, dynamic> file;

  UpdateFileCommand(this.fileSystem, {required this.file});

  MapEntry<String, dynamic>? _backup;

  @override
  void execute() {
    fileSystem.updateFile(file);
    _backup = file;
  }

  @override
  void undo() {
    if (_backup != null) {
      fileSystem.updateFile(_backup!);
      _backup = null;
    }
  }
}

class DeleteFileCommand implements Command {
  final FileSystem fileSystem;
  final MapEntry<String, dynamic> file;

  DeleteFileCommand(this.fileSystem, {required this.file});

  MapEntry<String, dynamic>? _backup;

  @override
  void execute() {
    fileSystem.deleteFile(file);
    _backup = file;
  }

  @override
  void undo() {
    if (_backup != null) {
      fileSystem.createFile(_backup!);
      _backup = null;
    }
  }
}

// the invoker
class FileManager {
  // history of commands
  List<Command> _history = [];
  // redo stack
  List<Command> _redos = [];

  void execute(Command command) {
    // execute the command
    command.execute();
    // add the command to the history
    _history.add(command);
    // clear the redo stack
    _redos.clear();
  }

  void undo() {
    // check if the history is not empty
    if (_history.isNotEmpty) {
      // remove the last command from the history
      final Command command = _history.removeLast();
      // undo the command
      command.undo();
      // add the command to the redo stack
      _redos.add(command);
    }
  }

  void redo() {
    // check if the redo stack is not empty
    if (_redos.isNotEmpty) {
      // remove the last command from the redo stack
      final Command command = _redos.removeLast();
      // execute the command
      command.execute();
      // add the command to the history
      _history.add(command);
    }
  }

  void executeAll(List<Command> commands) {
    // iterate over the commands and execute them
    for (Command c in commands) {
      c.execute();
    }
  }

  void undoAll() {
    // iterate over the commands and undo them
    for (Command c in _history) {
      c.undo();
    }
  }

  void redoAll() {
    // iterate over the commands and redo them
    for (Command c in _redos) {
      c.execute();
    }
  }
}

void main() {
  // the receiver
  final FileSystem fileSystem = FileSystem();

  // the file
  final MapEntry<String, dynamic> file = MapEntry('name', 'Ali');

  // the commands
  final Command create = CreateFileCommand(fileSystem, file: file);
  final Command update = UpdateFileCommand(fileSystem, file: file);
  final Command delete = DeleteFileCommand(fileSystem, file: file);

  // the invoker
  final FileManager manager = FileManager();

  // execute the command
  manager.execute(create);

  // undo the command
  manager.undo();

  // redo the command
  manager.redo();
}
