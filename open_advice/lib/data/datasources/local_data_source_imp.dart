import 'http_helper.dart' as httphelp;
import './data_sources.dart';

import '../../core/errors/exceptions.dart';
import '../../domain/entities/match.dart';
import '../../domain/entities/best_team.dart';
import '../../domain/entities/current_season.dart';

class LocalDataSource extends AppDataSource {

  @override

  @override
  Future<List<Match>> getFootballJson(String dateFrom, String dateTo) async {
    try{
      return await httphelp.getFootballJson(dateFrom: dateFrom, dateTo: dateTo);
    } catch (error){
      throw ServerException(error.toString());
    }
  } 
  @override
  Future<BestTeam> getBestTeam(int id) async {
    try{
      return await httphelp.getBestTeam(id);
    } catch (error){
      throw ServerException(error.toString());
    }
  }   
  @override
  Future<CurrentSeason> getCurrentSeason() async {
    try{
      return await httphelp.getCurrentSeason();
    } catch (error){
      throw ServerException(error.toString());
    }
  }  
}
