import 'package:flutter/material.dart';
import '../../bloc/type/type_bloc.dart';
import '../../bloc/type/type_bloc_events.dart';
import 'wizard/type_wizard.dart';
import '../../pages/type_screen.dart';
import '../../../domain/entities/type.dart';
import 'type_widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/password_fields.dart';

class TypeList extends StatefulWidget {
  final List<Type> types;
  const TypeList(this.types, {Key? key}) : super(key: key);

  @override
  State<TypeList> createState() => _TypeListState();
}

class _TypeListState extends State<TypeList> {

  void _navigateAndDisplayType(BuildContext context) async { // this is the place where a new type must have the fields selected. This becomes the power of a simple app so new types can be created.
    var nameResult = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider<TypeBloc>.value(
          value: TypeBloc(),
          child: TypeScreen(
            type: Type(id: -1, name: '', fields: '01000000000000001', passwordValidationId: 1),
          ),
        ),
      ),
    );
    if(nameResult != null){
      var insertResult = await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => BlocProvider<TypeBloc>.value(
            value: TypeBloc(),
            child: TypeWizzard( // So this changes
              type: nameResult as Type,
              fields: passwordFields,
            ),
          ),
        ),
      );
      if (insertResult != null) {
        BlocProvider.of<TypeBloc>(context).add(InsertTypeEvent(type: insertResult as Type));
      }            
    }    
  }
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
                key: const ValueKey('addTypeButton'),
                icon: const Icon(Icons.add),
                onPressed: () {
                  _navigateAndDisplayType(context);
                },
              ),
            ],
            backgroundColor: Colors.white,
            pinned: true,
            expandedHeight: 265,
            flexibleSpace: const FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                'Types',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              background: DecoratedBox(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/type_smaller.png'), 
                    scale: 1.25,
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, index) {
                return TypeListTile(widget.types[index], callOthers);
              },
              childCount: widget.types.length,
            ),
          ),
        ],
      ),
    );
  }
}
