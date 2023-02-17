import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:future_finance/core/errors/failures.dart';
import 'package:future_finance/data/models/params.dart';
import 'package:future_finance/domain/entities/category.dart';
import 'package:future_finance/domain/repositories/repositories_all.dart';
import 'package:future_finance/domain/usecases/category_usecase.dart';

class MockCategoryRepository extends Mock implements CategoryRepository{}

void main(){

  late CategoryUser sut;
  late MockCategoryRepository mockCategoryRepository;

  setUp((() {
    mockCategoryRepository = MockCategoryRepository();
    sut = CategoryUser(repository: mockCategoryRepository);
  }));

  group('CategoryUser call function, should return a list of Category', (){

    late List<Category> categoryList;

    final categoryFromDatabase =[
      Category(id: 1, categoryName: 'Category 1', description: 'a', iconPath: 'a'),
      Category(id: 2, categoryName: 'Category 2', description: 'a', iconPath: 'a'),
      Category(id: 3, categoryName: 'Category 3', description: 'a', iconPath: 'a'),
    ];
    Future<Either<Failure, List<Category>>> mockedCategoryList() async {
      return Right(categoryFromDatabase);
    }

    void arrangeRepositoryReturns3Categories(){
      when(() => mockCategoryRepository.categoryList()).thenAnswer((_) async => mockedCategoryList());
    }    
    test(
      "CategoryUser.call() and ensure it is called",
      () async {
        arrangeRepositoryReturns3Categories();
        await sut.call(Params.id(id: 1));
        verify(() => mockCategoryRepository.categoryList()).called(1);
      },
    );
    test(
      "CategoryUser.call(), returns a List<Todo>,",
      () async {
        arrangeRepositoryReturns3Categories();
        final theFuture = await sut.call(Params.id(id: 1));
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
      "CategoryUser.call(Params params) and ensure it is called",
      () async {
        arrangeRepositoryReturns3Categories();
        final params = Params();
        await sut.call(params);
        verify(() => mockCategoryRepository.categoryList()).called(1);
      },
    );
    test(
      "call CategoryUser.call(), returns a List<Category>,",
      () async {
        arrangeRepositoryReturns3Categories();
        final params = Params();
        final theFuture = await sut.call(params);
        theFuture.fold(
          (failure) {
            return Left(failure);
          },
          (list) => categoryList = list,      
        );         
        expect(categoryList, categoryFromDatabase);
      },
    );        
  });
}
