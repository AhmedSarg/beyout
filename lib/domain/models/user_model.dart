class User {
  final String uid;
  final String email;
  String lastMessage;
  String lastMessageTime;

  User({
    required this.uid,
    required this.email,
    this.lastMessage = '',
    this.lastMessageTime = '',
  });
}
