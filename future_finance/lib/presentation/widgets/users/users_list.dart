import 'package:flutter/material.dart';
import '../../bloc/users/user_bloc.dart';
import '../../bloc/users/user_bloc_events.dart';
import '../../pages/user_screen.dart';
import '../../../domain/entities/user.dart';
import '../../widgets/users/user_widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserList extends StatelessWidget {
  final List<User> users;
  const UserList(this.users, {Key? key}) : super(key: key);

  void _navigateAndDisplayUser(BuildContext context) async {
    var result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider<UserBloc>.value(
          value: UserBloc(),
          child: UserScreen(
            user: User(id: -1, name: '', password: '', email: ''),
          ),
        ),
      ),
    );
    if (result != null) {
      BlocProvider.of<UserBloc>(context).add(InsertUserEvent(user: result as User));
    }
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
                icon: const Icon(Icons.add),
                onPressed: () {
                  _navigateAndDisplayUser(context);
                },
              ),
            ],
            backgroundColor: Colors.white,
            pinned: true,
            expandedHeight: 265,
            flexibleSpace: const FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                'Users',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              background: DecoratedBox(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/user.png'),
                    scale: 1.25,
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, index) {
                return UserListTile(users[index]);
              },
              childCount: users.length,
            ),
          ),
        ],
      ),
    );
  }
}
