import 'package:flutter_bloc/flutter_bloc.dart';
import '../../config/injection_container.dart';
import '../../../data/models/params.dart';
import '../../../domain/usecases/transfer_usecase.dart';
import 'transfer_bloc_exports.dart';

class TransferBloc extends Bloc<TransferBlocEvent, TransferBlocState> {
  final TransferUser transferUser = sl<TransferUser>();

  TransferBloc() : super(TransferInitialState()){
    on<GetTransfersEvent>((event, emit) => _getTransfers(event, emit));
    on<GetTransferEvent>((event, emit) => _getTransfer(event, emit));
    on<InsertTransferEvent>((event, emit) => _insertTransfer(event, emit));
    on<DeleteTransferEvent>((event, emit) => _deleteTransfer(event, emit));
    on<UpdateTransferEvent>((event, emit) => _updateTransfer(event, emit));
  }
  void _getTransfers(GetTransfersEvent event, Emitter<TransferBlocState> emit) async {
    emit(Loading());
    final failureOrTransfersList = await transferUser(Params());
    failureOrTransfersList.fold(
      (failure) => emit(Error(message: failure.message)),
      (transfers) => emit(TransfersState(transfers: transfers)),      
    );
  }
  void _getTransfer(GetTransferEvent event, Emitter<TransferBlocState> emit) async {
    emit(Loading());
    final failureOrTransfer = await transferUser.transfer(Params.id(id: event.id));
    failureOrTransfer.fold(
      (failure) => emit(Error(message: failure.message)),
      (transfer) => emit(TransferState(transfer: transfer)),     
    );
  }
  void _insertTransfer(InsertTransferEvent event, Emitter<TransferBlocState> emit) async {
    emit(Loading());
    final failureOrTransfersList = await transferUser.insertTransfer(Params.transfer(transfer: event.transfer));
    failureOrTransfersList.fold(
      (failure) => emit(Error(message: failure.message)),
      (transfers) => emit(TransfersState(transfers: transfers)),      
    );
  }
  void _deleteTransfer(DeleteTransferEvent event, Emitter<TransferBlocState> emit) async {
    emit(Loading());
    final failureOrTransfersList = await transferUser.deleteTransfer(Params.id(id: event.id));
    failureOrTransfersList.fold(
      (failure) => emit(Error(message: failure.message)),
      (transfers) => emit(TransfersState(transfers: transfers)),      
    );
  } 
  void _updateTransfer(UpdateTransferEvent event, Emitter<TransferBlocState> emit) async {
    emit(Loading());
    final failureOrTransfersList = await transferUser.updateTransfer(Params.transfer(transfer: event.transfer));
    failureOrTransfersList.fold(
      (failure) => emit(Error(message: failure.message)),
      (transfers) => emit(TransfersState(transfers: transfers)),    
    );    
  }     
}