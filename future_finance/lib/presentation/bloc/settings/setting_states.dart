import 'package:meta/meta.dart';
import '../../../domain/entities/setting.dart';
import '../../../data/models/dialog_base.dart';

@immutable
abstract class SettingBlocState{}

class SettingInitialState extends SettingBlocState{}

class Empty extends SettingBlocState{}
class Loading extends SettingBlocState{}
class Error extends SettingBlocState{
  final String message;
  Error({required this.message});
}
class ReturnSetting extends SettingBlocState{
  final Setting setting;
  ReturnSetting({required this.setting});
}
class ReturnSettings extends SettingBlocState{
  final List<Setting> settings;
  ReturnSettings({required this.settings});
}
class BarChartState extends SettingBlocState{
  final DialogBase dialogBase;
  BarChartState({required this.dialogBase});
}