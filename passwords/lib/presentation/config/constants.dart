import 'package:flutter/material.dart';

class GroupNames {
  static const id = 'id';
  static const name = 'name';
  static const tableName = 'groups';
}

class TypeNames {
  static const id = 'id';
  static const name = 'name';
  static const fields = 'fields';
  static const passwordValidationId = 'passwordValidationId';
  static const tableName = 'types';
}

class PasswordNames {
  static const id = 'id';
  static const groupId = 'groupId';
  static const typeId = 'typeId';
  static const password = 'password';
  static const notes = 'notes';
  static const description = 'description';
  static const url = 'url';
  static const username = 'username';
  static const email = 'email';
  static const accountNumber = 'accountNumber';
  static const pin = 'pin';
  static const sortCode = 'sortCode';
  static const digit3SecurityCode = 'digit3SecurityCode';
  static const digit4SecurityCode = 'digit4SecurityCode';
  static const phoneNumber = 'phoneNumber';
  static const name = 'name';
  static const cardNumber = 'cardNumber';
  static const amexCardNumber = 'amexCardNumber';
  static const expiryDate = 'expiryDate';
  static const passcode = 'passcode';
  static const passwordValidationId = 'passwordValidationId';
  static const isValidated = 'isValidated';
  static const tableName = 'passwords';
}

class PasswordFieldNames {
  static const id = 'id';
  static const name = 'name';
  static const description = 'description';
  static const hintText = 'hintText';
  static const errorText = 'errorText';
  static const validationIndex = 'validationIndex';
  static const formatterIndex = 'formatterIndex';
  static const maxLength = 'maxLength';
  static const tableName = 'passwordFieldNames';
}

class TypeFieldNames {
  static const typeId = 'typeId';
  static const fieldId = 'fieldId';
  static const value = 'value';
  static const tableName = 'typeFieldNames';
}

class ColourScheme {
  static const TextStyle st = TextStyle(color: Colors.black, fontSize: 18);
  static const TextStyle stb = TextStyle(
      color: Colors.black,
      fontSize: 18,
      fontWeight: FontWeight.normal,
      shadows: [
        Shadow(color: Colors.black26, offset: Offset(1.0, 1.0), blurRadius: 1.0)
      ]);
  static const TextStyle stbl = TextStyle(
      color: cltx,
      fontSize: 17,
      fontWeight: FontWeight.bold,
      shadows: [
        Shadow(
            color: Color(0xFFE1F5FE), offset: Offset(2.0, 2.0), blurRadius: 1.0)
      ]);
  static const TextStyle stbr = TextStyle(
      color: cltx,
      fontSize: 17,
      fontWeight: FontWeight.bold,
      shadows: [
        Shadow(color: Colors.red, offset: Offset(1.0, 1.0), blurRadius: 1.0)
      ]);
  static const TextStyle str = TextStyle(
      color: cltx,
      fontSize: 17,
      fontWeight: FontWeight.normal,
      shadows: [
        Shadow(color: Colors.red, offset: Offset(1.0, 1.0), blurRadius: 1.0)
      ]);
  static const TextStyle stc = TextStyle(
    color: cltx,
    fontSize: 18,
  );
  static const TextStyle stsm = TextStyle(
    color: Colors.black,
    fontSize: 10,
  );
  static const Color clbk = Color(0xFF546E7A);
  static const Color cltx = Color(0xFFFFA726);
  static const Color clgl = Color(0xFFFFCC80);
  static const Color clgr = Color(0xFFCFD8DC);
  static const Color clred = Color(0xFFB71C1C);
}

class AppConstants {
  static const databaseName = 'multiUserToDo';
  static const userId = 'userId';
  static const defaultUserId = 1;
  static const noType = -1010101;
  static const noFilterChosen = -1;
  static const snackbar =
      SnackBar(content: const Text('Password copied to Clipboard'));
}

enum Formatters {
  justNumberFormatter,
  lengthLimiterFormatter,
  sortCodeFormatter,
  debitCardFormatter,
  expiryDateInputFormatter,
  mobileNumberFormatter,
  amexCardFormatter
}

enum Validators {
  isRequired,
  requiredAndLength,
  emailValidator,
  strongPasswordValidator,
  mediumPasswordValidator,
  weakPasswordValidator,
  urlValidator,
  numericValidator,
  phoneNumberValidator,
  debitCardValidation,
  requiredAndLengthMaxSet
}

enum PasswordFieldsNumbers {
  password,
  description,
  url,
  username,
  email,
  accountNumber,
  pin,
  sortCode,
  digit3SecurityCode,
  digit4SecurityCode,
  phoneNumber,
  name,
  cardNumber,
  amexCardNumber,
  expiryDate,
  passcode,
  notes
}

enum StartUpScreens { home, backup }
