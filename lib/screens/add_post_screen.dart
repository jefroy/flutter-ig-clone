import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ig_clone/providers/user_provider.dart';
import 'package:ig_clone/resources/firestore_methods.dart';
import 'package:ig_clone/utils/colors.dart';
import 'package:ig_clone/utils/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  Uint8List? _file;
  bool isLoading = false;
  final TextEditingController _descriptionController = TextEditingController();

  void postImage({
    required String uid,
    required String username,
    required String profImage,
  }) async {
    setState(() {
      isLoading = true;
    });
    try {
      String res = await FirestoreMethods().uploadPost(
        desc: _descriptionController.text,
        file: _file!,
        uid: uid,
        username: username,
        profImage: profImage,
      );
      if (res == "success") {
        showSnackBar('Posted!', context);
      } else {
        showSnackBar(res, context);
      }
    } catch (e) {
      print(e);
      showSnackBar(e.toString(), context);
    }
    setState(() {
      isLoading = false;
    });
  }

  void clearImage(){
    setState((){
      _file = null;
    });
  }

  _selectImage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text('Create a Post'),
            children: [
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Take a Photo'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(
                    ImageSource.camera,
                  );
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Choose from Gallery'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(
                    ImageSource.gallery,
                  );
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Cancel'),
                onPressed: () async {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    return _file == null
        ? Center(
      child: IconButton(
        icon: const Icon(Icons.upload),
        onPressed: () => _selectImage(context),
      ),
    )
        : Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => clearImage(),
        ),
        title: const Text('Post to'),
        centerTitle: false,
        actions: [
          TextButton(
            onPressed: () => postImage(
              uid: userProvider.getUser.uid,
              username: userProvider.getUser.username,
              profImage: userProvider.getUser.photoUrl,
            ),
            child: const Text(
              'Post',
              style: TextStyle(
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          isLoading
              ? const LinearProgressIndicator()
              : const Padding(
            padding: EdgeInsets.only(top: 0),
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                  userProvider.getUser.photoUrl
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.45,
                child: TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    hintText: 'Write a caption...',
                    border: InputBorder.none,
                  ),
                  maxLines: 8,
                ),
              ),
              SizedBox(
                height: 45,
                width: 45,
                child: AspectRatio(
                  aspectRatio: 487 / 451,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: MemoryImage(_file!),
                        fit: BoxFit.fill,
                        alignment: FractionalOffset.topCenter,
                      ),
                    ),
                  ),
                ),
              ),
              const Divider(),
            ],
          ),
        ],
      ),
    );
  }
}
