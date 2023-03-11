import 'package:flutter/material.dart';
import '../../bloc/group/group_bloc.dart';
import '../../bloc/group/group_bloc_events.dart';
import '../../pages/group_screen.dart';
import '../../../domain/entities/group.dart';
import 'group_widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupList extends StatefulWidget {
  final List<Group> groups;
  const GroupList(this.groups, {Key? key}) : super(key: key);

  @override
  State<GroupList> createState() => _GroupListState();
}

class _GroupListState extends State<GroupList> {
  void _navigateAndDisplayGroup(BuildContext context) async {
    var result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider<GroupBloc>.value(
          value: GroupBloc(),
          child: GroupScreen(
            group: Group(id: -1, name: ''),
          ),
        ),
      ),
    );
    if (result != null) {
      BlocProvider.of<GroupBloc>(context).add(InsertGroupEvent(group: result as Group));
    }
  }
  @override
  void callOthers() {
    setState(() {
      
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            iconTheme: const IconThemeData(color: Colors.black26),
            actions: <Widget>[              
              IconButton(
                key: const ValueKey('addGroupButton'),
                icon: const Icon(Icons.add),
                onPressed: () {
                  _navigateAndDisplayGroup(context);
                },
              ),
            ],
            backgroundColor: Colors.white,
            pinned: true,
            expandedHeight: 265,
            flexibleSpace: const FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                'Groups',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              background: DecoratedBox(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/group.png'),
                    scale: 1.25,
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, index) {
                return GroupListTile(widget.groups[index], callOthers);
              },
              childCount: widget.groups.length,
            ),
          ),
        ],
      ),
    );
  }
}
