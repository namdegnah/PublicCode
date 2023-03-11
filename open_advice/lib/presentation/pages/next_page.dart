import 'package:flutter/material.dart';
import '../../domain/entities/password.dart';
import '../../domain/usecases/function_calls.dart';

class NextPage extends StatelessWidget {
  const NextPage({super.key});

  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
      body: FutureBuilder<List<Password>>(
        future: getPasswordList(),
        builder:  (BuildContext context, AsyncSnapshot<List<Password>> snapshot){
          if(snapshot.hasData){
            return CustomScrollView(
              slivers: <Widget>[
                const SliverAppBar(
                  iconTheme: IconThemeData(color: Colors.black26),
                  backgroundColor: Colors.white,
                  pinned: true,
                  expandedHeight: 265,
                  flexibleSpace: FlexibleSpaceBar(
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
                  delegate: SliverChildBuilderDelegate((_, index) {
                      final password = snapshot.data![index];
                      return ListTile(
                        title: Text(password.description),
                        subtitle: Text(password.id.toString()),
                      );
                    },
                    childCount: snapshot.data!.length,
                  ),
                ),
              ],
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
    return scaffold;
  }
}