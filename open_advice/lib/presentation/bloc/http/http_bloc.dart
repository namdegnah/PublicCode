import 'package:bloc/bloc.dart';
import '../../../domain/usecases/best_team_user.dart';
import 'package:meta/meta.dart';
import '../../../domain/entities/best_team.dart';
import '../../../presentation/config/injection_container.dart';
import '../../../domain/usecases/matches_user.dart';
import '../../../data/models/params.dart';

part 'http_bloc_event.dart';
part 'http_bloc_state.dart';


class HttpBloc extends Bloc<HttpEvent, HttpState> {
  MatchesUser matchesUser = sl<MatchesUser>();
  BestTeamUser bestTeamUser = sl<BestTeamUser>();
  
  HttpBloc() : super(HttpInitialState()) {  
    on<MatchesRequestData>((event, emit) => _getMatches(event, emit)); 
  }
  
  void _getMatches(MatchesRequestData event, Emitter<HttpState> emit) async {
    emit(HttpLoadingState());
    final either = await matchesUser(Params());
    either.fold(
      (failure) => HttpErrorState(message: failure.message),
      (bestTeam) => emit(HttpMatchListState(bestTeam: bestTeam)),
    );
  }     
}
