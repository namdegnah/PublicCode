import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/facts_usecase.dart';
import '../../../data/models/params.dart';
import 'facts_bloc_exports.dart';
import '../../config/injection_container.dart';

class FactsBloc extends Bloc<FactsBlocEvent, FactsBlocState> {
  final FactsUser factsUser = sl<FactsUser>();
  FactsBloc() : super(FactsBlocInitialState()){
    on<GetFactsEvent>((event, emit) => _getFacts(event, emit));
    on<RunPauseEvent>((event, emit) => _getRunPause(event, emit));
  }
  
  void _getFacts(GetFactsEvent event, Emitter<FactsBlocState> emit) async {
    emit(Loading());
    final failureOrFactsBase = await factsUser.call(Params());
    failureOrFactsBase.fold(
      (failure) => emit(Error(message: failure.message)),
      (factsbase) => emit(FactsState(factsBase: factsbase)),
    );
  }
  void _getRunPause(RunPauseEvent event, Emitter<FactsBlocState> emit) async {
    emit(Loading());
    final failureOrFactsBase = await factsUser.RunPause(Params());
    failureOrFactsBase.fold(
      (failure) => emit(Error(message: failure.message)),
      (factsbase) => emit(RunPauseState(factsBase: factsbase)),
    );    
  }
}