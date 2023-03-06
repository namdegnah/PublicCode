import '../entities/photo.dart';

class Album {
  Album({
    required this.userId,
    required this.id,
    required this.title,
  });
  late final int userId;
  late final int id;
  late final String title;
  late final List<Photo> photos;
  
  Album.fromJson(Map<String, dynamic> json){
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['userId'] = userId;
    _data['id'] = id;
    _data['title'] = title;
    return _data;
  }
}