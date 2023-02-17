import 'package:meta/meta.dart';
import '../../../domain/entities/category.dart';

@immutable
abstract class CategoriesBlocState{}

class CategoriesInitialState extends CategoriesBlocState{}

class Empty extends CategoriesBlocState{}
class Loading extends CategoriesBlocState{}
class Error extends CategoriesBlocState{
  final String message;
  Error({required this.message});
}
class CategoryState extends CategoriesBlocState{
  final Category category;
  CategoryState({required this.category});
}
class CategoriesState extends CategoriesBlocState{
  final List<Category> categories;
  CategoriesState({required this.categories});
}
class CategoryDeleteState extends CategoriesBlocState{
  final List<String> transactions;
  final List<String> transfers;
  CategoryDeleteState({required this.transactions, required this.transfers});
}