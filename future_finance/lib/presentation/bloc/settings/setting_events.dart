import 'package:meta/meta.dart';

@immutable
abstract class SettingBlocEvent{}

class DeleteUserSettings extends SettingBlocEvent{
  final int id;
  DeleteUserSettings({required this.id});
}
class InsertUserSettings extends SettingBlocEvent{
  final int id;
  InsertUserSettings({required this.id});
}
class GetUserSettings extends SettingBlocEvent{
  final int id;
  GetUserSettings({required this.id});
}
class UpdateUserSetting extends SettingBlocEvent{
  final int user_id;
  final int setting_id;
  final int value;
  UpdateUserSetting({required this.user_id, required this.setting_id, required this.value});
}
class UpdateEndDateSetting extends SettingBlocEvent{
  final int user_id;
  final int setting_id;
  final DateTime time;
  UpdateEndDateSetting({required this.user_id, required this.setting_id, required this.time});
}
class BarChartEvent extends SettingBlocEvent{
  final int user_id;
  final int? account_id;
  BarChartEvent({required this.user_id, this.account_id});
}