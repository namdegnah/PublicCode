import 'package:dartz/dartz.dart';
import '../../core/errors/exceptions.dart';
import '../../core/errors/failures.dart';
import '../../domain/entities/category.dart';
import '../../domain/repositories/repositories_all.dart';
import '../datasources/data_sources.dart';
import '../../presentation/config/constants.dart';

typedef Future<List<Category>> _CategoryOrFailure();

class CategoryRepositoryImp extends CategoryRepository {
  final AppDataSource dataSource;
  CategoryRepositoryImp({required this.dataSource});  

  Future<Either<Failure, List<Category>>> insertCategory(Category category) async {
    return await _getResults(() async{
      await dataSource.insert(CategoryNames.tableName, _toCategory(category));    
      return await _categoryList();
    });
  }
  Future<Either<Failure, List<Category>>> categoryList() async {
    return await _getResults(() async {
      return await _categoryList();
    });
  }
  Future<Either<Failure, Category>> category(int id) async {
    try{
      final _dataList = await dataSource.getAllDataWhere(CategoryNames.tableName, id);
      final List<Category> _items = _dbToList(_dataList);
      return Right(_items[0]);              
    } on ServerException catch(error){
      return Left(ServerFailure(error.message));
    } on Exception catch(error){
      return Left(ServerFailure(error.toString()));
    }
  }  
  Future<Either<Failure, List<Category>>> deleteCategory(int id) async {
    try{
      // check what is returned from select title from transactions where categoryId = 3
      List<Map<String, dynamic>> chTrx = await dataSource.getDataWhere(        
        table: TransactionNames.tableName,
        columns: TransactionNames.title,
        where: TransactionNames.categoryId,
        args: id,
      );
      // check what is returned from select title from transfers where categoryId = 3
      List<Map<String, dynamic>> toTrf = await dataSource.getDataWhere(        
        table: TransfersNames.tableName,
        columns: TransfersNames.title,
        where: TransfersNames.categoryId,
        args: id,
      );
      // if all 3 are null then OK to delete and return Right(List of accounts)
      if(chTrx.isEmpty && toTrf.isEmpty){
        await dataSource.delete(CategoryNames.tableName, id);
        return Right(await _categoryList());
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
        // as not able to delete as not 3 nulls then add the string to a Failure which is collected in the CategoriesScreen       
        return Left(DeleteFailure(transactions: trans, transfers: tranf));
      }                        
    } on ServerException catch(error){
      return Left(ServerFailure(error.message));
    } on Exception catch(error){
      return Left(ServerFailure(error.toString()));
    }
  }
  Future<Either<Failure, List<Category>>> updateCategory(Category category) async {
    try{
      await dataSource.update(CategoryNames.tableName, category.id, _toCategory(category));
      return Right(await _categoryList());
    } on ServerException catch(error){
      return Left(ServerFailure(error.message));
    } on Exception catch(error){
      return Left(ServerFailure(error.toString()));
    }
  }
  Future<List<Category>> _categoryList() async {
    final _dataList = await dataSource.getData(CategoryNames.tableName);
    return _dbToList(_dataList);
  }
  List<Category> toCategories(List<Map<String, dynamic>> data){
    return _dbToList(data);
  }
  List<Category> _dbToList(List<Map<String, dynamic>> data){
    final List<Category> _items = data.map(
      (item) => Category(
        id: item[CategoryNames.id],
        categoryName: item[CategoryNames.categoryName],
        description: item[CategoryNames.description],
        iconPath: item[CategoryNames.iconPath],
        usedForCashFlow: item[CategoryNames.usedForCashFlow] == 1 ? true : false,        
      ),
    ).toList(); 
    return _items;    
  }
  Future<Either<Failure, List<Category>>> _getResults(_CategoryOrFailure categoryOrFailure) async {
    try{
      final categoryList = await categoryOrFailure();
      return Right(categoryList);
    } on ServerException catch(error){
      return Left(ServerFailure(error.message));
    } on Exception catch(error){
      return Left(ServerFailure(error.toString()));
    }
  }  
  Map<String, Object> _toCategory(Category category){
    return {
      CategoryNames.categoryName: category.categoryName,
      CategoryNames.description: category.description,
      CategoryNames.iconPath: category.iconPath,
      CategoryNames.usedForCashFlow: category.usedForCashFlow == true ? 1 : 0,
    };
  }
}