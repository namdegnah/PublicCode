import 'package:flutter/material.dart';
import '../../domain/entities/best_team.dart';
import '../widgets/best_team_widgets.dart';

class BestTeamScreen extends StatefulWidget {
  const BestTeamScreen({required this.bestTeam, super.key});
  final BestTeam bestTeam;
  @override
  State<BestTeamScreen> createState() => _BestTeamScreenState();
}
class _BestTeamScreenState extends State<BestTeamScreen> {
  late double listDepth;

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    orientation == Orientation.portrait ? listDepth = 500 : listDepth = 200;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: const Text('Team Screen')),
      body: orientation == Orientation.portrait
      ? Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          teamDisplay(widget.bestTeam),
          const SizedBox(height: 10,),
          squadDisplay(widget.bestTeam, orientation, size, listDepth),
        ]
      ) 
      : Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          teamDisplay(widget.bestTeam),
          SizedBox(height: 10,),
          squadDisplay(widget.bestTeam, orientation, size, listDepth),
        ],
      ),
    );
  }
}