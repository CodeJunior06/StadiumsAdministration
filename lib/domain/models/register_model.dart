import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:stadiums_administration/utils/message.dart';

class RegisterModel {
  late String uid;
  Future<String> checkIn(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        if (value != null) {
          uid = value.user!.uid;
        }
      });
      return Success.SUCCESS_REGISTER;
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
  }

  Future<TaskSnapshot?> registerFirebaseStorage(File image) async {
    return await FirebaseStorage.instance
        .ref()
        .child("$uid ${DateTime.now()}")
        .putFile(image)
        .then((p0) {
      print("DONE PHOTO");
    });
  }
}
