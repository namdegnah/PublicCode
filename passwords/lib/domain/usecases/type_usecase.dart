import 'package:dartz/dartz.dart';
import '../../data/models/params.dart';
import '../../core/errors/failures.dart';
import '../../core/usecases/usecase.dart';
import '../entities/type.dart';
import '../repositories/repositories_all.dart';

class TypeUser extends UseCase<List<Type>, Params> {
  final TypeRepository repository;
  TypeUser({required this.repository});

  @override
  Future<Either<Failure, List<Type>>> call(Params params) async {
    int userId = params.id;
    return await repository.typeList();
  }
 Future<Either<Failure, List<Type>>> getTypes() async {
    return await repository.typeList();
  }
  Future<Either<Failure, List<Type>>> insertType(Params params) async {
    Type type = params.type;
    return await repository.insertType(type);
  }
  Future<Either<Failure, List<Type>>> deleteType(Params params) async {
    Type type = params.type;
    return await repository.deleteType(type);
  }
  Future<Either<Failure, List<Type>>> updateType(Params params) async {
    Type type = params.type;
    return await repository.updateType(type);
  }
  Future<Either<Failure, List<Type>>> insertTypeField(Params params) async {
    Type type = params.type;
    return await repository.insertType(type);
  }    
}
