import 'package:flutter/cupertino.dart';

class RegisterUser {
  String? id;
  String? name;
  String? user;
  String? email;
  String? password;
  String? urlImage;

  RegisterUser(
      this.id, this.name, this.user, this.email, this.password, this.urlImage);


    Map<String, Object> toJSON() {
      return {
        "id": id!,
        "name": name!,
        "user": user!,
        "email": email!,
        "password": password!,
        "urlImage": urlImage!
      };
    }

}
