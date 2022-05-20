import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:stadiums_administration/domain/POJO/model_register.dart';
import 'package:stadiums_administration/domain/database/firebase_base.dart';
import 'package:stadiums_administration/utils/message.dart';

class RegisterModel implements FirebaseBase {
  late String uid;
  late String url;

  @override
  Future<String?> checkIn(String email, String password) async {
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

  @override
  Future<String?> registerFirebaseFirestore(
      RegisterUser modelRegisterUser) async {
    try {
      modelRegisterUser.id = uid;
      modelRegisterUser.urlImage = url;
      await FirebaseFirestore.instance
          .collection("registro_auth")
          .doc(uid)
          .set(modelRegisterUser.toJSON());
      return Success.SUCCESS_REGISTER_FIRESTORE;
    } catch (e) {
      return e.toString();
    }
  }

  @override
  Future<String?> registerFirebaseStorage(File image) async {
    try {
      TaskSnapshot up = await FirebaseStorage.instance
          .ref(uid)
          .child("${uid}_${DateTime.now()}")
          .putFile(image);
      await up.ref.getDownloadURL().then((value) => url = value);
      return Success.SUCCESS_SUBMIT_PHOTO;
    } catch (e) {
      return e.toString();
    }
  }

  @override
  void signOffFirebase() {
    FirebaseAuth.instance.signOut();
  }
}
