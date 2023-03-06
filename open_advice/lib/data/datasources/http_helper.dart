import 'dart:convert' as conv show json;
import '../../domain/entities/match.dart';
import '../../domain/entities/best_team.dart';
import '../../domain/entities/current_season.dart';
import 'package:http/http.dart' as http;


Map<String, String> get headers => {
  'Content-type': 'application/json',
  'Accept': 'application/json',
  'X-Auth-Token': '518d56336b044c9fa814e38c2e034200'
};
Future<List<Match>> getFootballJson({required String dateFrom, required String dateTo}) async {

  List<Match> matches = [];
  var url = 'https://api.football-data.org/v4/competitions/PL/matches?dateFrom=$dateFrom&dateTo=$dateTo';
  var response = await http.get(Uri.parse(url), headers: headers);
  if (response.statusCode != 200) {
    throw Exception(
        "Request to $url failed with status ${response.statusCode}: ${response.body}");
  } 
  var json = conv.json.decode(response.body);
  var matchesJson = json['matches'];
  for(var map in matchesJson){
    matches.add(Match.fromJson(map));
  }
  return matches;
}
Future<CurrentSeason> getCurrentSeason() async {
  var url = 'https://api.football-data.org/v4/competitions/PL/';
  var response = await http.get(Uri.parse(url), headers: headers);
  if (response.statusCode != 200) {
    throw Exception(
        "Request to $url failed with status ${response.statusCode}: ${response.body}");
  }
  var json = conv.json.decode(response.body);
  var currentSeasonJson = json['currentSeason'];
  return CurrentSeason.fromJson(currentSeasonJson);    
}
Future<BestTeam> getBestTeam(int id) async {
  var url = 'https://api.football-data.org/v4/teams/$id/';  
  var response = await http.get(Uri.parse(url), headers: headers);
  if (response.statusCode != 200) {
    throw Exception(
        "Request to $url failed with status ${response.statusCode}: ${response.body}");
  }
  var json = conv.json.decode(response.body);
  return BestTeam.fromJson(json);    
}