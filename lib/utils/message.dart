// ignore_for_file: constant_identifier_names

abstract class Errors {
  static const String ERROR_EMAIL = "Email is not valid";

  static const String ERROR_LOGIN = "Login not valid";

  static const String ERROR_USERNOTFOUND = "UserNotFound";

  static const String ERROR_PASSWORDNOTFOUND = "PasswordNotValid";

  static const String ERROR_NETWORKFAILED = "NetworkError";

  static const String PASSWORD_OR_EMAIL_EMPTY =
      "Field password or email is empty";
}

abstract class Success {
  static const String SUCCESS_LOGIN = "Login valid";

  static const String SUCCESS_REGISTER = "Login valid";
}
