import '../../presentation/widgets/common_widgets.dart';
import '../../presentation/config/injection_container.dart';
import '../entities/recurrence.dart';
import '../../data/models/facts_base.dart';
import '../../presentation/bloc/transactions/transaction_bloc_exports.dart' as TN;
import '../../presentation/bloc/transfers/transfer_bloc_exports.dart' as TF;
import '../usecases/recurrence_facts_usecase.dart';
import '../../presentation/config/constants.dart';
import '../../domain/entities/setting.dart';

extension abc on FactsBase{
  void processedBefore(DateTime date){ 
    if(sl<Setting>().autoArchive == SettingNames.userArchiveTrue){
      for(var trans in this.transactions){
        if(trans.recurrenceId == 0){ // This is the one off
          if(trans.plannedDate!.isBefore(date)){
            sl<TN.TransactionsBloc>().add(TN.UpdateProcessedEvent(id: trans.id));
            trans.processed = SettingNames.userArchiveTrue;
          }        
        } else if(trans.recurrenceId != 0) {
          Recurrence recurrence = this.recurrences.firstWhere((rec) => rec.id == trans.recurrenceId);
          if(recurrence != 0){
            DateTime? d = recurrence.getEndDate(trans);
            if(d != null && d.isBefore(date)){
                sl<TN.TransactionsBloc>().add(TN.UpdateProcessedEvent(id: trans.id));
                trans.processed = SettingNames.userArchiveTrue;
            };
          }
        }
      }
      for(var trans in this.transfers){
        if(trans.recurrenceId == 0){ // This is the one off
          if(trans.plannedDate!.isBefore(date)){
            sl<TF.TransferBloc>().add(TF.UpdateProcessedEvent(id: trans.id)); 
            trans.processed = SettingNames.userArchiveTrue;
          }        
        } else if(trans.recurrenceId != 0) {
          Recurrence recurrence = this.recurrences.firstWhere((rec) => rec.id == trans.recurrenceId);

            DateTime? d = recurrence.getEndDate(trans);
            if(d != null && d.isBefore(date)){
                sl<TF.TransferBloc>().add(TF.UpdateProcessedEvent(id: trans.id));
                trans.processed = SettingNames.userArchiveTrue;
            };
          
        }
      }
      setHasBeenDoneOnce();          
    }
  }
}