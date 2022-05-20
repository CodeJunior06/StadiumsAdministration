import 'dart:io';

import 'package:stadiums_administration/domain/POJO/model_register.dart';

abstract class FirebaseBase {
  Future<String?> checkIn(String email, String password);
  Future<String?> registerFirebaseStorage(File image);
  Future<String?> registerFirebaseFirestore(RegisterUser modelRegisterUser);
  void signOffFirebase();
}
