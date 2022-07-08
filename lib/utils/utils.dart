import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

pickImage(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _file = await _imagePicker.pickImage(source: source);

  if(_file != null) { // user did pick an img from their gal
    return await _file.readAsBytes();
  }
  print('no image selected.'); // user did not pick an img from their gal
}