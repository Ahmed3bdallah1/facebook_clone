import 'dart:io';

abstract class ChatsRepo {
  Future<void> createChatRoom({required String userId});

  Future<void> sendMessage({
    required String receiverId,
    required String message,
    required String roomId,
  });

  Future<void> sendFile({
    required File file,
    required String receiverId,
    required String fileType,
    required String roomId,
  });

  Future<void> seen({required String roomId, required String messageId});
}
