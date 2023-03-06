//System
import 'package:flutter/material.dart';
import '../../domain/usecases/function_calls.dart' as calls;
import '../config/style/app_colours.dart';
class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
      return Drawer(
        backgroundColor: simplyWhite,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                  image: AssetImage(
                      'assets/images/drawer_top.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Text('Menu'),
            ),
            ListTile(
              key: Key('HomeAppDrawer'),
              contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () async {
                Navigator.pop(context);
                await calls.loadHomePage();                    
              },
            ),
            const Divider(
              thickness: 1.0,
            ),
            ListTile(
              key: Key('GroupsAppsDrawer'),
              leading: const Icon(Icons.group),
              title: const Text('Groups'),
              onTap: () async {
                Navigator.pop(context);
                await calls.loadGroups();                    
              },
            ),
            const Divider(
              thickness: 1.0,
            ),            
            ListTile(
              key: Key('TypesAppsDrawer'),
              leading: const Icon(Icons.type_specimen),
              title: const Text('Types'),
              onTap: () async {
                Navigator.pop(context);
                await calls.loadTypes();                    
              },
            ),
            const Divider(
              thickness: 1.0,
            ),             
            ListTile(
              key: Key('PasswordsAppsDrawer'),
              leading: const Icon(Icons.password),
              title: const Text('Passwords'),
              onTap: () async {
                Navigator.pop(context);
                await calls.loadPasswords();                    
              },
            ),
            const Divider(
              thickness: 1.0,
            ),             
            ListTile(
              key: Key('SearchAppsDrawer'),
              leading: const Icon(Icons.search),
              title: const Text('Search'),
              onTap: () async {
                Navigator.pop(context);
                await calls.search();                    
              },
            ),                                   
          ],
        ),
      );
  }
}
