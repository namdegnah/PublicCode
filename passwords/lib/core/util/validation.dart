import 'package:form_field_validator/form_field_validator.dart';
import 'package:flutter/services.dart';
// TO DO complete all the validations
// VALIDATORS
List<TextInputFormatter>? getFormatters({
  int? formatterIndex,
  int? length,
  }){
  if(formatterIndex != null){
    switch(formatterIndex){
      case 0:
        return justNumberFormatter(numberCount: length!);
      case 1:
        return lengthLimiterFormatter(numberCount: length!);
      case 2:
        return sortCodeFormatter();
      case 3:
        return debitCardFormatter();
      case 4:
        return expiryDateFormatter();
      case 5:
        return mobileNumberFormatter;
      case 6:
        return amexCardFormatter(); 
    }      
  } 
  return null;
}
String? Function(String?)? getValidation({
  required int validationIndex,
  String? errorText,
  int? length
  }){
  switch(validationIndex){
    case 0:
      return isRequired(errorText!);
    case 1:
      return requiredAndLength(error: errorText!, length: length!);
    case 2:
      return emailValidator;
    case 3:
      return strongPasswordValidator; 
    case 4: 
      return mediumPasswordValidator;
    case 5:
      return weakPasswordValidator;
    case 6:
      return urlValidator;
    case 7:
      return numericValidator;
    case 8:
      return phoneNumberValidator;
    case 9: 
      return debitCardValidation(error: errorText!, length: length!);
    case 10:
      return requiredAndLengthMaxSet(error: errorText!, length: length!);
  }
  return null;
}
RequiredValidator isRequired(String error){
  return RequiredValidator(errorText: error);
}
MultiValidator requiredAndLength({required String error, required int length}){
  return MultiValidator(<TextFieldValidator>[
    RequiredValidator(errorText: error),
    MinLengthValidator(length, errorText: error),   
  ]);
}
MultiValidator requiredAndLengthMaxSet({required String error, required int length}){
  return MultiValidator(<TextFieldValidator>[
    RequiredValidator(errorText: error),
    LengthRangeValidator(
      min: length,
      max: 25,
      errorText: error,
    ),      
  ]);
}
MultiValidator debitCardValidation({required String error, required int length}){
  return MultiValidator(<TextFieldValidator>[
    RequiredValidator(errorText: error),
    LuhnCheckValidator(errorText: error),  
    MinLengthValidator(length, errorText: error), 
  ]);
}
MultiValidator get phoneNumberValidator => MultiValidator(<TextFieldValidator>[
  RequiredValidator(errorText: 'Phone number is required'),
  PatternValidator(r'^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$',
      errorText: 'must contain a valid phone number'),
  ]);
MultiValidator get emailValidator => MultiValidator(<TextFieldValidator>[
    RequiredValidator(errorText: 'Email is required'),
    EmailValidator(errorText: 'Enter a valid email address'),
  ]);
MultiValidator get numericValidator => MultiValidator(<TextFieldValidator>[
  PatternValidator(r'(?=.*?[0-9])',
      errorText: 'must contain only numbers'),  
]);
MultiValidator get strongPasswordValidator => MultiValidator(<TextFieldValidator>[
  RequiredValidator(errorText: 'Password is required'),
  LengthRangeValidator(
    min: 8,
    max: 16,
    errorText: 'Password must be at between 8 and 16 characters long',
  ),
  PatternValidator(r'(?=.*?[#?!@$%^&*-])',
      errorText: 'passwords must have at least one special character'),
  PatternValidator(r'(?=.*?[A-Z])',
      errorText: 'passwords must have at least one upper case letter'),
  PatternValidator(r'(?=.*?[a-z])',
      errorText: 'passwords must have at least one lower case letter'),
  PatternValidator(r'(?=.*?[0-9])',
      errorText: 'passwords must have at least one number'),      
]);
MultiValidator get mediumPasswordValidator => MultiValidator(<TextFieldValidator>[
  RequiredValidator(errorText: 'Password is required'),
  LengthRangeValidator(
    min: 4,
    max: 16,
    errorText: 'Password must be at between 4 and 16 characters long',
  ),
  PatternValidator(r'(?=.*?[A-Z])',
      errorText: 'passwords must have at least one upper case letter'),
  PatternValidator(r'(?=.*?[a-z])',
      errorText: 'passwords must have at least one lower case letter'),
  PatternValidator(r'(?=.*?[0-9])',
      errorText: 'passwords must have at least one number'),      
]);
MultiValidator get weakPasswordValidator => MultiValidator(<TextFieldValidator>[
  RequiredValidator(errorText: 'Password is required'),
  LengthRangeValidator(
    min: 4,
    max: 16,
    errorText: 'Password must be at between 4 and 16 characters long',
  ),      
]);
MultiValidator get urlValidator => MultiValidator(<TextFieldValidator>[

  PatternValidator(r'(?=(http:\/\/|https:\/\/|www.)[\w-]+(\.[\w-]+)+([\w.,@?^=%&amp;:/~+#-]*[\w@?^=%&amp;/~+#-])?)',
      errorText: 'url must comply with a valid url'),  
]);
// ==================================================================================================
// FORMATTERS
// ==================================================================================================
List<TextInputFormatter> get nameFormatter => <TextInputFormatter>[
  LengthLimitingTextInputFormatter(35),
  FilteringTextInputFormatter.allow(RegExp('[A-Za-z0-9 ]'))
];
List<TextInputFormatter> get passwordFormatter => <TextInputFormatter>[
  LengthLimitingTextInputFormatter(16),
];

List<TextInputFormatter> get mobileNumberFormatter => <TextInputFormatter>[
  LengthLimitingTextInputFormatter(16),
  FilteringTextInputFormatter.allow(RegExp('[0-9 ]+')),
];

List<TextInputFormatter> get oneTimeCodeFormatter => <TextInputFormatter>[
  LengthLimitingTextInputFormatter(6),
  FilteringTextInputFormatter.allow(RegExp('[0-9+]')),
];

List<TextInputFormatter> get pinFormatter => <TextInputFormatter>[
  LengthLimitingTextInputFormatter(6),
];

List<TextInputFormatter> get emailVerificationCodeFormatter =>
  <TextInputFormatter>[
    LengthLimitingTextInputFormatter(6),
    FilteringTextInputFormatter.allow(RegExp('[0-9]'))
  ];
List<TextInputFormatter> justNumberFormatter({required int numberCount}) => <TextInputFormatter>[
  LengthLimitingTextInputFormatter(numberCount),
  FilteringTextInputFormatter.allow(RegExp('[0-9]')),
];
List<TextInputFormatter> lengthLimiterFormatter({required int numberCount}) => <TextInputFormatter>[
  LengthLimitingTextInputFormatter(numberCount),
];
// List<TextInputFormatter> expiryDateFormatter() => <TextInputFormatter>[
//   FilteringTextInputFormatter.allow(RegExp('[0-1]')),
// ];
List<TextInputFormatter> expiryDateFormatter() => <TextInputFormatter>[
  MaskedTextInputFormatter(mask: 'MM/YY', separator: '/'),
  FilteringTextInputFormatter.allow(RegExp('[0-9/]+')),
];
List<TextInputFormatter> amexCardFormatter() => <TextInputFormatter>[
  MaskedTextInputFormatter(mask: 'XXXX XXXXXX XXXXX', separator: ' '),
  FilteringTextInputFormatter.allow(RegExp('[0-9 ]+')),
];
List<TextInputFormatter> debitCardFormatter() => <TextInputFormatter>[
  MaskedTextInputFormatter(mask: 'XXXX XXXX XXXX XXXX', separator: ' '),
  FilteringTextInputFormatter.allow(RegExp('[0-9 ]+')),
];
List<TextInputFormatter> sortCodeFormatter() => <TextInputFormatter>[
  MaskedTextInputFormatter(mask: 'XX-XX-XX', separator: '-'),
  FilteringTextInputFormatter.allow(RegExp('[0-9-]+')),
];
// List<TextInputFormatter> expiryDateInputFormatter() => <TextInputFormatter>[
//  ExpiryDateFormatter(),
// ];

class MaskedTextInputFormatter extends TextInputFormatter{
  final String mask;
  final String separator;
  MaskedTextInputFormatter({
    required this.mask,
    required this.separator,
  });
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue){
    if(newValue.text.isNotEmpty){
      if(newValue.text.length > oldValue.text.length){
        if(newValue.text.length > mask.length) return oldValue;
        if(newValue.text[newValue.text.length - 1] == separator) return oldValue;
        if(newValue.text.length < mask.length && mask[newValue.text.length - 1] == separator){
          print('${oldValue.text}$separator${newValue.text.substring(newValue.text.length - 1)}');
          return TextEditingValue(
            text: '${oldValue.text}$separator${newValue.text.substring(newValue.text.length - 1)}',
            selection: TextSelection.collapsed(offset: newValue.selection.end + 1),
          );
        }
      }
    }
    return newValue;
  } 
}
class ExpiryDateFormatter extends TextInputFormatter{

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue){
    const String mask = 'MM/YY';

    if(newValue.text.isNotEmpty){
      if(newValue.text.length > mask.length) return oldValue;
      return TextEditingValue(
        text: mask,
        selection: TextSelection.collapsed(offset: newValue.selection.end + 1),
      );
    }
    return newValue;
  }
}
class LuhnCheckValidator extends TextFieldValidator {

  LuhnCheckValidator({required String errorText}) : super(errorText);
  
  @override
  bool get ignoreEmptyValues => false;

  @override
  bool isValid(String? value) {
    return isCreditCardValid(value!);
  }
}
bool isCreditCardValid(String cardNumber){

  String cleaned = cardNumber.replaceAll(RegExp('[^0-9.]'), '');
  int sum = 0;
  
  String lastDigitChar = cleaned.substring(cleaned.length - 1, cleaned.length);
  int lastDigit = int.parse(lastDigitChar);

  cleaned = cleaned.substring(0, cleaned.length - 1);
  int length = cleaned.length;

  for(var i = 0; i < length; i++){
    int digit = int.parse(cleaned[length - i - 1]);
    //every 2nd digit multiply by 2
    if(i.isEven) digit *= 2;
    //sum digits and reduce by 9 if > 9 so 18 = 1+8 = 9 which also is 18 - 9, and 16 = 1 + 6 = 7 which is also 16 - 9
    sum += digit > 9 ? (digit - 9) : digit;
  } 
  int total = sum % 10;
  int total2 = (10 - total) % 10;
  
  return total2 == lastDigit;
}
bool isLuhnCheckPassed(String creditCardNumber){

  String cleaned = creditCardNumber.replaceAll(RegExp('[^0-9.]'), '');

  int sum = 0;
  int length = cleaned.length;
  for(var i = 0; i < length; i++){
    int digit = int.parse(cleaned[length - i - 1]);
    //every 2nd digit multiply by 2
    if(i.isEven) digit *= 2;
    sum += digit > 9 ? (digit - 9) : digit;
    if(sum % 10 == 0) return true;
  }
  return false;
}