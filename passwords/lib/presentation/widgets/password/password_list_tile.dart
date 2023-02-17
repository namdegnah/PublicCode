import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/group.dart';
import '../../../domain/entities/type.dart';
import '../../../domain/entities/password.dart';
import '../../pages/password_screen.dart';
import '../../bloc/password/password_bloc.dart';
import '../../bloc/password/password_bloc_events.dart';
import '../../config/constants.dart';
import 'package:flutter/services.dart';

class PasswordListTile extends StatelessWidget {
  @required
  final Password password;
  final Scaffold scaffold;
  const PasswordListTile(this.password, this.scaffold, {Key? key}) : super(key: key);
 
  void _deleteGroup(BuildContext context, int id) {
    BlocProvider.of<PasswordBloc>(context).add(DeletePasswordEvent(id: id));
  }  
  void _navigateAndDisplayPassword(BuildContext context, int id) async {
    var result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider<PasswordBloc>.value(
          value: PasswordBloc(),
          child: PasswordScreen(
            password: password,
          ),
        ),
      ),
    );
    if (result != null) {
      BlocProvider.of<PasswordBloc>(context).add(UpdatePasswordEvent(password: result as Password));
    }
  }
  Widget _isDefaultUser(int id) {
    String numb;
    numb = id.toString();
    return CircleAvatar(
      backgroundColor: ColourScheme.cltx,
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
      )
    );
  }
  Widget getSubtitle(){
    String typeName = password.types!.firstWhere((element) => element.id == password.typeId).name;
    String groupName = password.groups!.firstWhere((element) => element.id == password.groupId).name;
    return Text('$groupName : $typeName');
  }
  Future<void> putPasswordonClipboard(BuildContext context) async {
    await Clipboard.setData(ClipboardData(text: password.password));
    ScaffoldMessenger.of(context).showSnackBar(AppConstants.snackbar);
  }
  @override
  Widget build(BuildContext context) {
    int id = password.id;
    return Column(
      children: <Widget>[
        ListTile(
          onLongPress: () => putPasswordonClipboard(context),
          leading: _isDefaultUser(id),
          title: Text(password.description),
          subtitle: getSubtitle(),
          trailing: SizedBox(
            width: 100,
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => _navigateAndDisplayPassword(context, id),
                ),
                IconButton(
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
