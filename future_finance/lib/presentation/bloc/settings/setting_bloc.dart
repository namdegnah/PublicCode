import 'package:flutter_bloc/flutter_bloc.dart';
import 'setting_bloc_exports.dart';
import '../../../domain/usecases/setting_usecase.dart';
import '../../../data/models/params.dart';
import '../../config/injection_container.dart';

class SettingBloc extends Bloc<SettingBlocEvent, SettingBlocState>{
  final SettingUser settingUser = sl<SettingUser>();
  SettingBloc() : super(SettingInitialState()){
    on<InsertUserSettings>((event, emit) => _insertUserSetting(event, emit));
    on<DeleteUserSettings>((event, emit) => _deleteUserSetting(event, emit));
    on<UpdateUserSetting>((event, emit) => _updateUserSetting(event, emit));
    on<GetUserSettings>((event, emit) => _getUserSetting(event, emit));
    on<BarChartEvent>((event, emit) => _barChartSetting(event, emit));
    on<UpdateEndDateSetting>((event, emit) => _updateEndDateSetting(event, emit));
  }
  void _insertUserSetting(InsertUserSettings event, Emitter<SettingBlocState> emit) async {
    emit(Loading());
    final failureOrSetting = await settingUser(Params.id(id: event.id));
    failureOrSetting.fold(
      (failure) => emit(Error(message: failure.message)),
      (setting) => emit(ReturnSetting(setting: setting)),      
    );
  }
  void _deleteUserSetting(DeleteUserSettings event, Emitter<SettingBlocState> emit) async {
    emit(Loading());
    final failureOrVoid = await settingUser.deleteUserSettings(Params.id(id: event.id));
    failureOrVoid.fold(
      (failure) => emit(Error(message: failure.message)),
      (setting) => null,      
    );
  }
  void _updateUserSetting(UpdateUserSetting event, Emitter<SettingBlocState> emit) async {
    emit(Loading());
    final failureOrSetting = await settingUser.updateUserSetting(Params.id3(id: event.user_id, id2: event.setting_id, id3: event.value));
    failureOrSetting.fold(
      (failure) => emit(Error(message: failure.message)),
      (setting) => emit(ReturnSetting(setting: setting)),      
    );
  }
  void _getUserSetting(GetUserSettings event, Emitter<SettingBlocState> emit) async {
    emit(Loading());
    final failureOrSetting = await settingUser.getUserSettings(Params.id(id: event.id));
    failureOrSetting.fold(
      (failure) => emit(Error(message: failure.message)),
      (setting) => emit(ReturnSetting(setting: setting)),      
    );    
  }
  void _barChartSetting(BarChartEvent event, Emitter<SettingBlocState> emit) async {
    emit(Loading());
    final failureOrDialogBase = await settingUser.barChartSettings(Params.id2(id: event.user_id, id2: event.account_id));
    failureOrDialogBase.fold(
      (failure) => emit(Error(message: failure.message)),
      (dialogBase) => emit(BarChartState(dialogBase: dialogBase)),      
    );
  }
  void _updateEndDateSetting(UpdateEndDateSetting event, Emitter<SettingBlocState> emit) async {
    emit(Loading());
    final failureOrSetting = await settingUser.updateEndDateSettings(Params.endDate(id: event.user_id, id2: event.setting_id, future: event.time));
    failureOrSetting.fold(
      (failure) => emit(Error(message: failure.message)),
      (setting) => emit(ReturnSetting(setting: setting)),      
    );
  }
}