  import '../entities/password.dart';
  
  late List<Password> _fulldata;
  late List<Password> _results;
  List<Password> get results => _results;
  List<Password> get fulldata => _fulldata;
  set fulldata(List<Password> data) => _results = _fulldata = data;
  void initialise() {} 
  
  void userInput(String criteria){
    if(criteria.isEmpty){
      _results = _fulldata;
    } else {
      _results = _fulldata.where((data) => _getSearchResult(data, criteria)).toList();
    }
  }
  bool _getSearchResult(Password password, String criteria){
    bool result = false;
    // print('description: ${password.description}, ${criteria.toLowerCase()}, ${password.description.toLowerCase().startsWith(criteria.toLowerCase())}');
    result = password.description.toLowerCase().startsWith(criteria.toLowerCase()) || password.description.toLowerCase().contains(criteria.toLowerCase());
    return result;
  }
  int noItemsToShow(){
    return  _results.length;
  }