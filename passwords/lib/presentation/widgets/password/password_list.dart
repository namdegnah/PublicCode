import 'package:flutter/material.dart';
import '../../bloc/password/password_bloc.dart';
import '../../bloc/password/password_bloc_events.dart';
import '../../pages/password_screen.dart';
import '../../widgets/password/password_insert_step.dart';
import '../../../domain/entities/password.dart';
import 'password_widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../config/injection_container.dart';

class PasswordList extends StatelessWidget {
  final List<Password> passwords;
  const PasswordList(this.passwords, {Key? key}) : super(key: key);

  void _navigateAndDisplayPassword(BuildContext context) async {
    var stepResult = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider<PasswordBloc>.value(
          value: sl<PasswordBloc>(),
          child: PasswordInsertStep( // So this changes
            password: Password(id: -1, description: '', groupId: -1, typeId: -1, password: '', notes: '', isValidated: true),
          ),
        ),
      ),
    );
    if(stepResult != null){
      var insertResult = await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => BlocProvider<PasswordBloc>.value(
            value: sl<PasswordBloc>(),
            child: PasswordScreen( // So this changes
              password: stepResult as Password,
            ),
          ),
        ),
      );
      if (insertResult != null) {
        BlocProvider.of<PasswordBloc>(context).add(InsertPasswordEvent(password: insertResult as Password));
      }            
    }

  }

  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold();
    scaffold = Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            iconTheme: const IconThemeData(color: Colors.black26),
            actions: <Widget>[              
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  _navigateAndDisplayPassword(context);
                },
              ),
            ],
            backgroundColor: Colors.white,
            pinned: true,
            expandedHeight: 265,
            flexibleSpace: const FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                'Passwords',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              background: DecoratedBox(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/password_animation_small.png'),
                    scale: 1.25,
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, index) {
                return PasswordListTile(passwords[index], scaffold);
              },
              childCount: passwords.length,
            ),
          ),
        ],
      ),
    );
    return scaffold;
  }
}
