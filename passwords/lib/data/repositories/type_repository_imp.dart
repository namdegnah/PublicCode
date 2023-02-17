import 'package:dartz/dartz.dart';
import '../datasources/data_sources.dart';
import '../../core/errors/exceptions.dart';
import '../../core/errors/failures.dart';
import '../../domain/entities/type.dart';
import '../../domain/repositories/repositories_all.dart';
import '../../presentation/config/constants.dart';


typedef _TypeOrFailure = Future<List<Type>> Function();

class TypeRepositoryImp extends TypeRepository {
  final AppDataSource dataSource;
  TypeRepositoryImp({required this.dataSource});
  @override
  Future<Either<Failure, List<Type>>> insertType(Type type) async {
    return await _getTypeResults(() async{
      await dataSource.insert(TypeNames.tableName, _toType(type));
      return await _typeList();
    }); 
  }
  @override
  Future<Either<Failure, List<Type>>> insertTypeField(Type type) async {
    return await _getTypeResults(() async{
      await dataSource.insert(TypeNames.tableName, _toType(type));
      return await _typeList();
    }); 
  }  
  @override
  Future<Either<Failure, List<Type>>> typeList() async {
    return await _getTypeResults(() async {
      return await _typeList();
    });
  }   
  @override
  Future<Either<Failure, List<Type>>> deleteType(Type type) async {
    try{
      await dataSource.delete(TypeNames.tableName, type.id);
      return Right(await _typeList());         
    } on ServerException catch(error){
      return Left(ServerFailure(error.message));
    } on Exception catch(error){
      return Left(ServerFailure(error.toString()));
    }
  }    
  @override
  Future<Either<Failure, List<Type>>> updateType(Type type) async {
    try{
      await dataSource.update(TypeNames.tableName, type.id, _toType(type));
      return Right(await _typeList());
    } on ServerException catch(error){
      return Left(ServerFailure(error.message));
    } on Exception catch(error){
        return Left(ServerFailure(error.toString()));
    }
  }   
  Future<List<Type>> _typeList() async {
    final dataList = await dataSource.getData(TypeNames.tableName);
    return _dbTypeToList(dataList);
  }   
  List<Type> _dbTypeToList(List<Map<String, dynamic>> data){
    final List<Type> _items = data.map(
      (item) => Type(
        id: item[TypeNames.id],
        name: item[TypeNames.name],
        fields: item[TypeNames.fields],
        passwordValidationId: item[TypeNames.passwordValidationId],   
      ),
    ).toList(); 
    return _items;    
  }   
  Future<Either<Failure, List<Type>>> _getTypeResults(_TypeOrFailure typeOrFailure) async {
    try{
      final typeList = await typeOrFailure();
      return Right(typeList);
    } on ServerException catch(error){
      return Left(ServerFailure(error.message));
    } on Exception catch(error){
      return Left(ServerFailure(error.toString()));
    }
  }    
  Map<String, Object> _toType(Type type){
    return {
      TypeNames.name: type.name,
      TypeNames.fields: type.fields,
      TypeNames.passwordValidationId: type.passwordValidationId ?? 0,
    };
  }   
}