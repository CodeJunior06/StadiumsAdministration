import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stadiums_administration/domain/POJO/model_register.dart';
import 'package:stadiums_administration/domain/iterator/callback.dart';
import 'package:stadiums_administration/domain/models/register_model.dart';
import 'package:stadiums_administration/utils/message.dart';
import 'package:stadiums_administration/utils/utils.dart';

class RegisterViewModel {
  late File imageUpload;
  late RegisterModel registerModel;

  String? validRegisterData(
      List<String> listField, CallBack onchangedCallback) {
    registerModel = RegisterModel();
    String? response;
    registerModel
        .checkIn(listField.elementAt(2), listField.elementAt(3))
        .then((value) {
      if (identical(value, Success.SUCCESS_REGISTER)) {
        
        RegisterUser registerUser = RegisterUser(
            null,
            listField.elementAt(0),
            listField.elementAt(1),
            listField.elementAt(2),
            listField.removeAt(3),
            null);

        registerModel
            .registerFirebaseStorage(File(imageUpload.path))
            .then((valueStorage) {
          if (identical(valueStorage, Success.SUCCESS_SUBMIT_PHOTO)) {
            registerModel
                .registerFirebaseFirestore(registerUser)
                .then((value) => response = value)
                .whenComplete(
                    () => onchangedCallback.responseMessage(response));
          } else {
            response = valueStorage;
          }
        }).whenComplete(() => onchangedCallback.responseMessage(response));
      } else {
        response = value;
      }
    }).whenComplete(() => onchangedCallback.responseMessage(response));

    return response;
  }

  dynamic validField(String? value, bool isEmail, int numMin) {
    if (value != null && value.length < numMin) {
      return "Enter minium $numMin characters";
    } else if (isEmail) {
      var response = Utils.validateEmail(value!);
      if (response) {
        return null;
      } else {
        return "Email invalid";
      }
    } else {
      return null;
    }
  }

  Future<File?> pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return Image.asset("assets/person_null.jpg") as File;

      return File(image.path);
    } catch (e) {
      print(e);
    }
    return null;
  }

  saveImage(File image) {
    imageUpload = image;
  }

  void signOff() {
    registerModel.signOffFirebase();
  }
}
