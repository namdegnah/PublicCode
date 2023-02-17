import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:future_finance/data/datasources/data_sources.dart';
import 'package:future_finance/data/repositories/category_repository_imp.dart';
import 'package:future_finance/domain/entities/category.dart';


class MockAppDataSource extends Mock implements AppDataSource{}

void main(){

  late CategoryRepositoryImp sut;
  late MockAppDataSource mockAppDataSource;

  setUp((() async {
 
    mockAppDataSource = MockAppDataSource();
    sut = CategoryRepositoryImp(dataSource: mockAppDataSource);
  }));

  group('CategoryRepositoryImp all functions, should return a list of todos', (){
    
    late List<Category> categoryList;
    late Category categoryItem;

    // Data for 3 category items
    final categoryFromDatabase =[
      Category(id: 1, categoryName: 'Category 1', description: 'a', iconPath: 'a'),
      Category(id: 2, categoryName: 'Category 2', description: 'b', iconPath: 'a'),
      Category(id: 3, categoryName: 'Category 3', description: 'c', iconPath: 'a'),
    ];
    final List<Map<String, dynamic>> categoryListMapFromDatabase = [
      {"id": 1, "categoryName": "Category 1", "description": "a", "iconPath": 'a'}, 
      {"id": 2, "categoryName": "Category 2", "description": "b", "iconPath": 'a'},  
      {"id": 3, "categoryName": "Category 3", "description": "c", "iconPath": 'a'}
    ];
    Future<List<Map<String, dynamic>>> mockedDataSourceReturnListMap() async {
      return categoryListMapFromDatabase;
    }
    void arrangeDataSourceReturns3CategoriesListMap(){
      when(() => mockAppDataSource.getData(any())).thenAnswer((_) async => mockedDataSourceReturnListMap());
    }

    // Data for one category item
    final oneCategoryFromDatabase =  Category(id: 1, categoryName: 'Category 1', description: 'a', iconPath: 'a'); 
    final List<Map<String, dynamic>> singleCategoryListMapFromDatabase = [
      {"id": 1, "categoryName": "Category 1", "description": "a", "iconPath": 'a'}
    ]; 
    Future<List<Map<String, dynamic>>> mockedSingleDataSourceReturnListMap() async {
      return singleCategoryListMapFromDatabase;
    }    
    void arrangeDataSourceReturns1CategoryListMap(){
      when(() => mockAppDataSource.getAllDataWhere(any(), any())).thenAnswer((_) async => mockedSingleDataSourceReturnListMap());
    }          
    test(
      "CategoryRepositoryImp.todoList() and ensure it is called",
      () async {
        arrangeDataSourceReturns3CategoriesListMap();
        await sut.categoryList();
        verify(() => mockAppDataSource.getData(any())).called(1);
      },
    ); 
    test(
      "CategoryRepositoryImp.todoList(), returns a List<Todo>,",
      () async {
        arrangeDataSourceReturns3CategoriesListMap();
        final theFuture = await sut.categoryList();
        theFuture.fold(
          (failure) {
            return Left(failure);
          },
          (list) => categoryList = list,      
        );         
        expect(categoryList, categoryFromDatabase);
      },
    );
    test(
      "CategoryRepositoryImp.category() and ensure it is called",
      () async {
        arrangeDataSourceReturns1CategoryListMap();
        await sut.category(1);
        verify(() => mockAppDataSource.getAllDataWhere(any(), any())).called(1);
      },
    ); 
    test(
      "CategoryRepositoryImp.category(), returns a Todo,",
      () async {
        arrangeDataSourceReturns1CategoryListMap();
        final theFuture = await sut.category(1);
        theFuture.fold(
          (failure) {
            return Left(failure);
          },
          (todo) => categoryItem = todo,      
        );         
        expect(categoryItem, oneCategoryFromDatabase);
      },
    );
  });
}