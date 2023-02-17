import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/type.dart';
import '../../pages/type_screen.dart';
import '../../bloc/type/type_bloc.dart';
import '../../bloc/type/type_bloc_events.dart';
import '../../config/constants.dart';
import '../../../domain/entities/password_filter.dart';
import '../../config/injection_container.dart';

class TypeListTile extends StatefulWidget {
  @required
  final Type type;
  final Function callback;
  const TypeListTile(this.type, this.callback, {Key? key}) : super(key: key);

  @override
  State<TypeListTile> createState() => _TypeListTileState();
}

class _TypeListTileState extends State<TypeListTile> {
  bool isChosen = false;

  void _deleteType(BuildContext context, int id) {
    BlocProvider.of<TypeBloc>(context).add(DeleteTypeEvent(type: widget.type));
  }

  void _navigateAndDisplayType(BuildContext context, int id) async {
    var result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider<TypeBloc>.value(
          value: TypeBloc(),
          child: TypeScreen(
            type: widget.type,
          ),
        ),
      ),
    );
    if (result != null) {
      BlocProvider.of<TypeBloc>(context).add(UpdateTypeEvent(type: result as Type));
    }
  }

Widget _selectType(int id) {
    if(sl<PasswordFilter>().typeId == null){
      isChosen = false;
    } else if (sl<PasswordFilter>().typeId! != widget.type.id || sl<PasswordFilter>().typeId! == AppConstants.noFilterChosen){
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
            sl<PasswordFilter>().typeId = AppConstants.noFilterChosen;
          } else {
            isChosen = true;
            sl<PasswordFilter>().typeId = widget.type.id;
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
    int id = widget.type.id;
    return Column(
      children: <Widget>[
        ListTile(
          leading: _selectType(id),
          title: Text(widget.type.name),
          trailing: SizedBox(
            width: 100,
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => _navigateAndDisplayType(context, id),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => _deleteType(context, id),
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
