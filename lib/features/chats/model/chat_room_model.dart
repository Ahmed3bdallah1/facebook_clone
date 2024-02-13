import 'package:facebook_clone/core/firebase_constants/firebase_field_names.dart';

class ChatRoomModel {
  final String chatroomId;
  final String lastMessage;
  final DateTime lastMessageTimeStamp;
  final List<String> members;
  final DateTime createdAt;

  const ChatRoomModel({
    required this.chatroomId,
    required this.lastMessage,
    required this.lastMessageTimeStamp,
    required this.members,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      FirebaseFieldNames.chatroomId: chatroomId,
      FirebaseFieldNames.lastMessage: lastMessage,
      FirebaseFieldNames.lastMessageTimeStamp:
          lastMessageTimeStamp.millisecondsSinceEpoch,
      FirebaseFieldNames.members: members,
      FirebaseFieldNames.createdAt: createdAt.millisecondsSinceEpoch,
    };
  }

  factory ChatRoomModel.fromMap(Map<String, dynamic> map) {
    return ChatRoomModel(
      chatroomId: map[FirebaseFieldNames.chatroomId] as String,
      lastMessage: map[FirebaseFieldNames.lastMessage] as String,
      lastMessageTimeStamp: DateTime.fromMillisecondsSinceEpoch(
        map[FirebaseFieldNames.lastMessageTimeStamp] as int,
      ),
      members: List<String>.from(
        (map[FirebaseFieldNames.members] as List),
      ),
      createdAt: DateTime.fromMillisecondsSinceEpoch(
        map[FirebaseFieldNames.createdAt] as int,
      ),
    );
  }
}
