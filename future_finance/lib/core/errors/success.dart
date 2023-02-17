abstract class Success{
  final String message;
  Success(this.message);
}
class ServerSuccess extends Success{
  ServerSuccess(message) : super(message);
}