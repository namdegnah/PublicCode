import 'dart:convert' as conv show utf8, json;
import 'dart:io' as io;
import 'package:flutter/foundation.dart' show compute;
import '../../domain/entities/photo.dart';
import '../../domain/entities/post.dart';
import '../../domain/entities/user.dart';
import '../../domain/entities/comment.dart';
import '../../domain/entities/to_do.dart';
import '../../domain/entities/album.dart';
import '../../domain/entities/match.dart';
import '../../domain/entities/best_team.dart';
import '../../domain/entities/current_season.dart';
import 'package:http/http.dart' as http;

Future<Iterable<Post>> downloadAndParsePosts(Uri uri) => io.HttpClient()
 . getUrl(uri)
 .then((req) => req.close())
 .then((response) => response.transform(conv.utf8.decoder).join())
 .then((jsonString) => conv.json.decode(jsonString) as List<dynamic>)
 .then((json) => json.map((map) => Post.fromJson(map))
);
Future<Iterable<User>> downloadAndParseUsers(Uri uri) => io.HttpClient()
 . getUrl(uri)
 .then((req) => req.close())
 .then((response) => response.transform(conv.utf8.decoder).join())
 .then((jsonString) => conv.json.decode(jsonString) as List<dynamic>)
 .then((json) => json.map((map) => User.fromJson(map))
);
Future<Iterable<Comment>> downloadAndParseComments(Uri uri) => io.HttpClient()
 . getUrl(uri)
 .then((req) => req.close())
 .then((response) => response.transform(conv.utf8.decoder).join())
 .then((jsonString) => conv.json.decode(jsonString) as List<dynamic>)
 .then((json) => json.map((map) => Comment.fromJson(map))
);
Future<Iterable<ToDo>> downloadAndParseToDos(Uri uri) => io.HttpClient()
 . getUrl(uri)
 .then((req) => req.close())
 .then((response) => response.transform(conv.utf8.decoder).join())
 .then((jsonString) => conv.json.decode(jsonString) as List<dynamic>)
 .then((json) => json.map((map) => ToDo.fromJson(map))
);
Future<Iterable<Album>> downloadAndParseAlbums(Uri uri) => io.HttpClient()
 . getUrl(uri)
 .then((req) => req.close())
 .then((response) => response.transform(conv.utf8.decoder).join())
 .then((jsonString) => conv.json.decode(jsonString) as List<dynamic>)
 .then((json) => json.map((map) => Album.fromJson(map))
);
Future<Iterable<Photo>> downloadAndParsePhotos(Uri uri) => io.HttpClient()
 . getUrl(uri)
 .then((req) => req.close())
 .then((response) => response.transform(conv.utf8.decoder).join())
 .then((jsonString) => conv.json.decode(jsonString) as List<dynamic>)
 .then((json) => json.map((map) => Photo.fromJson(map))
);
Future<Iterable<Match>> downloadAndParseMatches(Uri uri) => io.HttpClient()
 . getUrl(uri)
 .then((req) => req.close())
 .then((response) => response.transform(conv.utf8.decoder).join())
 .then((jsonString) => conv.json.decode(jsonString) as List<dynamic>)
 .then((json) => json[3].map((map) => Match.fromJson(map))
);
Future<List<Match>> getMatches() async {
  final matches = await compute(
    downloadAndParseMatches, 
    Uri.parse('https://api.football-data.org/v4/competitions/PL/matches?X-Auth-Token=518d56336b044c9fa814e38c2e034200&dateFrom=2022-08-28&dateTo=2022-09-27'),
  );
  return matches.toList();
}
Future<List<Post>> getPosts() async {
  final posts = await compute(
    downloadAndParsePosts, 
    Uri.parse('https://jsonplaceholder.typicode.com/posts'),
  );
  return posts.toList();
}
Future<List<User>> getUsers() async {
  final users = await compute(
    downloadAndParseUsers, 
    Uri.parse('https://jsonplaceholder.typicode.com/users'),
  );
  return users.toList();
}
Future<List<Comment>> getComments() async {
  final comments = await compute(
    downloadAndParseComments, 
    Uri.parse('https://jsonplaceholder.typicode.com/comments'),
  );
  return comments.toList();
}
Future<List<ToDo>> getToDos() async {
  final todos = await compute(
    downloadAndParseToDos, 
    Uri.parse('https://jsonplaceholder.typicode.com/todos'),
  );
  return todos.toList();
}
Future<List<Album>> getAlbums() async {
  final albums = await compute(
    downloadAndParseAlbums, 
    Uri.parse('https://jsonplaceholder.typicode.com/albums'),
  );
  return albums.toList();
}
Future<List<Photo>> getPhotos() async {
  final photos = await compute(
    downloadAndParsePhotos, 
    Uri.parse('https://jsonplaceholder.typicode.com/photos'),
  );
  return photos.toList();
}
Map<String, String> get headers => {
  'Content-type': 'application/json',
  'Accept': 'application/json',
  'X-Auth-Token': '518d56336b044c9fa814e38c2e034200'
};
Future<List<Match>> getFootballJson({required String dateFrom, required String dateTo}) async {

  // also check the email
  // readme needs to be done
  // portrait and landscape
  // tablet and mobile
  // remove all other code
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