import 'package:bloc/bloc.dart';
import 'setup_bloc_events.dart';
import 'setup_bloc_states.dart';
import '../../config/injection_container.dart';
import '../../../domain/usecases/setup_usecase.dart';

class SetupBloc extends Bloc<SetupEvent, SetupState> {

  SetupUser setupUser = sl<SetupUser>();

  SetupBloc() : super(SetupInitialState()) {
    on<SetupRequestData>((event, emit) => _getGroupsFromDB(event, emit));   
  }
  void _getGroupsFromDB(SetupRequestData event, Emitter<SetupState> emit) async {
    emit(SetupLoadingState());
    final either = await setupUser.setUpDataSet();
    either.fold(
      (failure) => SetupErrorState(message: failure.message),
      (dataSet) => emit(SetupDataState(dataSet: dataSet)),
    );
  }       
}
