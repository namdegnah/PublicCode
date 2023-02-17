import 'package:flutter/material.dart';
import 'app_drawer.dart';
import 'animations/fast_animation.dart';
import '../widgets/common_widgets.dart';
import 'preferences_page.dart';
import '../../domain/usecases/function_calls.dart';
import '../../domain/usecases/convert/group_web_dev_convert.dart';
import '../../domain/usecases/convert/group_dev_regcode_convert.dart';
import '../../domain/usecases/convert/money_bank_account_convert.dart';
import '../../domain/usecases/convert/money_web_login_convert.dart';
import '../../domain/usecases/convert/personal_weblogin_convert.dart';
import '../../domain/usecases/convert/teacher_weblogin_convert.dart';
import '../../domain/usecases/convert/personal_people_convert.dart';
import '../../domain/usecases/convert/games_weblogin_convert.dart';
import '../../domain/usecases/convert/home_weblogin_convert.dart';
import 'package:permission_handler/permission_handler.dart';

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
          IconButton(
            icon: const Icon(Icons.import_contacts),
            onPressed: () async => await restore(),
          ),
          IconButton(
            icon: const Icon(Icons.backup),
            // calls startup to get the latest data
            onPressed: () async => await backup(context),
          ), 
          IconButton(
            icon: const Icon(Icons.telegram),
            onPressed: () async {
              // await convertDevWebLogin();
              // await convertDevRegCode();
              // await convertMoneyBankAccount();
              // await convertMoneyWebLogin();
              // await convertPersonalWebLogin();
              // await convertTeacherWebLogin();
              // await convertPersonalPeople();
              // await convertGamesWebLogin();
              // await convertHomesWebLogin();
              await checkStoragePermission();
            } 
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