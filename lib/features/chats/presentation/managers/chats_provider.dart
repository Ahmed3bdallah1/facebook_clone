import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_clone/core/firebase_constants/firebase_collection_category_name.dart';
import 'package:facebook_clone/core/firebase_constants/firebase_field_names.dart';
import 'package:facebook_clone/features/chats/data/repos/chats_repo_imp.dart';
import 'package:facebook_clone/features/chats/model/chat_room_model.dart';
import 'package:facebook_clone/features/chats/model/message_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatsProvider = Provider((ref) => ChatsRepoImp());

final getAllChats = StreamProvider.autoDispose<Iterable<ChatRoomModel>>(
  (ref) {
    final userId = FirebaseAuth.instance.currentUser!.uid;

    final controller = StreamController<Iterable<ChatRoomModel>>();

    final sub = FirebaseFirestore.instance
        .collection(FirebaseCollectionCategoryName.chatRooms)
        .where(FirebaseFieldNames.members, arrayContains: userId)
        .orderBy(FirebaseFieldNames.lastMessageTimeStamp)
        .snapshots()
        .listen((event) {
      final chats = event.docs.map((e) => ChatRoomModel.fromMap(e.data()));
      controller.sink.add(chats);
    });

    ref.onDispose(() {
      sub.cancel();
      controller.close();
    });

    return controller.stream;
  },
);

final getAllMessages =
    StreamProvider.autoDispose.family<Iterable<MessagesModel>, String>(
  (ref, roomId) {
    final controller = StreamController<Iterable<MessagesModel>>();

    final sub = FirebaseFirestore.instance
        .collection(FirebaseCollectionCategoryName.chatRooms)
        .doc(roomId)
        .collection(FirebaseCollectionCategoryName.messages)
        .orderBy(FirebaseFieldNames.timestamp)
        .snapshots()
        .listen((event) {
      final messages = event.docs.map((e) => MessagesModel.fromMap(e.data()));
      controller.sink.add(messages);
    });

    ref.onDispose(() {
      sub.cancel();
      controller.close();
    });

    return controller.stream;
  },
);
