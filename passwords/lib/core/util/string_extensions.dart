extension StringExtensions on String{

  String replaceCharAt({required int index, required String newChar}) {
    return substring(0, index) + newChar + substring(index + 1);
  }  
}