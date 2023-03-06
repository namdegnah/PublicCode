import 'package:flutter/cupertino.dart';

@immutable
class CurrentSeason {
  CurrentSeason({
    required this.id,
    required this.startDate,
    required this.endDate,
    required this.currentMatchday,
     this.winner,
  });
  late final int id;
  late final String startDate;
  late final String endDate;
  late final int currentMatchday;
  late final Null winner;
  
  CurrentSeason.fromJson(Map<String, dynamic> json){
    id = json['id'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    currentMatchday = json['currentMatchday'];
    winner = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['startDate'] = startDate;
    _data['endDate'] = endDate;
    _data['currentMatchday'] = currentMatchday;
    _data['winner'] = winner;
    return _data;
  }
}