import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_clone/core/firebase_constants/firebase_collection_category_name.dart';
import 'package:facebook_clone/core/firebase_constants/firebase_field_names.dart';
import 'package:facebook_clone/core/widgets/toast.dart';
import 'package:facebook_clone/features/friends/data/friend_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FriendRepoImp extends FriendRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Future<void> sendFriendRequest({required String friendId}) async {
    try {
      // this method will add the user to my sent request list
      _firestore
          .collection(FirebaseCollectionCategoryName.users)
          .doc(userId)
          .update({
        FirebaseFieldNames.sentRequests: FieldValue.arrayUnion([friendId])
      });

      // this will add my id to the received requests list
      _firestore
          .collection(FirebaseCollectionCategoryName.users)
          .doc(friendId)
          .update({
        FirebaseFieldNames.receivedRequests: FieldValue.arrayUnion([userId])
      });
      showToastMessage(text: "friend request sent!!");
    } catch (e) {
      showToastMessage(text: e.toString());
    }
  }

  @override
  Future<void> acceptFriendRequest({required String friendId}) async {
    try {
      // this method will add the user to my friends list
      _firestore
          .collection(FirebaseCollectionCategoryName.users)
          .doc(userId)
          .update({
        FirebaseFieldNames.friends: FieldValue.arrayUnion([friendId])
      });

      // this method will add me to the user's friends list
      _firestore
          .collection(FirebaseCollectionCategoryName.users)
          .doc(friendId)
          .update({
        FirebaseFieldNames.friends: FieldValue.arrayUnion([userId])
      });

      removeFriendRequest(friendId: friendId);

      showToastMessage(text: "Friend request accepted !!");
    } catch (e) {
      showToastMessage(text: e.toString());
    }
  }

  @override
  Future<void> deleteFriend({required String friendId}) async {
    try {
      // this method will remove the user to my friends list
      _firestore
          .collection(FirebaseCollectionCategoryName.users)
          .doc(userId)
          .update({
        FirebaseFieldNames.friends: FieldValue.arrayRemove([friendId])
      });

      // this method will remove me to the user's friends list
      _firestore
          .collection(FirebaseCollectionCategoryName.users)
          .doc(friendId)
          .update({
        FirebaseFieldNames.friends: FieldValue.arrayRemove([userId])
      });
      showToastMessage(text: "Friend removed successfully !!");
    } catch (e) {
      showToastMessage(text: e.toString());
    }
  }

  @override
  Future<void> removeFriendRequest({required String friendId}) async {
    try {
      // this two methods will remove all the friend request data
      _firestore
          .collection(FirebaseCollectionCategoryName.users)
          .doc(userId)
          .update({
        FirebaseFieldNames.sentRequests: FieldValue.arrayRemove([friendId]),
        FirebaseFieldNames.receivedRequests: FieldValue.arrayRemove([friendId]),
      });
      _firestore
          .collection(FirebaseCollectionCategoryName.users)
          .doc(friendId)
          .update({
        FirebaseFieldNames.sentRequests: FieldValue.arrayRemove([userId]),
        FirebaseFieldNames.receivedRequests: FieldValue.arrayRemove([userId]),
      });
    } catch (e) {
      showToastMessage(text: e.toString());
    }
  }
}
