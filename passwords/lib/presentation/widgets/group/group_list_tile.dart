import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/password_filter.dart';
import '../../../domain/entities/group.dart';
import '../../pages/group_screen.dart';
import '../../bloc/group/group_bloc.dart';
import '../../bloc/group/group_bloc_events.dart';
import '../../config/constants.dart';
import '../../config/injection_container.dart';

class GroupListTile extends StatefulWidget {
  @required
  final Group group;
  final Function callback;
  GroupListTile(this.group, this.callback, {Key? key}) : super(key: key);

  @override
  State<GroupListTile> createState() => _GroupListTileState();
}

class _GroupListTileState extends State<GroupListTile> {
  bool isChosen = false;

  void _deleteGroup(BuildContext context, int id) {
    BlocProvider.of<GroupBloc>(context).add(DeleteGroupEvent(id: id));
  }  

  void _navigateAndDisplayGroup(BuildContext context, int id) async {
    var result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider<GroupBloc>.value(
          value: GroupBloc(),
          child: GroupScreen(
            group: widget.group,
          ),
        ),
      ),
    );
    if (result != null) {
      BlocProvider.of<GroupBloc>(context).add(UpdateGroupEvent(group: result as Group));
    }
  }

  Widget _selectGroup(int id) {
    if(sl<PasswordFilter>().groupId == null){
      isChosen = false;
    } else if (sl<PasswordFilter>().groupId! != widget.group.id || sl<PasswordFilter>().groupId! == AppConstants.noFilterChosen){
      isChosen = false;
    } else {
      isChosen = true;
    }
    String numb;
    Color background;
    if (isChosen) {
      background = ColourScheme.clred;
    } else {
      background = ColourScheme.cltx;
    }
    numb = id.toString();  
    return GestureDetector(
      onTap: () {
        setState(() {
          if(isChosen == true){
            isChosen = false;
            sl<PasswordFilter>().groupId = AppConstants.noFilterChosen;
          } else {
            isChosen = true;
            sl<PasswordFilter>().groupId = widget.group.id;
          }
          widget.callback();
        });
      },
      child: CircleAvatar(
          backgroundColor: background,
          maxRadius: 25,
          minRadius: 20,
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Text(
              numb,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
 
    int id = widget.group.id;
    return Column(
      children: <Widget>[
        ListTile(
          leading: _selectGroup(id),
          title: Text(widget.group.name),
          trailing: SizedBox(
            width: 100,
            child: Row(
              children: <Widget>[
                IconButton(
                  key: ValueKey('iconbuttonedit${widget.group.id}'),
                  icon: const Icon(Icons.edit),
                  onPressed: () => _navigateAndDisplayGroup(context, id),
                ),
                IconButton(
                  key: ValueKey('iconbuttondelete${widget.group.id}'),
                  icon: const Icon(Icons.delete),
                  onPressed: () => _deleteGroup(context, id),
                ),
              ],
            ),
          ),
        ),
        const Divider(
          height: 2,
          thickness: 2,
        )
      ],
    );
  }
}
