//function to handle the responvise height
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/res/colors.dart';
import 'package:image_picker/image_picker.dart';

double getDeviceHeight(BuildContext context) =>
    MediaQuery.of(context).size.height;

//function to handle the responvise width
double getDeviceWidth(BuildContext context) =>
    MediaQuery.of(context).size.width;

//using custom snack bar
void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        text,
        style: const TextStyle(color: AppColors.primaryColor),
      ),
    ),
  );
}

//using this function for responsive text
double getFontSize(double size, double screenWidth) {
  return size * screenWidth / 414;
}

// //shared preferences functions
// Future<void> setDataToLocal(
//     {required String key, required String value}) async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   await prefs.setString(key, value);
// }

// //function to get the saved data using key from local
// Future<String> getSavedDataByKey({required String key}) async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();

//   String? data = prefs.getString(key);
//   return data ?? "";
// }

// //remove the local saved data using key
// Future<void> removeDataByKey({required String key}) async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   await prefs.remove(key);
// }

// //to fet image from gallery and camera
Future<File?> pickImageAndReturnImg({required ImageSource imageType}) async {
  try {
    final pickedImage =
        await ImagePicker().pickImage(source: imageType, imageQuality: 30);

    return File(pickedImage!.path);
  } catch (e) {
    return null;
  }
}
