import 'package:dartz/dartz.dart';
import '../datasources/data_sources.dart';
import '../../core/errors/exceptions.dart';
import '../../core/errors/failures.dart';
import '../../domain/entities/group.dart';
import '../../domain/repositories/repositories_all.dart';
import '../../presentation/config/constants.dart';

typedef _GroupOrFailure = Future<List<Group>> Function();

class GroupRepositoryImp extends GroupRepository {
  final AppDataSource dataSource;
  GroupRepositoryImp({required this.dataSource});

  @override
  Future<Either<Failure, List<Group>>> insertGroup(Group group) async {
    return await _getGroupResults(() async{
      await dataSource.insert(GroupNames.tableName, _toGroup(group));
      return await _groupList();
    }); 
  }
  @override
  Future<Either<Failure, List<Group>>> groupList() async {
    return await _getGroupResults(() async {
      return await _groupList();
    });
  }   
  @override
  Future<Either<Failure, List<Group>>> deleteGroup(int id) async {
    try{
      await dataSource.delete(GroupNames.tableName, id);
      return Right(await _groupList());         
    } on ServerException catch(error){
      return Left(ServerFailure(error.message));
    } on Exception catch(error){
      return Left(ServerFailure(error.toString()));
    }
  }  
  @override
  Future<Either<Failure, List<Group>>> updateGroup(Group group) async {
    try{
      await dataSource.update(GroupNames.tableName, group.id, _toGroup(group));
      return Right(await _groupList());
    } on ServerException catch(error){
      return Left(ServerFailure(error.message));
    } on Exception catch(error){
        return Left(ServerFailure(error.toString()));
    }
  }   
  Future<List<Group>> _groupList() async {
    final dataList = await dataSource.getData(GroupNames.tableName);
    return _dbGroupToList(dataList);
  }   
  List<Group> _dbGroupToList(List<Map<String, dynamic>> data){
    final List<Group> items = data.map(
      (item) => Group(
        id: item[GroupNames.id],
        name: item[GroupNames.name],        
      ),
    ).toList(); 
    return items;    
  }   
  Future<Either<Failure, List<Group>>> _getGroupResults(_GroupOrFailure groupOrFailure) async {
    try{
      final groupList = await groupOrFailure();
      return Right(groupList);
    } on ServerException catch(error){
      return Left(ServerFailure(error.message));
    } on Exception catch(error){
      return Left(ServerFailure(error.toString()));
    }
  }  
  Map<String, Object> _toGroup(Group group){
    return {
      GroupNames.name: group.name,
    };
  }    
}