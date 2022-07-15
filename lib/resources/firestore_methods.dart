import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ig_clone/models/post_.dart';
import 'package:ig_clone/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> likePost(String postId, String uid, List likes) async {
    try {
      if (likes.contains(uid)){
        // dislike post
        await _firestore.collection('posts').doc(postId).update({
          'likes' : FieldValue.arrayRemove([uid]),
        });
      } else {
        // like the post
        await _firestore.collection('posts').doc(postId).update({
          'likes' : FieldValue.arrayUnion([uid]),
        });
      }
    } catch (e, s) {
      print(s);
    }
  }

  Future<String> uploadPost({
    required String desc,
    required Uint8List file,
    required String uid,
    required String username,
    required String profImage,
  }) async {
    String res = 'upload post error';
    try {
      String photoUrl = await StorageMethods()
          .uploadImageToStorage(childName: 'posts', file: file, isPost: true);
      String postID = const Uuid().v1();
      Post post = Post(
        desc: desc,
        uid: uid,
        username: username,
        postID: postID,
        postUrl: photoUrl,
        datePublished: DateTime.now(),
        profImage: profImage,
        likes: [],
      );
      _firestore.collection('posts').doc(postID).set(post.toJson());
      res = "success";
    } catch (e) {
      res = "error occured uploading post";
      print(e);
    }
    return res;
  }
}
