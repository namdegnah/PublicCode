import 'package:flutter/material.dart';
import 'app_drawer.dart';
import 'animations/fast_animation.dart';
import '../widgets/common_widgets.dart';
import 'preferences_page.dart';
import '../../domain/usecases/function_calls.dart';

class HomeScreenOld extends StatefulWidget {
  const HomeScreenOld({super.key});

  @override
  State<HomeScreenOld> createState() => _HomeScreenOldState();
}

class _HomeScreenOldState extends State<HomeScreenOld> {
  late FastAnimation animation;
  late bool size;
@override
  void initState() {
    animation  = FastAnimation();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    size = isMoreThanMediumScreen(context);
    animation.size = true;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Future Facts'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const PreferencePage(),)),
          ),                     
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          margin: const EdgeInsets.all(10),
          child: animation,
          //child: const Text('abc'),
        ),
      ),
    );
  }
}