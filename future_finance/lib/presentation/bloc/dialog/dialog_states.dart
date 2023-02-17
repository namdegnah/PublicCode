import 'package:meta/meta.dart';
import '../../../data/models/dialog_base.dart';

@immutable
abstract class DialogBlocState{}

class DialogInitialState extends DialogBlocState{}

// class DialogBlocStateChild extends DialogBlocState{
//   DialogBlocStateChild();
// }
class Empty extends DialogBlocState{}
class Loading extends DialogBlocState{}
class Error extends DialogBlocState{
  final String message;
  Error({required this.message});
}

class DialogFullState extends DialogBlocState {
  final DialogBase data;
  DialogFullState({required this.data});  
}
class DialogAccountsState extends DialogBlocState {
  final DialogBase data;
  DialogAccountsState({required this.data});
}
class DialogRecurrencesState extends DialogBlocState {
  final DialogBase data;
  DialogRecurrencesState({required this.data});
}
class DialogCategoriesState extends DialogBlocState {
  final DialogBase data;
  DialogCategoriesState({required this.data});
}
class DialogUsersState extends DialogBlocState {
  final DialogBase data;
  DialogUsersState({required this.data});
}
class DialogAccountTypeState extends DialogBlocState {
  final DialogBase data;
  DialogAccountTypeState({required this.data});
}