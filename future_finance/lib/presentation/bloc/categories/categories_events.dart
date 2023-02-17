import 'package:meta/meta.dart';
import '../../../domain/entities/category.dart';

@immutable
abstract class CategoriesBlocEvent{}

class GetCategoriesEvent extends CategoriesBlocEvent{}
class GetCategoryEvent extends CategoriesBlocEvent{
  final int id;
  GetCategoryEvent({required this.id});
}
class DeleteCategoryEvent extends CategoriesBlocEvent{
  final int id;
  DeleteCategoryEvent({required this.id});
}
class UpdateCategoryEvent extends CategoriesBlocEvent{
  final Category category;
  UpdateCategoryEvent({required this.category});
}
class InsertCategoryEvent extends CategoriesBlocEvent{
  final Category category;
  InsertCategoryEvent({required this.category});
}