import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../domain/entities/user.dart';
import '../../pages/user_screen.dart';
import '../../bloc/users/user_bloc.dart';
import '../../bloc/users/user_bloc_events.dart';
import '../../config/constants.dart';
import '../../config/injection_container.dart';

class UserListTile extends StatelessWidget {
  @required final User user;
  
  const UserListTile(this.user, {Key? key}) : super(key: key);
  
  void _deleteUser(BuildContext context, int id) {
    BlocProvider.of<UserBloc>(context).add(DeleteUserEvent(id: id));
  }

  void _navigateAndDisplayUser(BuildContext context, int id) async {
    var result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider<UserBloc>.value(
          value: sl<UserBloc>(),
          child: UserScreen(
            user: user,
          ),
        ),
      ),
    );
    if (result != null) {
      BlocProvider.of<UserBloc>(context).add(UpdateUserEvent(user: result as User));
    }
  }
  Widget _isDefaultUser(BuildContext context,int id, int duc) {
    String numb;
    Color background;
    if (id == duc) {
      numb = "Chosen";
      background = ColourScheme.clred;
    } else {
      numb = id.toString();
      background = ColourScheme.cltx;
    }
    return GestureDetector(
      onTap: () {
        sl<SharedPreferences>().setInt(AppConstants.userId, user.id);
        BlocProvider.of<UserBloc>(context).add(UserRequestData());
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
                fontSize: 11,
              ),
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    int id = user.id;
    int duc = sl<SharedPreferences>().getInt(AppConstants.userId)!;
    return Column(
      children: <Widget>[
        ListTile(
          leading: _isDefaultUser(context, id, duc),
          title: Text(user.name),
          trailing: SizedBox(
            width: 100,
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => _navigateAndDisplayUser(context, id),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => _deleteUser(context, id),
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
