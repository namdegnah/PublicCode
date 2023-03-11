import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:open_advice/data/repositories/http_repository_imp.dart';
import 'package:open_advice/data/datasources/data_sources.dart';
import 'package:mocktail/mocktail.dart';
import 'package:open_advice/presentation/bloc/http/http_bloc.dart';
import 'package:open_advice/domain/usecases/function_calls.dart' as calls;
import 'package:open_advice/presentation/config/injection_container.dart' as di;

class MockAppDataSource extends Mock implements AppDataSource{}

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
  await di.init();
  late MockAppDataSource mockAppDataSource;
  late HttpRepositoryImp httpRepositoryImp;
  late HttpBloc httpBloc;
  const loading = TypeMatcher<HttpLoadingState>();
  const initial = TypeMatcher<HttpInitialState>();
  const error = TypeMatcher<HttpErrorState>();
  const list = TypeMatcher<HttpMatchListState>();  
  setUp(() {

    mockAppDataSource = MockAppDataSource();
    httpRepositoryImp = HttpRepositoryImp(dataSource: mockAppDataSource);
    httpBloc = HttpBloc();
  });


  blocTest(
    'test description',
    build: (){
      when(() => mockAppDataSource.getFootballJson(any(), any())).thenAnswer((_) async => calls.getMatchList());
      when(() => mockAppDataSource.getCurrentSeason()).thenAnswer((_) async => calls.getCurrentSeason());
      when(() => mockAppDataSource.getBestTeam(any())).thenAnswer((_) async => calls.getBestTeam());
      return httpBloc;    
    },
    act: (bloc) => bloc.add(MatchesRequestData()),
    wait: const Duration(seconds: 1),
    expect: () => [loading],
  ); 

}
