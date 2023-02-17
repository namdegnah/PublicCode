//System
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../domain/usecases/function_calls.dart' as calls;

class AppDrawer extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
      return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                  image: AssetImage(
                      'assets/images/bank_of_england_fade.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Text('Menu'),
            ),
            ListTile(
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
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
              leading: const Icon(Icons.verified_user),
              title: const Text('Users'),
              onTap: () async {
                Navigator.pop(context);
                await calls.loadUsers();                    
              },
            ),
            const Divider(
              thickness: 1.0,
            ),            
            ListTile(
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
              leading: const Icon(Icons.account_balance),
              title: const Text('Accounts'),
              onTap: () async {
                Navigator.pop(context);
                await calls.loadAccounts();                    
              },
            ), 
            const Divider(
              thickness: 1.0,
            ),            
            ListTile(
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
              leading: const Icon(Icons.category),
              title: const Text('Categories'),
              onTap: () async {
                Navigator.pop(context);
                await calls.loadCategories();                    
              },
            ), 
            const Divider(
              thickness: 1.0,
            ),            
            ListTile(
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
              leading: const Icon(Icons.repeat),
              title: const Text('Recurrences'),
              onTap: () async {
                Navigator.pop(context);
                await calls.loadRecurrences();                    
              },
            ), 
            const Divider(
              thickness: 1.0,
            ),            
            ListTile(
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
              leading: const Icon(Icons.swap_vert),
              title: const Text('Transactions'),
              onTap: () async {
                Navigator.pop(context);
                await calls.loadTransactions();                    
              },
            ), 
            const Divider(
              thickness: 1.0,
            ),            
            ListTile(
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
              leading: const Icon(Icons.swap_horiz),
              title: const Text('Transfers'),
              onTap: () async {
                Navigator.pop(context);
                await calls.loadTransfers();                    
              },
            ),
            const Divider(
              thickness: 1.0,
            ),            
            ListTile(
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () async {
                Navigator.pop(context);
                await calls.loadSettings();                    
              },
            ),                                                                    
          ],
        ),
      );
  }
}
