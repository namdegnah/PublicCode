import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:open_advice/data/datasources/data_sources.dart';
import 'package:open_advice/domain/entities/best_team.dart';
import 'package:open_advice/domain/repositories/repositories_all.dart';
import 'package:open_advice/domain/usecases/matches_user.dart';
import 'package:open_advice/data/repositories/http_repository_imp.dart';
import 'package:open_advice/domain/usecases/function_calls.dart' as calls;
import 'package:open_advice/data/models/params.dart';

class MockAppDataSource extends Mock implements AppDataSource{}

void main(){
  WidgetsFlutterBinding.ensureInitialized(); 
  late MatchesUser sut;
  late MockAppDataSource mockAppDataSource;
  late HttpRepository httpRepository;
  setUp(() {
    mockAppDataSource = MockAppDataSource();
    httpRepository = HttpRepositoryImp(dataSource: mockAppDataSource);
    sut = MatchesUser(repository: httpRepository);
  });

  group('Best team test', () {
    late BestTeam bestTeam;
    void arrangeDataSourceFootball(){
      when(() => mockAppDataSource.getFootballJson(any(), any())).thenAnswer((_) async => calls.getMatchList());
      when(() => mockAppDataSource.getCurrentSeason()).thenAnswer((_) => calls.getCurrentSeason());
      when(() => mockAppDataSource.getBestTeam(any())).thenAnswer((_) => calls.getBestTeam());
    }
    test(
      'See if the Match User selects the best team', 
      () async {
        arrangeDataSourceFootball();
        final eitherFuture = await sut(Params.id(id: 1));
        eitherFuture.fold(
          (failure) => throw failure,
          (team) => bestTeam = team,
        );
        expect(bestTeam.id, bestTeam.originalId!);
    });
  });
}