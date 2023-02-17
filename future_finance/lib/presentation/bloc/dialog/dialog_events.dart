import 'package:meta/meta.dart';

@immutable
abstract class DialogBlocEvent{}

class DialogFullEvent extends DialogBlocEvent{}
class DialogAccountsEvent extends DialogBlocEvent{}
class DialogRecurrenceEvent extends DialogBlocEvent{}
class DialogCategoriesEvent extends DialogBlocEvent{}
class DialogUsersEvent extends DialogBlocEvent{}
class DialogAccountTypesEvent extends DialogBlocEvent{}
class DialogTesting extends DialogBlocEvent{}
