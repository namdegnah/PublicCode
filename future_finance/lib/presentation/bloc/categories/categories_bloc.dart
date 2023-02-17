import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/errors/failures.dart';
import '../../../domain/usecases/category_usecase.dart';
import '../../../data/models/params.dart';
import 'categories_bloc_exports.dart';
import '../../config/injection_container.dart';

class CategoriesBloc extends Bloc<CategoriesBlocEvent, CategoriesBlocState> {
  final CategoryUser categoryUser = sl<CategoryUser>();
  CategoriesBloc() : super(CategoriesInitialState()){
    on<GetCategoriesEvent>((event, emit) => _getCategories(event, emit));
    on<GetCategoryEvent>((event, emit) => _getCategory(event, emit));
    on<InsertCategoryEvent>((event, emit) => _insertCategory(event, emit));
    on<DeleteCategoryEvent>((event, emit) => _deleteCategory(event, emit));
    on<UpdateCategoryEvent>((event, emit) => _updateCategory(event, emit));
  }
  void _getCategories(GetCategoriesEvent event, Emitter<CategoriesBlocState> emit) async {
    emit(Loading());
    final failureOrCategoiresList = await categoryUser.call(Params());
    failureOrCategoiresList.fold(
      (failure) => emit(Error(message: failure.message)),
      (categories) => emit(CategoriesState(categories: categories)),
    );
  }
  void _getCategory(GetCategoryEvent event, Emitter<CategoriesBlocState> emit) async {
    emit(Loading());
    final failureOrCategory = await categoryUser.category(Params.id(id: event.id));
    failureOrCategory.fold(
      (failure) => emit(Error(message: failure.message)),
      (category) => emit(CategoryState(category: category)),
    );
  }
  void _insertCategory(InsertCategoryEvent event, Emitter<CategoriesBlocState> emit) async {
    emit(Loading());
    final failureOrCategories = await categoryUser.insertCategory(Params.category(category: event.category));
    failureOrCategories.fold(
      (failure) => emit(Error(message: failure.message)),
      (categories) => emit(CategoriesState(categories: categories)),
    );    
  }
  void _deleteCategory(DeleteCategoryEvent event, Emitter<CategoriesBlocState> emit) async {
    emit(Loading());
    final failureOrCategoiresList = await categoryUser.deleteCategory(Params.id(id: event.id));
    failureOrCategoiresList.fold(
      (failure) {
        if(failure is DeleteFailure){
          emit(CategoryDeleteState(transactions: failure.transactions, transfers: failure.transfers));
        } else {
          emit(Error(message: failure.message));
        } 
      }, 
      (categories) => emit(CategoriesState(categories: categories)),
    );    
  }
  void _updateCategory(UpdateCategoryEvent event, Emitter<CategoriesBlocState> emit) async {
    emit(Loading());
    final failureOrCategoiresList = await categoryUser.updateCategory(Params.category(category: event.category));
    failureOrCategoiresList.fold(
      (failure) => emit(Error(message: failure.message)),
      (categories) => emit(CategoriesState(categories: categories)),
    );    
  }
}