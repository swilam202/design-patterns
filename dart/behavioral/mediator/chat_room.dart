//! Behavioral design pattern
//! Mediator
//! ChatRoom

// the mediator pattern works as mediator between objects
// to facilitate communication between objects and to make them loosely coupled
// think of it like the airport tower
// it works as mediator between planes that want's to land
// if the planes has to communicate with each other to land it will be as disaster

// in this example i have a chat room
// imagine without the idea of the chat room
// all users have to register all other users in their list
// and sending one message will go to all the users and send them the message
// instead in the chat room, the chat room is centralized and one copy of the users in that room
// if a user sends a message it handles sending it to other users
// without the sender to give it a thought about whom will receive his message

//! pitfalls
// 1. The mediator becomes very large and complex.
// 2. Hard to maintain or understand.

// this is the abstract class for chat rooms
abstract class ChatRoom {
  // function to add user to the users list
  void addUser(User user);
  // method to send message to all other users
  // we take the sender to send it to all users except him
  void sendMessage(User sender, String message);
}

// the user model
class User {
  // name for the user
  final String name;
  // the chat room he is involved in
  final ChatRoom chatRoom;
  User(this.chatRoom, this.name);

  // when he sends a message it calls the sendMessage in the chat room
  // and this will cause sending message to all other users
  void sendMessage(String message) {
    chatRoom.sendMessage(this, message);
  }

  // method to handle if this user got a new message from other users
  void receiveMessage(User sender, String message) {
    print('${name} received message "$message" from ${sender.name}');
  }
}

// the implementation for the chat room
class ChatRoom1 extends ChatRoom {
  // a list of all users in this chat room
  List<User> _users = [];

  // adding new users to the users list
  @override
  void addUser(User user) {
    _users.add(user);
  }

  // the sendMessage method here takes the message sent form one user
  // and iterate over all other users in the chat room and sends the message to them

  @override
  void sendMessage(User sender, String message) {
    for (User user in _users) {
      // checks if the user to receive the message is not the sender himself
      // to avoid sending the message to the sender himself
      if (user.name != sender.name) {
        user.receiveMessage(sender, message);
      }
    }
  }
}

void main() {
  // init the chat room
  ChatRoom chatRoom = ChatRoom1();

  // registering the users in the chat room with their names
  User ahmed = User(chatRoom, 'Ahmed');
  User mostafa = User(chatRoom, 'Mostafa');
  User ali = User(chatRoom, 'Ali');
  User omar = User(chatRoom, 'Omar');

  // adding the user to the chat room
  chatRoom.addUser(ahmed);
  chatRoom.addUser(mostafa);
  chatRoom.addUser(ali);
  chatRoom.addUser(omar);

  // here ahmed sends a message to all other users and the chat room wil handle sending it to other users
  ahmed.sendMessage('Hello');
}
