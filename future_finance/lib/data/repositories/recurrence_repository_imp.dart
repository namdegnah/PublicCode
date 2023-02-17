import 'package:dartz/dartz.dart';

import '../../core/errors/exceptions.dart';
import '../../core/errors/failures.dart';
import '../../domain/entities/recurrence.dart';
import '../../domain/repositories/repositories_all.dart';
import '../datasources/data_sources.dart';
import '../../presentation/config/constants.dart';

typedef Future<List<Recurrence>> _RecurrenceOrFailure();

class RecurrenceRepositoryImp extends RecurrenceRepository {
  final AppDataSource dataSource;
  RecurrenceRepositoryImp({required this.dataSource});  

  Future<Either<Failure, List<Recurrence>>> insertRecurrence(Recurrence recurrence) async {
    return await _getResults(() async{
      await dataSource.insert(RecurrenceNames.tableName, _toRecurrence(recurrence));    
      return await _recurrenceList();
    });
  }
  Future<Either<Failure, List<Recurrence>>> recurrenceList() async {
    return await _getResults(() async {
      return await _recurrenceList();
    });
  }
  
  Future<Either<Failure, Recurrence>> recurrence(int id) async {
    try{
      final _dataList = await dataSource.getAllDataWhere(RecurrenceNames.tableName, id);
      final List<Recurrence> _items = _dbToList(_dataList);
      return Right(_items[0]);              
    } on ServerException catch(error){
      return Left(ServerFailure(error.message));
    } on Exception catch(error){
      return Left(ServerFailure(error.toString()));
    }
  }
  Future<Either<Failure, List<Recurrence>>> deleteRecurrence(int id) async {
    try{
      // check what is returned from select title from transactions where recurrenceId = 3
      List<Map<String, dynamic>> chTrx = await dataSource.getDataWhere(        
        table: TransactionNames.tableName,
        columns: TransactionNames.title,
        where: TransactionNames.recurrenceId,
        args: id,
      );
      // check what is returned from select title from transfers where recurrenceId = 3
      List<Map<String, dynamic>> toTrf = await dataSource.getDataWhere(        
        table: TransfersNames.tableName,
        columns: TransfersNames.title,
        where: TransfersNames.recurrenceId,
        args: id,
      );
      // if all 3 are null then OK to delete and return Right(List of accounts)
      if(chTrx.isEmpty && toTrf.isEmpty){
        await dataSource.delete(RecurrenceNames.tableName, id);
        return Right(await _recurrenceList());
      } else {
        List<String> trans = [];
        List<String> tranf = [];
        // create a list of strings with the transaction title
        if(chTrx.isNotEmpty){          
          for(Map map in chTrx) trans.add(map[TransactionNames.title]);          
        }
        // create a list of strings with the transfer title
        if(toTrf.isNotEmpty){
          for(Map map in toTrf) tranf.add(map[TransfersNames.title]);
        } 
        // as not able to delete as not 2 nulls then add the string to a Failure which is collected in the RecurrencesScreen       
        return Left(DeleteFailure(transactions: trans, transfers: tranf));
      }      
      
      
    } on ServerException catch(error){
      return Left(ServerFailure(error.message));
    } on Exception catch(error){
      return Left(ServerFailure(error.toString()));
    }
  }
  Future<Either<Failure, List<Recurrence>>> updateRecurrence(Recurrence recurrence) async {
    try{
      await dataSource.update(RecurrenceNames.tableName, recurrence.id, _toRecurrence(recurrence));
      return Right(await _recurrenceList());
    } on ServerException catch(error){
      return Left(ServerFailure(error.message));
    } on Exception catch(error){
      return Left(ServerFailure(error.toString()));
    }
  }
  Future<List<Recurrence>> _recurrenceList() async {
    final _dataList = await dataSource.getData(RecurrenceNames.tableName);
    return _dbToList(_dataList);
  }
  List<Recurrence> toRecurrence(List<Map<String, dynamic>> data){
    return _dbToList(data);
  }
  List<Recurrence> _dbToList(List<Map<String, dynamic>> data){
    final List<Recurrence> _items = data.map(
      (item) => Recurrence(
        id: item[RecurrenceNames.id],
        title: item[RecurrenceNames.title],
        description: item[RecurrenceNames.description],
        iconPath: item[RecurrenceNames.iconPath],
        type: item[RecurrenceNames.type],
        noOccurences: item[RecurrenceNames.noOccurences],
        endDate: item[RecurrenceNames.endDate] == null ? null : DateTime.parse(item[RecurrenceNames.endDate]),       
      ),
    ).toList(); 
    return _items;    
  }  
  Future<Either<Failure, List<Recurrence>>> _getResults(_RecurrenceOrFailure recurrenceOrFailure) async {
    try{
      final recurrenceList = await recurrenceOrFailure();
      return Right(recurrenceList);
    } on ServerException catch(error){
      return Left(ServerFailure(error.message));
    } on Exception catch(error){
      return Left(ServerFailure(error.toString()));
    }
  }  
  Map<String, dynamic> _toRecurrence(Recurrence recurrence){
    return {
      RecurrenceNames.title: recurrence.title,
      RecurrenceNames.description: recurrence.description,
      RecurrenceNames.iconPath: recurrence.iconPath,
      RecurrenceNames.type: recurrence.type,
      RecurrenceNames.noOccurences: (recurrence.noOccurences == null || recurrence.noOccurences! == 0) ? null : recurrence.noOccurences!,
      RecurrenceNames.endDate: recurrence.endDate == null ? null : recurrence.endDate!.toIso8601String(),
    };
  }
}