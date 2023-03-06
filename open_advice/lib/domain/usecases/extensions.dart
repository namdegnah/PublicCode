import '../entities/team.dart';
extension CountingExtensions on List<Team>{

  int getMaxCount(){

    int maxCount = 1;
    int count = 1;
    for(var i = 0; i < length - 1; i++){
      if(this[i].name.compareTo(this[i+1].name) == 0){
        count++;
        if(count > maxCount) maxCount = count;
      } else {
        count = 1;
      }
    }
    return maxCount;
  }
  int getCountOfMaxValue(int maxValue){
    int count = 1;
    int noMaxValues = 0;
    for(var i = 0; i < length - 1; i++){
      if(this[i].name.compareTo(this[i+1].name) == 0){
        count++;
        if(count == maxValue) noMaxValues++;
      } else {
        count = 1;
      }     
    }
    return noMaxValues;
  }
  Team getValueOfMax(int noMaxValues, int maxValue){
    final potentialAnswers = <Team>[];
    int count = 1;
    for(var i = 0; i < length - 1; i++){
      if(this[i].name.compareTo(this[i+1].name) == 0){
        count++;
        if(count == maxValue) {
          potentialAnswers.add(this[i]);
        }
      } else {
        count = 1;
      }     
    }    
    if(potentialAnswers.length == 1){
      return potentialAnswers[0];
    } else {
      potentialAnswers.sort((a, b) => a.name.compareTo(b.name));
      return potentialAnswers.first;
    }   
  }
}

