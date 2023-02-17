import 'package:dartz/dartz.dart';
import '../errors/failures.dart';

abstract class UseCase<Type, Params>{
  Future<Either<Failure, Type>> call(Params params);
}
abstract class BeCase<T, Type>{
  Either<Type, T> beNice();
}
abstract class Car{
  String nameis();
}
abstract class Bar{
  String namewas();
}
abstract class Tar implements Car, Bar{
  String nameisnow();
}