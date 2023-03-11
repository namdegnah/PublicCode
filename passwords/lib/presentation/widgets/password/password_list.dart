import 'package:flutter/material.dart';
import '../../../domain/entities/password.dart';
import 'password_widgets.dart';
import '../../../domain/usecases/password_calls.dart';

class PasswordList extends StatelessWidget {
  final List<Password> passwords;
  const PasswordList(this.passwords, {Key? key}) : super(key: key);

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
                onPressed: () => navigateAndDisplayPassword(context),
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
