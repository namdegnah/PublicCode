abstract class Failure{
  final String message;
  Failure(this.message);
}
class ServerFailure extends Failure{
  ServerFailure(message) : super(message);
}
class UseCaseFailure extends Failure{
  UseCaseFailure(message) : super(message);
}
