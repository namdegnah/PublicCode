abstract class Failure{
  final String message;
  Failure(this.message);
}
class ServerFailure extends Failure{
  ServerFailure(message) : super(message);
}
class DateConversionFailure extends Failure{
  DateConversionFailure(message) : super(message);
  @override
  bool operator ==(Object other) =>
    identical(this, other) ||
    other is DateConversionFailure &&
    runtimeType == other.runtimeType &&
    message == other.message;

  @override
  int get hashCode => message.hashCode;  
}
