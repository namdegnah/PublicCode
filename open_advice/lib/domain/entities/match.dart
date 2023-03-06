import 'package:flutter/cupertino.dart';

@immutable
class Match {
  Match({
    required this.area,
    required this.competition,
    required this.season,
    required this.id,
    required this.utcDate,
    required this.status,
    required this.matchday,
    required this.stage,
     this.group,
    required this.lastUpdated,
    required this.homeTeam,
    required this.awayTeam,
    required this.score,
    required this.odds,
    required this.referees,
  });
  late final Area area;
  late final Competition competition;
  late final Season season;
  late final int id;
  late final String utcDate;
  late final String status;
  late final int matchday;
  late final String stage;
  late final Null group;
  late final String lastUpdated;
  late final HomeTeam homeTeam;
  late final AwayTeam awayTeam;
  late final Score score;
  late final Odds odds;
  late final List<Referees> referees;
  
  Match.fromJson(Map<String, dynamic> json){
    area = Area.fromJson(json['area']);
    competition = Competition.fromJson(json['competition']);
    season = Season.fromJson(json['season']);
    id = json['id'];
    utcDate = json['utcDate'];
    status = json['status'];
    matchday = json['matchday'];
    stage = json['stage'];
    group = null;
    lastUpdated = json['lastUpdated'];
    homeTeam = HomeTeam.fromJson(json['homeTeam']);
    awayTeam = AwayTeam.fromJson(json['awayTeam']);
    score = Score.fromJson(json['score']);
    odds = Odds.fromJson(json['odds']);
    referees = List.from(json['referees']).map((e)=>Referees.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['area'] = area.toJson();
    _data['competition'] = competition.toJson();
    _data['season'] = season.toJson();
    _data['id'] = id;
    _data['utcDate'] = utcDate;
    _data['status'] = status;
    _data['matchday'] = matchday;
    _data['stage'] = stage;
    _data['group'] = group;
    _data['lastUpdated'] = lastUpdated;
    _data['homeTeam'] = homeTeam.toJson();
    _data['awayTeam'] = awayTeam.toJson();
    _data['score'] = score.toJson();
    _data['odds'] = odds.toJson();
    _data['referees'] = referees.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Area {
  Area({
    required this.id,
    required this.name,
    required this.code,
    required this.flag,
  });
  late final int id;
  late final String name;
  late final String code;
  late final String flag;
  
  Area.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    code = json['code'];
    flag = json['flag'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['code'] = code;
    _data['flag'] = flag;
    return _data;
  }
}

class Competition {
  Competition({
    required this.id,
    required this.name,
    required this.code,
    required this.type,
    required this.emblem,
  });
  late final int id;
  late final String name;
  late final String code;
  late final String type;
  late final String emblem;
  
  Competition.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    code = json['code'];
    type = json['type'];
    emblem = json['emblem'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['code'] = code;
    _data['type'] = type;
    _data['emblem'] = emblem;
    return _data;
  }
}

class Season {
  Season({
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
  
  Season.fromJson(Map<String, dynamic> json){
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

class HomeTeam {
  HomeTeam({
    required this.id,
    required this.name,
    required this.shortName,
    required this.tla,
    required this.crest,
  });
  late final int id;
  late final String name;
  late final String shortName;
  late final String tla;
  late final String crest;
  
  HomeTeam.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    shortName = json['shortName'];
    tla = json['tla'];
    crest = json['crest'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['shortName'] = shortName;
    _data['tla'] = tla;
    _data['crest'] = crest;
    return _data;
  }
}

class AwayTeam {
  AwayTeam({
    required this.id,
    required this.name,
    required this.shortName,
    required this.tla,
    required this.crest,
  });
  late final int id;
  late final String name;
  late final String shortName;
  late final String tla;
  late final String crest;
  
  AwayTeam.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    shortName = json['shortName'];
    tla = json['tla'];
    crest = json['crest'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['shortName'] = shortName;
    _data['tla'] = tla;
    _data['crest'] = crest;
    return _data;
  }
}

class Score {
  Score({
    required this.winner,
    required this.duration,
    required this.fullTime,
    required this.halfTime,
  });
  late final String? winner;
  late final String duration;
  late final FullTime fullTime;
  late final HalfTime halfTime;
  
  Score.fromJson(Map<String, dynamic> json){
    winner = json['winner'] ?? 'null value in data';
    duration = json['duration'];
    fullTime = FullTime.fromJson(json['fullTime']);
    halfTime = HalfTime.fromJson(json['halfTime']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['winner'] = winner;
    _data['duration'] = duration;
    _data['fullTime'] = fullTime.toJson();
    _data['halfTime'] = halfTime.toJson();
    return _data;
  }
}

class FullTime {
  FullTime({
    required this.home,
    required this.away,
  });
  late final int home;
  late final int away;
  
  FullTime.fromJson(Map<String, dynamic> json){
    home = json['home'] ?? -1;
    away = json['away'] ?? -1;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['home'] = home;
    _data['away'] = away;
    return _data;
  }
}

class HalfTime {
  HalfTime({
    required this.home,
    required this.away,
  });
  late final int home;
  late final int away;
  
  HalfTime.fromJson(Map<String, dynamic> json){
    home = json['home'] ?? -1;
    away = json['away'] ?? -1;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['home'] = home;
    _data['away'] = away;
    return _data;
  }
}

class Odds {
  Odds({
    required this.msg,
  });
  late final String msg;
  
  Odds.fromJson(Map<String, dynamic> json){
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['msg'] = msg;
    return _data;
  }
}

class Referees {
  Referees({
    required this.id,
    required this.name,
    required this.type,
    required this.nationality,
  });
  late final int id;
  late final String name;
  late final String type;
  late final String nationality;
  
  Referees.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    type = json['type'];
    nationality = json['nationality'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['type'] = type;
    _data['nationality'] = nationality;
    return _data;
  }
}