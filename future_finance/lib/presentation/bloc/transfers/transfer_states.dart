import 'package:meta/meta.dart';
import '../../../domain/entities/transfer.dart';
import '../../../data/models/dialog_base.dart';

@immutable
abstract class TransferBlocState{}

class TransferInitialState extends TransferBlocState{}

class Empty extends TransferBlocState{}
class Loading extends TransferBlocState{}
class Error extends TransferBlocState{
  final String message;
  Error({required this.message});
}
class TransferState extends TransferBlocState{
  final Transfer transfer;
  TransferState({required this.transfer});
}
class TransfersState extends TransferBlocState{
  final List<Transfer> transfers;
  TransfersState({required this.transfers});
}
class TransferDialogState extends TransferBlocState{
  final DialogBase data;
  TransferDialogState({required this.data});
}