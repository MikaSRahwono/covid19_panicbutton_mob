import 'package:covid19_panicbutton_mob/widgets/quiz.dart';
import 'package:flutter/material.dart';
import './cookie_request.dart';
import 'package:provider/provider.dart';
import 'widgets/drawer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) {
        CookieRequest request = CookieRequest();

        return request;
      },
      child: MaterialApp(
        title: 'Covid-19 Panic Button',
        theme: ThemeData(
            primarySwatch: Colors.lightBlue,
            elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
              primary: Color.fromRGBO(110, 110, 220, 1),
              fixedSize: const Size(160, 100),
            ))),
        home: const MyHomePage(title: 'Covid-19 Panic Button'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: MainDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '!!! COVID-19 PANIC BUTTON !!!',
              style: Theme.of(context).textTheme.headline5,
            ),
            Padding(
                padding: const EdgeInsets.all(40),
                child: ElevatedButton(
                    child: const Text(
                      'P',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 50,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return MyQuizApp();
                      }));
                    })),
            Text(
              'Press the button to continue',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
      ),
    );
  }
}
