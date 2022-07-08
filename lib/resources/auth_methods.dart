import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ig_clone/resources/storage_methods.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // register user
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    Uint8List? file,
  }) async {
    String res = "error occured registering user.";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty
          // file!.isNotEmpty
      ) {
        _auth.signInAnonymously();
        // valid data, register user now
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        print(cred.user!.uid);
        // print(file);
        String photoUrl = await StorageMethods().uploadImageToStorage(
          childName: 'profile_pictures',
          file: file!,
          isPost: false,
        );
        print(photoUrl);
        // add user to db
        await _firestore.collection('users').doc(cred.user!.uid).set({
          'email': email,
          'password': password,
          'username': username,
          'bio': bio,
          'followers': [], // list of uids
          'following': [], // list of uids
          'photoUrl' : photoUrl,
        }); // use ! so we dont query null

        // another way to do it
        // await _firestore.collection('users').add({
        //   'email': email,
        //   'password': password,
        //   'username': username,
        //   'bio': bio,
        //   'followers': [], // list of uids
        //   'following': [], // list of uids
        // });

        res = "success!";
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
