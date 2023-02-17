import 'package:meta/meta.dart';

@immutable
abstract class FactsBlocEvent{}

class GetFactsEvent extends FactsBlocEvent{}
class GetHomeEvent extends FactsBlocEvent{}
class RunPauseEvent extends FactsBlocEvent{}

//class RealUpdateEvent extends FactsBlocEvent{}

