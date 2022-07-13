import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String desc;
  final String uid;
  final String username;
  final String postID;
  final String postUrl;
  final DateTime datePublished;
  final String profImage;
  final List<String> likes;

  const Post({
    required this.desc,
    required this.uid,
    required this.username,
    required this.postID,
    required this.postUrl,
    required this.datePublished,
    required this.profImage,
    required this.likes,
  });

  Map<String, dynamic> toJson() => {
        'desc': desc,
        'uid': uid,
        'username': username,
        'postID': postID,
        'postUrl': postUrl,
        'datePublished': datePublished,
        'profImage': profImage,
        'likes': [],
      };

  static Post fromSnap(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;
    return Post(
      desc: snap['desc'],
      uid: snap['uid'],
      username: snap['username'],
      postID: snap['postID'],
      postUrl: snap['postUrl'],
      datePublished: snap['datePublished'],
      profImage: snap['profImage'],
      likes: snap['likes'],
    );
  }

}
