import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_clone/core/firebase_constants/firebase_collection_category_name.dart';
import 'package:facebook_clone/core/firebase_constants/firebase_field_names.dart';
import 'package:facebook_clone/core/widgets/toast.dart';
import 'package:facebook_clone/features/chats/data/repos/chats_repo.dart';
import 'package:facebook_clone/features/chats/model/chat_room_model.dart';
import 'package:facebook_clone/features/chats/model/message_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class ChatsRepoImp extends ChatsRepo {
  final String _myId = FirebaseAuth.instance.currentUser!.uid;
  final _storage = FirebaseStorage.instance;
  final _firestore = FirebaseFirestore.instance;

  @override
  Future<String> createChatRoom({required String userId}) async {
    try {
      CollectionReference chatRooms =
          _firestore.collection(FirebaseCollectionCategoryName.chatRooms);

      final members = [_myId, userId]..sort((a, b) => a.compareTo(b));

      print(members);

      // this will generate a room id
      final chatroomId = const Uuid().v1();
      final now = DateTime.now();

      // this will check if there is a room to this users or not
      // if there is no room it will create a new one
      QuerySnapshot availableChatRoom = await chatRooms
          .where(FirebaseFieldNames.members, isEqualTo: members)
          .get();

      if (availableChatRoom.docs.isNotEmpty) {
        return availableChatRoom.docs.first.id;
      }

      ChatRoomModel chatRoomModel = ChatRoomModel(
          chatroomId: chatroomId,
          lastMessage: "",
          lastMessageTimeStamp: now,
          members: members,
          createdAt: now);

      // this will create a new chat room document in firebase
      await _firestore
          .collection(FirebaseCollectionCategoryName.chatRooms)
          .doc(chatroomId)
          .set(chatRoomModel.toMap());
      showToastMessage(text: "chat room created");

      return chatroomId;
    } catch (e) {
      showToastMessage(text: e.toString());
      return e.toString();
    }
  }

  @override
  Future<void> sendMessage(
      {required String receiverId,
      required String message,
      required String roomId}) async {
    try {
      final messageId = const Uuid().v1();
      final now = DateTime.now();

      MessagesModel messages = MessagesModel(
        message: message,
        messageId: messageId,
        senderId: _myId,
        receiverId: receiverId,
        timestamp: now,
        seen: false,
        messageType: 'text',
      );

      final doc = _firestore
          .collection(FirebaseCollectionCategoryName.chatRooms)
          .doc(roomId);

      await _firestore
          .collection(FirebaseCollectionCategoryName.chatRooms)
          .doc(roomId)
          .collection(FirebaseCollectionCategoryName.messages)
          .doc(messageId)
          .set(messages.toMap());

      await doc.update({
        FirebaseFieldNames.lastMessage: message,
        FirebaseFieldNames.lastMessageTimeStamp: now.millisecondsSinceEpoch,
      });
    } catch (e) {
      showToastMessage(text: e.toString());
    }
  }

  @override
  Future<void> sendFile(
      {required File file,
      required String receiverId,
      required String fileType,
      required String roomId}) async {
    try {
      final messageId = const Uuid().v1();
      final now = DateTime.now();

      // Save to storage
      Reference ref = _storage.ref(fileType).child(messageId);
      TaskSnapshot snapshot = await ref.putFile(file);
      final downloadUrl = await snapshot.ref.getDownloadURL();

      MessagesModel newMessage = MessagesModel(
        message: downloadUrl,
        messageId: messageId,
        senderId: _myId,
        receiverId: receiverId,
        timestamp: now,
        seen: false,
        messageType: fileType,
      );

      final doc = _firestore
          .collection(FirebaseCollectionCategoryName.chatRooms)
          .doc(roomId);

      await _firestore
          .collection(FirebaseCollectionCategoryName.chatRooms)
          .doc(roomId)
          .collection(FirebaseCollectionCategoryName.messages)
          .doc(messageId)
          .set(newMessage.toMap());

      await doc.update({
        FirebaseFieldNames.lastMessage: "send a $fileType",
        FirebaseFieldNames.lastMessageTimeStamp: now.millisecondsSinceEpoch,
      });
    } catch (e) {
      showToastMessage(text: e.toString());
    }
  }

  @override
  Future<void> seen({required String roomId, required String messageId}) async {
    try {
      await _firestore
          .collection(FirebaseCollectionCategoryName.chatRooms)
          .doc(roomId)
          .collection(FirebaseCollectionCategoryName.messages)
          .doc(messageId)
          .update({
        FirebaseFieldNames.seen: true,
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
