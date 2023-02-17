extension dateExtensions on DateTime {

  DateTime lessYears(int years){
    return DateTime(this.year - years, this.month, this.day);
  }
  DateTime plusYears(int years){
    return DateTime(this.year + years, this.month, this.day);
  }

  DateTime lessOneDay(){
    return DateTime(this.year, this.month, this.day - 1);
  }
  DateTime plusOneDay(){
    return DateTime(this.year, this.month, this.day + 1);
  }
  DateTime lessOneWeek(){
    return DateTime(this.year, this.month, this.day - 7);
  }
  DateTime plusOneWeek(){
    return DateTime(this.year, this.month, this.day + 7);
  }
  DateTime lessOneMonth(){
    return DateTime(this.year, this.month -1, this.day);
  }
  DateTime plusOneMonth(){
    return DateTime(this.year, this.month + 1, this.day);
  }
  DateTime lessOneQuarter(){
    return DateTime(this.year, this.month - 3, this.day);
  }
  DateTime plusOneQuarter(){
    return DateTime(this.year, this.month + 3, this.day);
  }
  DateTime lessOneYear(){
    return DateTime(this.year -1, this.month, this.day);
  }
  DateTime plusOneYear(){
    return DateTime(this.year + 1, this.month, this.day);
  }

  bool areDatesEqual(DateTime other){
    if(this.day != other.day) return false;
    if(this.month != other.month) return false;
    if(this.year != other.year) return false;
    return true;
  }
  bool isBeforeOrEqual(DateTime other){
    if(this.isBefore(other) || other.areDatesEqual(this)){
      return true;
    } else {
      return false;
    }
  }
  bool isAfterOrEqual(DateTime other){
    if(this.isAfter(other) || other.areDatesEqual(this)){
      return true;
    } else {
      return false;
    }
  }
  List<DateTime> endOfNextMonths(int noDates){
    List<DateTime> ends = [];
    DateTime nd;
    nd = this.endOfthisMonth();
    ends.add(nd);
    for(int i = 0; i < noDates - 1; i++){
      nd = DateTime(nd.year, nd.month, nd.day + 1);
      nd = nd.endOfthisMonth();
      ends.add(nd);      
    }
    return ends;
  }
  DateTime endOfthisMonth(){
    DateTime nd;
    nd = DateTime(this.year, this.month, this.day + 1);
    while(nd.day != 1){
      nd = DateTime(nd.year, nd.month, nd.day + 1);
    }
    nd = DateTime(nd.year, nd.month, nd.day - 1);
    return nd;
  }  
  DateTime getWeeklyNextDate(DateTime today){
    DateTime nd = this;
    if(this.difference(today).inDays < 0){
      while(nd.isBefore(today)){
        nd = DateTime(nd.year, nd.month, nd.day + 7);
      }
    }
    return nd;
  }  
  DateTime getMonthlyNextDate(DateTime today){
    DateTime nd = this;
    if(this.difference(today).inDays < 0){
      while(nd.isBefore(today)){
        nd = DateTime(nd.year, nd.month + 1, nd.day);
      }
    }
    return nd;
  }
  DateTime getQuarterlyNextDate(DateTime today){
    DateTime nd = this;
    if(this.difference(today).inDays < 0){
      while(nd.isBefore(today)){
        nd = DateTime(nd.year, nd.month + 3, nd.day);
      }
    }
    return nd;
  }
  DateTime getYearlyNextDate(DateTime today){
    DateTime nd = this;
    if(this.difference(today).inDays < 0){
      while(nd.isBefore(today)){
        nd = DateTime(nd.year + 1, nd.month, nd.day);
      }
    }
    return nd;
  }
        
}
