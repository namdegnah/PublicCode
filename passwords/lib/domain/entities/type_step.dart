
class TypeStep{

  TypeStep({
    required this.stepNo, 
    required this.description,
    required this.validationDescription,    
  });
  late int stepNo; // this is provided by the list when loaded, it is the order of the wizard
  late String description; // 
  late String validationDescription;  
}