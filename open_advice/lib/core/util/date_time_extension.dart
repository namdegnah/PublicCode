extension DateExtensions on DateTime {

  DateTime lessOneDay(){
    return DateTime(year, month, day - 1);
  }
  DateTime lessDays(int days){
    return DateTime(year, month, day - days);
  }
  DateTime plusOneDay(){
    return DateTime(year, month, day + 1);
  }
  DateTime plusDays(int days){
    return DateTime(year, month, day + days);
  }
  DateTime lessOneWeek(){
    return DateTime(year, month, day - 7);
  }
  DateTime plusOneWeek(){
    return DateTime(year, month, day + 7);
  }
  DateTime lessOneMonth(){
    return DateTime(year, month -1, day);
  }
  DateTime plusOneMonth(){
    return DateTime(year, month + 1, day);
  }
  DateTime lessOneQuarter(){
    return DateTime(year, month - 3, day);
  }
  DateTime plusOneQuarter(){
    return DateTime(year, month + 3, day);
  }
  DateTime lessOneYear(){
    return DateTime(year -1, month, day);
  }
  DateTime plusOneYear(){
    return DateTime(year + 1, month, day);
  }
  //For Recurrences
  DateTime plusDuration(int type){
  const week = 0; const month = 1; const quarter = 2; const year = 3;
    DateTime ans = DateTime.now();
    switch (type){
      case week:
        ans = plusOneWeek();
        break;
      case month:
        ans = plusOneMonth();
        break;
      case quarter:
        ans = plusOneQuarter();
        break;
      case year:
        ans = plusOneYear();
        break;
    }
    return ans;
  }
  bool areDatesEqual(DateTime other){
    if(day != other.day) return false;
    if(month != other.month) return false;
    if(year != other.year) return false;
    return true;
  }
  bool isBeforeOrEqual(DateTime other){
    if(isBefore(other) || other.areDatesEqual(this)){
      return true;
    } else {
      return false;
    }
  }
  bool isAfterOrEqual(DateTime other){
    if(isAfter(other) || other.areDatesEqual(this)){
      return true;
    } else {
      return false;
    }
  }
  List<DateTime> endOfNextMonths(int noDates){
    List<DateTime> ends = [];
    DateTime nd;
    nd = endOfthisMonth();
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
    nd = DateTime(year, month, day + 1);
    while(nd.day != 1){
      nd = DateTime(nd.year, nd.month, nd.day + 1);
    }
    nd = DateTime(nd.year, nd.month, nd.day - 1);
    return nd;
  }  
  DateTime getWeeklyNextDate(DateTime today){
    DateTime nd = this;
    if(difference(today).inDays < 0){
      while(nd.isBefore(today)){
        nd = DateTime(nd.year, nd.month, nd.day + 7);
      }
    }
    return nd;
  }  
  DateTime getMonthlyNextDate(DateTime today){
    DateTime nd = this;
    if(difference(today).inDays < 0){
      while(nd.isBefore(today)){
        nd = DateTime(nd.year, nd.month + 1, nd.day);
      }
    }
    return nd;
  }
  DateTime getQuarterlyNextDate(DateTime today){
    DateTime nd = this;
    if(difference(today).inDays < 0){
      while(nd.isBefore(today)){
        nd = DateTime(nd.year, nd.month + 3, nd.day);
      }
    }
    return nd;
  }
  DateTime getYearlyNextDate(DateTime today){
    DateTime nd = this;
    if(difference(today).inDays < 0){
      while(nd.isBefore(today)){
        nd = DateTime(nd.year + 1, nd.month, nd.day);
      }
    }
    return nd;
  }
  OcurrenceSince ocurrenceWeeklySinceStart({required DateTime plannedDate}){
    int noOccurences = 0;
    while(plannedDate.isBefore(this)){
      noOccurences++;
      plannedDate = DateTime(plannedDate.year, plannedDate.month, plannedDate.day + 7);
    }
    return OcurrenceSince(nextDate: plannedDate, noPaid: noOccurences);
  } 
  OcurrenceSince ocurrenceMonthlySinceStart({required DateTime plannedDate}){
    int noOccurences = 0;
    while(plannedDate.isBefore(this)){
      noOccurences++;
      plannedDate = DateTime(plannedDate.year, plannedDate.month + 1, plannedDate.day);
    }
    return OcurrenceSince(nextDate: plannedDate, noPaid: noOccurences);
  }
  OcurrenceSince ocurrenceQuarterlySinceStart({required DateTime plannedDate}){
    int noOccurences = 0;
    while(plannedDate.isBefore(this)){
      noOccurences++;
      plannedDate = DateTime(plannedDate.year, plannedDate.month + 3, plannedDate.day);
    }
    return OcurrenceSince(nextDate: plannedDate, noPaid: noOccurences);
  }
  OcurrenceSince ocurrenceYearlySinceStart({required DateTime plannedDate}){
    int noOccurences = 0;
    while(plannedDate.isBefore(this)){
      noOccurences++;
      plannedDate = DateTime(plannedDate.year + 1, plannedDate.month, plannedDate.day);
    }
    return OcurrenceSince(nextDate: plannedDate, noPaid: noOccurences);
  }  
  DateTime adjustMonths({required int noMonths}){
    return DateTime(year, month + noMonths, day);
  }         
}
class OcurrenceSince{
  DateTime nextDate;
  int noPaid;
  OcurrenceSince({required this.nextDate, required this.noPaid});
}