import '../../presentation/widgets/common_widgets.dart';
import '../../data/models/params.dart';
import '../../presentation/config/injection_container.dart';
import '../usecases/setting_usecase.dart';
import '../../presentation/config/constants.dart';

class Setting{

  int _user_id = 0;
  int _autoProcess = 0;
  int _autoArchive = 0;
  int _barChart = -1;
  int _currency = 0;
  DateTime _endDate = DateTime.now().add(Duration(days: 365));
  Setting.withUserOnly({user_id}){
    _user_id = user_id;
  }
  Setting.withData({user_id, autoProces, autoArchive, barChart, currency, endDate}){
    _user_id = user_id; 
    _autoProcess = autoProces;
    _autoArchive = autoArchive;
    _barChart = barChart;
    _currency = currency;
    _endDate = endDate;
  }
  Setting();
  int get user_id => _user_id;
  int get autoProcess => _autoProcess;
  int get autoArchive => _autoArchive;
  int get barChart => _barChart;
  int get currency => _currency;
  DateTime get endDate => _endDate;

  set user_id(int user_id) => _user_id = user_id;
  set autoProcess(int autoProcess) => _autoProcess = autoProcess;
  set autoArchive(int autoArchive) => _autoArchive = autoArchive;
  set barChart(int barChart) => _barChart = barChart;
  set currency(int currency) => _currency = currency;
  set endDate(DateTime endDate) => _endDate = endDate;
  //receive a setting and copy all data
  void resetSettings(Setting setting){
    _user_id = setting.user_id;
    _autoProcess = setting.autoProcess;
    _autoArchive = setting.autoArchive;
    _barChart = setting.barChart == -1 ? SettingNames.barChartTotal : setting.barChart;
    _currency = setting.currency;
    _endDate = setting.endDate;
  }
  void setUp([int? userId]) async {
    //Become the
    SettingUser settingUser = sl<SettingUser>();
    final int user_id = getCurrentUserId();
    final int id = userId == null ? user_id : userId;
    final failureOrSetting = await settingUser.getUserSettings(Params.id(id: id));
    failureOrSetting.fold(
      (failure) => throw(failure),
      (setting) => resetSettings(setting),     
    );
  }
}