import '../../core/util/general_util.dart';
import '../models/dialog_base.dart';
import '../../presentation/config/injection_container.dart';
import '../../domain/repositories/repositories_all.dart';
import 'package:dartz/dartz.dart';
import '../../core/errors/exceptions.dart';
import '../../core/errors/failures.dart';
import '../../domain/entities/setting.dart';
import '../datasources/data_sources.dart';
import '../../presentation/config/constants.dart';

typedef Future<Setting> _SettingOrFailure();
typedef Future<void> _NullOrFailure();
typedef Future<DialogBase> _DialogOrFailure();

class SettingRepositoryImp extends SettingRepository {
  final AppDataSource dataSource;
  SettingRepositoryImp({required this.dataSource});
  
  @override
  Future<Either<Failure, Setting>> instertDefaultUserSettings(int user_id) async {
    //Puts a new default set of settings into the database
    return await _getResults(() async {
      await dataSource.insert(UserSettingNames.tableName, _toUserSetting(user_id, UserSettingNames.setting_auto_archive, SettingNames.userArchiveTrue));
      await dataSource.insert(UserSettingNames.tableName, _toUserSetting(user_id, UserSettingNames.setting_auto_process, SettingNames.autoProcessedTrue));
      await dataSource.insert(UserSettingNames.tableName, _toUserSetting(user_id, UserSettingNames.setting_bar_chart, SettingNames.barChartTotal));
      await dataSource.insert(UserSettingNames.tableName, _toUserSetting(user_id, UserSettingNames.setting_currency, SettingNames.defaultCurrency));
      await dataSource.insert(UserSettingNames.tableName, _toUserSetting(user_id, UserSettingNames.setting_endDate, GeneralUtil.intFromTime(GeneralUtil.oneYearFromNow())));
      return Setting.withData(user_id: user_id, autoArchive: SettingNames.userArchiveTrue, autoProces: SettingNames.autoProcessedTrue, barChart:  SettingNames.barChartTotal, currency: SettingNames.defaultCurrency, endDate: GeneralUtil.oneYearFromNow());       
    });    
  }
  @override
  Future<Either<Failure, DialogBase>> barChartSettings(int user_id, int? account_id) async {

    return await _getDialogResults(() async {
      
      late DialogBase db;      
      AccountRepository ar =  sl<AccountRepository>();
      final _accounts = await ar.accountsAndDetails();
      _accounts.fold(
        (failure) => throw(failure),
        (dialogBase) => db = dialogBase,
      );
      if(account_id != null){
        final _settings = await updateUserSetting(user_id, UserSettingNames.setting_bar_chart, account_id);
        _settings.fold(
          (failure) => throw(failure),
          (setting) => db.setting = setting,
        );       
      } else {
        final _settings = await getUserSettings(user_id);
        _settings.fold(
          (failure) => throw(failure),
          (setting) => db.setting = setting,
        );        
      }
      return db;      
    });
  }
  @override
  Future<Either<Failure, void>> deleteUserSettings(int user_id) async {
    //Delete all records that match the user_id
    return await _getNullResults(() async {
      await dataSource.deleteWhere(UserSettingNames.tableName, UserSettingNames.user_id, user_id);
      return (null);
    });
  }
  @override
  Future<Either<Failure, Setting>> updateUserSetting(int user_id, int setting_id, int? value, {DateTime? timed}) async {
    return await _getResults(() async {
      if(timed != null){
        value = GeneralUtil.intFromTime(timed);
      }
      await  dataSource.updateWhere(UserSettingNames.tableName, [UserSettingNames.user_id, UserSettingNames.setting_id], [user_id, setting_id], {UserSettingNames.value: value!});
      final _data = await dataSource.getAllDataWhereAny(UserSettingNames.tableName, UserSettingNames.user_id, user_id);      
      final _setting = _toSetting(_data, user_id);
      sl<Setting>().resetSettings(_setting); //Now re-set the setting in IC
      return _setting; 
    });
    
  }  
  @override
  Future<Either<Failure, Setting>> getUserSettings(int user_id) async {
    return await _getResults(() async {
      final _data = await dataSource.getAllDataWhereAny(UserSettingNames.tableName, UserSettingNames.user_id, user_id);
      return _toSetting(_data, user_id); 
    });
  } 
  
  Setting _toSetting(List<Map<String, dynamic>> data, int user_id){
    Setting _setting = Setting.withUserOnly(user_id: user_id);
    //This gets the results from the database UserSettings and converts to a Setting class
    for(Map<String, dynamic> map in data){
      switch(map[UserSettingNames.setting_id]){
        case UserSettingNames.setting_auto_archive:
          _setting.autoArchive = map[UserSettingNames.value];
          break;
        case UserSettingNames.setting_auto_process:
          _setting.autoProcess  = map[UserSettingNames.value];
          break;
        case UserSettingNames.setting_bar_chart:
          _setting.barChart = map[UserSettingNames.value];
          break;
        case UserSettingNames.setting_currency:
          _setting.currency = map[UserSettingNames.value];
          break;
        case UserSettingNames.setting_endDate:
          int intDate = map[UserSettingNames.value];
          _setting.endDate = GeneralUtil.timeFromInt(intDate);
      }
    }
    return _setting;
  }
  
  Map<String, Object> _toUserSetting(int user_id, int setting_id, int value){
    return {
      UserSettingNames.user_id: user_id,
      UserSettingNames.setting_id: setting_id,
      UserSettingNames.value: value,
    };
  } 
  Future<Either<Failure, Setting>> _getResults(_SettingOrFailure settingsOrFailure) async {
    try{
      final setting = await settingsOrFailure();
      return Right(setting);
    } on ServerException catch(error){
      return Left(ServerFailure(error.message));
    } on Exception catch(error){
      return Left(ServerFailure(error.toString()));
    }
  } 
  Future<Either<Failure, void>> _getNullResults(_NullOrFailure nullOrFailure) async {
    try{
      final setting = await nullOrFailure();
      return Right(null);
    } on ServerException catch(error){
      return Left(ServerFailure(error.message));
    } on Exception catch(error){
      return Left(ServerFailure(error.toString()));
    }
  }
  Future<Either<Failure, DialogBase>> _getDialogResults(_DialogOrFailure dialogOrFailure) async {
    try{
      final dialogBase = await dialogOrFailure();
      return Right(dialogBase);
    } on ServerException catch(error){
      return Left(ServerFailure(error.message));
    } on Exception catch(error){
      return Left(ServerFailure(error.toString()));
    }
  }    
}