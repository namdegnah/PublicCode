  import 'package:flutter/material.dart';
  import '../../domain/entities/best_team.dart';
  import '../config/style/text_style.dart';
  
  Widget squadDisplay(BestTeam bestTeam, Orientation orientation, Size size, double listDepth){
    double leftMargin;
    double tabletOrMobileWidth;
    (orientation == Orientation.landscape && size.width > 1080) ? tabletOrMobileWidth = 600 : tabletOrMobileWidth = 460;
    orientation == Orientation.portrait ? leftMargin = 10 : leftMargin = 0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: leftMargin),
            child: Text('Squad List', style: squadTitle,),
          ),
          SizedBox(
            width: tabletOrMobileWidth,
            height: listDepth,
            child: ListView.builder(
              itemCount: bestTeam.squad.length,
              itemBuilder: (context, index){
                return Container(
                  decoration: BoxDecoration(
                    border: const Border(bottom: BorderSide(color: Colors.black45, width: 0.5),),
                    color: index.isOdd ? Theme.of(context).colorScheme.onError : Theme.of(context).colorScheme.secondary,
                  ),
                  child: ListTile(
                    title: SizedBox(height: 10, child: Text(bestTeam.squad[index].name, style: squadName,)),
                  ),                
                );
              }
            ),
          ),        
      ],
    );
  }
  Widget teamDisplay(BestTeam bestTeam){
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 10,),
          Text(bestTeam.name, style: teamTitle, key: const Key('bestteamname')),
          const SizedBox(height: 10,),
          Text(bestTeam.address, style: teamAddress,),
        ],
      ),
    );
  }