import 'package:meta/meta.dart';
import '../../../data/models/facts_base.dart';

@immutable
abstract class FactsBlocState{}
class FactsBlocInitialState extends FactsBlocState{}
// class FactsBlocStateChild extends FactsBlocState{
//   FactsBlocStateChild();
// }
class Empty extends FactsBlocState{}
class Loading extends FactsBlocState{}
class Error extends FactsBlocState{
  final String message;
  Error({required this.message});
}
class FactsState extends FactsBlocState{
  final FactsBase factsBase;
  FactsState({required this.factsBase});
}
class RunPauseState extends FactsBlocState{
  final FactsBase factsBase;
  RunPauseState({required this.factsBase});
}
class RealUpdateState extends FactsBlocState{}
