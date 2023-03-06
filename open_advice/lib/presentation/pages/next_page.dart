import 'package:flutter/material.dart';
import '../../domain/usecases/function_calls.dart';
import '../../domain/entities/password.dart';
class NextPage extends StatelessWidget {
  const NextPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Next Page', key: Key('nextpagenextpage'),)),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: FutureBuilder<List<Password>>(
          future: getPasswordList(),
          builder: (BuildContext context, AsyncSnapshot<List<Password>> snapshot){
            if(snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index){
                  final password = snapshot.data![index];
                  return ListTile(
                    title: Text(password.description),
                    subtitle: Text(password.id.toString()),
                  );
                }
              );               
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}