import '../../core/usecases/usecase.dart';
import '../../data/models/params.dart';
import '../entities/category.dart';
import 'package:dartz/dartz.dart';
import '../repositories/repositories_all.dart';
import '../../core/errors/failures.dart';

class CategoryUser extends UseCase<List<Category>, Params>{
  final CategoryRepository repository;
  CategoryUser({required this.repository});  

  @override
  Future<Either<Failure, List<Category>>> call(Params params) async {
    return await repository.categoryList();
  }
  Future<Either<Failure, List<Category>>> insertCategory(Params params) async {
    Category category = params.category!;
    return await repository.insertCategory(category);
  }
  Future<Either<Failure, List<Category>>> deleteCategory(Params params) async {
    int id = params.id!;
    return await repository.deleteCategory(id);
  }
  Future<Either<Failure, List<Category>>> updateCategory(Params params) async {
    Category category = params.category!;
    return await repository.updateCategory(category);
  }
  Future<Either<Failure, Category>> category(Params params) async {
    int id = params.id!;
    return await repository.category(id);
  }  
}