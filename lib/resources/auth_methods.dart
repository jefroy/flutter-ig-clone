import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ig_clone/models/custom_user.dart';
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
        CustomUser user = CustomUser(
          email: email,
          password: password,
          username: username,
          bio: bio,
          photoUrl: photoUrl,
          followers: [],
          following: [],
        );
        await _firestore.collection('users').doc(cred.user!.uid).set(user.toJson()); // use ! so we dont query null

        // another way to do it, but less effective
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
    }
    // on FirebaseAuthException catch (e){
    //   if (e.code == 'invalid-email'){
    //     res = "something wrong with the email entered";
    //   } else if (e.code == 'invalid-email'){
    //     res = "pass word"
    //   }
    // }
    catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "error occured";
    print("logging in: ");
    print(email);
    print(password);
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        UserCredential? loggedInUser = null;
        loggedInUser = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        print(loggedInUser);
        if (loggedInUser != null) {
          res = "logged in hehe";
        }
      } else {
        res = "Please enter all fields";
      }
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'invalid-email') {
        res = "something wrong with the email entered";
      } else if (e.code == 'invalid-email') {
        res = "pass word";
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
