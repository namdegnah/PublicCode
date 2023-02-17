import 'package:dartz/dartz.dart';
import '../../data/models/params.dart';
import '../../core/errors/failures.dart';
import '../../core/usecases/usecase.dart';
import '../repositories/repositories_all.dart';
import '../../domain/entities/setting.dart';
import '../../data/models/dialog_base.dart';

class SettingUser extends UseCase<Setting, Params>{
  final SettingRepository repository;
  SettingUser({required this.repository});

  @override
  Future<Either<Failure, Setting>> call(Params params) async {
    int user_id = params.id!;
    return await repository.instertDefaultUserSettings(user_id);
  }
  Future<Either<Failure, void>> deleteUserSettings(Params params) async {
    int user_id = params.id!;
    return await repository.deleteUserSettings(user_id);
  }
  Future<Either<Failure, Setting>> updateUserSetting(Params params) async {
    int id = params.id!;
    int id2 = params.id2!;
    int id3 = params.id3!;
    return await repository.updateUserSetting(id, id2, id3);
  }
  Future<Either<Failure, Setting>> getUserSettings(Params params) async {
    int user_id = params.id!;
    return await repository.getUserSettings(user_id);
  }
  Future<Either<Failure, DialogBase>> barChartSettings(Params params) async {
    int user_id = params.id!;
    int? account_id = params.id2;
    return await repository.barChartSettings(user_id, account_id);
  }
  Future<Either<Failure, Setting>> updateEndDateSettings(Params params) async {
    int id = params.id!;
    int id2 = params.id2!;
    DateTime endDate = params.future!;
    return await repository.updateUserSetting(id, id2, null, timed: endDate);
  }
}