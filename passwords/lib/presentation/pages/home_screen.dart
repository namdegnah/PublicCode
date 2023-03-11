import 'package:flutter/material.dart';
import 'app_drawer.dart';
import 'animations/fast_animation.dart';
import '../widgets/common_widgets.dart';
import 'preferences_page.dart';
import '../../domain/usecases/function_calls.dart';
import '../config/buttons/standard_button.dart';
import 'package:permission_handler/permission_handler.dart';
import '../config/style/text_style.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late FastAnimation animation;
  late bool size;
@override
  void initState() {
    animation  = FastAnimation();
    super.initState();
  }
  Future<PermissionStatus> checkStoragePermission() async {
    var status = await Permission.storage.status;
    if(status.isDenied){
      await Permission.storage.request();
    }
    return status;
  }
  @override
  Widget build(BuildContext context) {
    // convertData();
    size = isMoreThanMediumScreen(context);
    animation.size = true;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Passwords'),
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
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              child: Text('hmmm'),
            ),
            getNextStepButton('groupsbutton', 'Groups', () => loadGroups),
            const SizedBox(height: 5,),
            getNextStepButton('typesbutton', 'Types', () => loadTypes),
            const SizedBox(height: 5,),
            getNextStepButton('passwordbutton', 'Passwords', () => loadPasswords),
            const SizedBox(height: 5,),                        
          ],
        ),
      ),
    );
  }
  Widget getNextStepButton(String key, String title, Function onTap){
    StandardButton sb = StandardButton(
      onTap: onTap(), 
      title: title, 
      enabled: true,
      textStyle: buttonText,
      key: key,
    );
    return Center(child: sb.button);
  }  
}