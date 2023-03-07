import 'package:flutter/cupertino.dart';

@immutable
class BestTeam {
  BestTeam({
    required this.area,
    required this.id,
    required this.name,
    required this.shortName,
    required this.tla,
    required this.crest,
    required this.address,
    required this.website,
    required this.founded,
    required this.clubColors,
    required this.venue,
    required this.runningCompetitions,
    required this.coach,
    required this.squad,
    required this.staff,
    required this.lastUpdated,
    this.originalId,
  });
  late final Area area;
  late final int id;
  late final String name;
  late final String shortName;
  late final String tla;
  late final String crest;
  late final String address;
  late final String website;
  late final int founded;
  late final String clubColors;
  late final String venue;
  late final List<RunningCompetitions> runningCompetitions;
  late final Coach coach;
  late final List<Squad> squad;
  late final List<dynamic> staff;
  late final String lastUpdated;
  late int? originalId;
  
  BestTeam.fromJson(Map<String, dynamic> json){
    area = Area.fromJson(json['area']);
    id = json['id'];
    name = json['name'];
    shortName = json['shortName'];
    tla = json['tla'];
    crest = json['crest'];
    address = json['address'];
    website = json['website'];
    founded = json['founded'];
    clubColors = json['clubColors'];
    venue = json['venue'];
    runningCompetitions = List.from(json['runningCompetitions']).map((e)=>RunningCompetitions.fromJson(e)).toList();
    coach = Coach.fromJson(json['coach']);
    squad = List.from(json['squad']).map((e)=>Squad.fromJson(e)).toList();
    staff = List.castFrom<dynamic, dynamic>(json['staff']);
    lastUpdated = json['lastUpdated'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['area'] = area.toJson();
    _data['id'] = id;
    _data['name'] = name;
    _data['shortName'] = shortName;
    _data['tla'] = tla;
    _data['crest'] = crest;
    _data['address'] = address;
    _data['website'] = website;
    _data['founded'] = founded;
    _data['clubColors'] = clubColors;
    _data['venue'] = venue;
    _data['runningCompetitions'] = runningCompetitions.map((e)=>e.toJson()).toList();
    _data['coach'] = coach.toJson();
    _data['squad'] = squad.map((e)=>e.toJson()).toList();
    _data['staff'] = staff;
    _data['lastUpdated'] = lastUpdated;
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

class RunningCompetitions {
  RunningCompetitions({
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
  
  RunningCompetitions.fromJson(Map<String, dynamic> json){
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

class Coach {
  Coach({
    required this.id,
    required this.firstName,
     this.lastName,
    required this.name,
    required this.dateOfBirth,
    required this.nationality,
    required this.contract,
  });
  late final int id;
  late final String firstName;
  late final Null lastName;
  late final String name;
  late final String dateOfBirth;
  late final String nationality;
  late final Contract contract;
  
  Coach.fromJson(Map<String, dynamic> json){
    id = json['id'];
    firstName = json['firstName'];
    lastName = null;
    name = json['name'];
    dateOfBirth = json['dateOfBirth'];
    nationality = json['nationality'];
    contract = Contract.fromJson(json['contract']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['firstName'] = firstName;
    _data['lastName'] = lastName;
    _data['name'] = name;
    _data['dateOfBirth'] = dateOfBirth;
    _data['nationality'] = nationality;
    _data['contract'] = contract.toJson();
    return _data;
  }
}

class Contract {
  Contract({
     required this.start,
     required this.until,
  });
  late final DateTime start;
  late final DateTime until;
  
  Contract.fromJson(Map<String, dynamic> json){
    start = json['start'] ?? DateTime.now();
    until = json['until'] ?? DateTime.now();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['start'] = start;
    _data['until'] = until;
    return _data;
  }
}

class Squad {
  Squad({
    required this.id,
    required this.name,
    required this.position,
    required this.dateOfBirth,
    required this.nationality,
  });
  late final int id;
  late final String name;
  late final String position;
  late final String dateOfBirth;
  late final String nationality;
  
  Squad.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    position = json['position'];
    dateOfBirth = json['dateOfBirth'];
    nationality = json['nationality'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['position'] = position;
    _data['dateOfBirth'] = dateOfBirth;
    _data['nationality'] = nationality;
    return _data;
  }
}