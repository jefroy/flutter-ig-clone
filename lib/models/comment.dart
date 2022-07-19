import 'package:cloud_firestore/cloud_firestore.dart';

// todo : grab the uid instead and pull that user object from db

class Comment {
  final String text;
  final String uid;
  final String username;
  final DateTime datePublished;
  final String commentId;
  final String profImage;
  final List likes;

  const Comment({
    required this.text,
    required this.uid,
    required this.username,
    required this.datePublished,
    required this.commentId,
    required this.profImage,
    required this.likes,
  });

  Map<String, dynamic> toJson() => {
        'text': text,
        'uid': uid,
        'username': username,
        'datePublished': datePublished,
        'commentId': commentId,
        'profImage': profImage,
        'likes': [],
      };

  static Comment fromSnap(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;
    return Comment(
      text: snap['text'],
      uid: snap['uid'],
      username: snap['username'],
      datePublished: snap['datePublished'],
      commentId: snap['commentId'],
      profImage: snap['profImage'],
      likes: snap['likes'],
    );
  }

}
