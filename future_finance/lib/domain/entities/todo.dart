class Todo {
  int id;
  int userId;
  String title;
  String? description;
  String? dueDate;
  Todo(
    {required this.id,
    required this.userId,
    required this.title,
    this.description,
    this.dueDate}
    );
  @override
  bool operator ==(Object other) =>
    identical(this, other) ||
    other is Todo &&
    runtimeType == other.runtimeType &&
    id == other.id &&
    title == other.title;

  @override
  int get hashCode => id.hashCode ^ userId.hashCode ^ title.hashCode;    
}