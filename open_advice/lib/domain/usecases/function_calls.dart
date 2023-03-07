import '../../presentation/config/navigation/navigation_paths.dart';
import '../../presentation/config/injection_container.dart';
import '../../presentation/config/navigation/app_navigation.dart';
import '../entities/password.dart';
import '../entities/match.dart';
import '../entities/best_team.dart';
import '../entities/current_season.dart';
import 'package:flutter/services.dart';
import 'dart:convert' as conv show json;

  Future<void> loadNextPage() async {
    await sl<AppNavigation>().pushNamed(NavigationPaths.next);
  }
  Future<void> loadFootballPage() async {
    await sl<AppNavigation>().pushNamed(NavigationPaths.footabll);
  }
  Future<List<Password>> getPasswordList() async {

    List<Password> passwords = [];
    String jsondata = await readJson('assets/json/userpasswords.json');
    final extractedData = conv.json.decode(jsondata) as Map<String, dynamic>;

    List<dynamic> passwordMaps = extractedData['Passwords'];
    if (passwordMaps.isNotEmpty) {
      for (var map in passwordMaps) {
        passwords.add(Password.fromJson(map));
      }
    }
    return passwords;
  }
  Future<List<Match>> getMatchList() async {
    List<Match> matches = [];
    String jsondata = await readJson('assets/json/football.json');
    var json = conv.json.decode(jsondata);
    var matchesJson = json['matches'];
    for(var map in matchesJson){
      matches.add(Match.fromJson(map));
    }
    return matches;
  }
  Future<CurrentSeason> getCurrentSeason() async {
    String jsondata = await readJson('assets/json/currentSeason.json');
    var json = conv.json.decode(jsondata);
    var currentSeasonJson = json['currentSeason'];
    return CurrentSeason.fromJson(currentSeasonJson);
  }
  Future<BestTeam> getBestTeam() async {
    String jsondata = await readJson('assets/json/bestTeam.json');
    var bestTeamJson = conv.json.decode(jsondata);
    return BestTeam.fromJson(bestTeamJson); 
  }     
  Future<String> readJson(String fileName) async {
    try {
      return await rootBundle.loadString(fileName);
    } catch (error) {
      rethrow;
    }
  }

