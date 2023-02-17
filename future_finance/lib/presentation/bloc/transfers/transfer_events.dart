import 'package:meta/meta.dart';
import '../../../domain/entities/transfer.dart';

@immutable
abstract class TransferBlocEvent{}

class GetTransfersEvent extends TransferBlocEvent{}
class GetTransferAccountsEvent extends TransferBlocEvent{}
class GetTransferEvent extends TransferBlocEvent{
  final int id;
  GetTransferEvent({required this.id});
}
class DeleteTransferEvent extends TransferBlocEvent{
  final int id;
  DeleteTransferEvent({required this.id});
}
class UpdateTransferEvent extends TransferBlocEvent{
  final Transfer transfer;
  UpdateTransferEvent({required this.transfer});
}
class InsertTransferEvent extends TransferBlocEvent{
  final Transfer transfer;
  InsertTransferEvent({required this.transfer});
}
class TransferDialogEvent extends TransferBlocEvent{
  final List<String> tableNames;
  TransferDialogEvent({required this.tableNames});
}
class UpdateProcessedEvent extends TransferBlocEvent {
  final int id;
  UpdateProcessedEvent({required this.id});
}