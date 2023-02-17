import 'package:dartz/dartz.dart';
import 'package:passwords/domain/entities/password_filter.dart';
import '../datasources/data_sources.dart';
import '../../core/errors/exceptions.dart';
import '../../core/errors/failures.dart';
import '../../domain/entities/password.dart';
import '../../domain/entities/password_filter.dart';
import '../../domain/entities/type.dart';
import '../../domain/entities/group.dart';
import '../../domain/repositories/repositories_all.dart';
import '../../presentation/config/constants.dart';
import '../../presentation/config/injection_container.dart';

typedef _PasswordOrFailure = Future<List<Password>> Function();

class PasswordRepositoryImp extends PasswordRepository {
  final AppDataSource dataSource;
  PasswordRepositoryImp({required this.dataSource});

  @override
  Future<Either<Failure, List<Password>>> passwordList({required int groupId, required int typeId}) async {
    return await _getGroupResults(() async {
      return await _passwordList();
    });
  } 
  @override
  Future<Either<Failure, List<Password>>> passwordAllList() async {
    return await _getGroupResults(() async {
      return await _passwordAllList();
    });
  }  
  @override
  Future<Either<Failure, List<Password>>> updatePassword(Password password) async {
    try{
      await dataSource.update(PasswordNames.tableName, password.id, _toPassword(password));
      return Right(await _passwordList());
    } on ServerException catch(error){
      return Left(ServerFailure(error.message));
    } on Exception catch(error){
        return Left(ServerFailure(error.toString()));
    }
  }
  @override
  Future<Either<Failure, List<Password>>> insertPassword(Password password) async {
    return await _getGroupResults(() async{
      await dataSource.insert(PasswordNames.tableName, _toPassword(password));
      return await _passwordList();
    }); 
  }  
  @override
  Future<Either<Failure, List<Password>>> deletePassword(int id) async {
    try{
      await dataSource.delete(PasswordNames.tableName, id);
      return Right(await _passwordList());         
    } on ServerException catch(error){
      return Left(ServerFailure(error.message));
    } on Exception catch(error){
      return Left(ServerFailure(error.toString()));
    }
  }  
  Future<List<Password>> _passwordList() async {
    int? groupId = sl<PasswordFilter>().groupId;
    int? typeId = sl<PasswordFilter>().typeId;
    List<String> columns = [];
    List<int> args = [];
    var dataList;
    if((groupId == null || groupId == AppConstants.noFilterChosen) && (typeId == null || typeId == AppConstants.noFilterChosen)){
      dataList = await dataSource.getData(PasswordNames.tableName);
    } else {
      if(groupId != null && groupId != AppConstants.noFilterChosen){
        columns.add(PasswordNames.groupId);
        args.add(groupId);
      } 
      if(typeId != null && typeId != AppConstants.noFilterChosen){
        columns.add(PasswordNames.typeId);
        args.add(typeId);
      }
      dataList = await dataSource.getAllDataFullIntQuery(PasswordNames.tableName, columns, args);
    }
    return await _dbPasswordToList(dataList);
  } 
  Future<List<Password>> _passwordAllList() async {
    var dataList = await dataSource.getData(PasswordNames.tableName);
    return await _dbPasswordToList(dataList);
  }    
  Future<List<Password>> _dbPasswordToList(List<Map<String, dynamic>> data) async {
    // can we attach a list of groups and types to each password here?
    List<Type> types = [];
    List<Group> groups = [];
    final typesEither = await sl<TypeRepository>().typeList();
    typesEither.fold(
      (failure) => throw failure,
      (list) => types = list,
    );    
    final groupsEither = await sl<GroupRepository>().groupList();
      groupsEither.fold(
      (failure) => throw failure,
      (list) => groups = list,
    );  
    final List<Password> items = data.map(
      (item) => Password(
        id: item[PasswordNames.id],
        groupId: item[PasswordNames.groupId], 
        typeId: item[PasswordNames.typeId],
        password: item[PasswordNames.password], 
        notes: item[PasswordNames.notes],
        description: item[PasswordNames.description],
        url: item[PasswordNames.url],
        username: item[PasswordNames.username],
        email: item[PasswordNames.email],
        accountNumber: item[PasswordNames.accountNumber],
        pin: item[PasswordNames.pin],
        sortCode: item[PasswordNames.sortCode],
        digit3SecurityCode: item[PasswordNames.digit3SecurityCode],
        digit4SecurityCode: item[PasswordNames.digit4SecurityCode],
        phoneNumber: item[PasswordNames.phoneNumber],
        name: item[PasswordNames.name],
        cardNumber: item[PasswordNames.cardNumber],
        amexCardNumber: item[PasswordNames.amexCardNumber],
        expiryDate: item[PasswordNames.expiryDate],
        passcode: item[PasswordNames.passcode],
        passwordValidationId: item[PasswordNames.passwordValidationId],
        types: types,  
        groups: groups,  
      ),
    ).toList(); 
    return items;    
  } 
  Future<Either<Failure, List<Password>>> _getGroupResults(_PasswordOrFailure passwordOrFailure) async {
    try{
      final passwordList = await passwordOrFailure();
      return Right(passwordList);
    } on ServerException catch(error){
      return Left(ServerFailure(error.message));
    } on Exception catch(error){
      return Left(ServerFailure(error.toString()));
    }
  } 
  Map<String, Object> _toPassword(Password password){
    return {
      PasswordNames.groupId: password.groupId,
      PasswordNames.typeId: password.typeId,
      PasswordNames.password: password.password ?? '',
      PasswordNames.notes: password.notes,
      PasswordNames.description: password.description,
      PasswordNames.url: password.url ?? '',
      PasswordNames.username: password.username ?? '',
      PasswordNames.email: password.email ?? '',
      PasswordNames.accountNumber: password.accountNumber ?? '',      
      PasswordNames.pin: password.pin ?? '',
      PasswordNames.sortCode: password.sortCode ?? '',
      PasswordNames.digit3SecurityCode: password.digit3SecurityCode ?? '',
      PasswordNames.digit4SecurityCode: password.digit4SecurityCode ?? '',
      PasswordNames.phoneNumber: password.phoneNumber ?? '',
      PasswordNames.name: password.name ?? '',
      PasswordNames.cardNumber: password.cardNumber ?? '',
      PasswordNames.amexCardNumber: password.amexCardNumber ?? '',
      PasswordNames.expiryDate: password.expiryDate ?? '',
      PasswordNames.passcode: password.passcode ?? '',
      PasswordNames.passwordValidationId: password.passwordValidationId ?? 0,
    };
  }   
}