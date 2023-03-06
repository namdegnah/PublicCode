import 'package:flutter/material.dart';
import 'presentation/config/injection_container.dart' as di;
import 'presentation/config/buttons/standard_button.dart';
import 'domain/usecases/function_calls.dart' as calls;
import 'presentation/config/style/text_style.dart';
import 'presentation/config/navigation/app_router.dart';
import 'presentation/config/navigation/app_navigation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'presentation/bloc/http/http_bloc.dart';

void main() async {
  await di.init();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final AppRouter appRouter = AppRouter();
    return MultiBlocProvider(
      providers: [
        BlocProvider<HttpBloc>(create: (context) => HttpBloc(),),          
      ],      
      child: Builder(
        builder: (context) {
          return MaterialApp(
            title: 'Test and Test Again',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: const MyHomePage(title: 'Testing'),
            navigatorKey: di.sl<AppNavigation>().navigatorKey,
            onGenerateRoute: appRouter.onGenerateRoute,      
          );
        }
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
              key: const Key('counterTextcounterText'),
            ),
            getNextStepButton('loadnextpage', 'Next Step...', () => calls.loadNextPage),
            const SizedBox(height: 10,),
            getNextStepButton('btfootball', 'Football', () => calls.loadFootballPage)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        key: const Key('floatfloat'),
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
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
