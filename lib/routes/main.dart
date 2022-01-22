import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:test_flutter/ChangeNotifier/app_language.dart';
import 'package:test_flutter/routes/select_payment_mode.dart';
import 'package:test_flutter/models/scheme_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:test_flutter/routes/start.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  AppLanguage appLanguage = AppLanguage();
  await appLanguage.fetchLocale();

  runApp(MyApp(
    appLanguage: appLanguage,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.appLanguage}) : super(key: key);
  final AppLanguage appLanguage;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppLanguage>(
      create: (_) => appLanguage,
      child: Consumer<AppLanguage>(
        builder: (BuildContext context, value, Widget? child) {
          return MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: [Locale('en'), Locale('hi')],
            title: 'lol',
            onGenerateTitle: (context) =>
                AppLocalizations.of(context)!.helloWorld,
            locale: value.appLocal,
            theme: ThemeData(
                // This is the theme of your application.
                //
                // Try running your application with "flutter run". You'll see the
                // application has a blue toolbar. Then, without quitting the app, try
                // changing the primarySwatch below to Colors.green and then invoke
                // "hot reload" (press "r" in the console where you ran "flutter run",
                // or simply save your changes to "hot reload" in a Flutter IDE).
                // Notice that the counter didn't reset back to zero; the application
                // is not restarted.
                primarySwatch: Colors.blue,
                accentColor: Colors.orangeAccent,
                canvasColor: Colors.white),
            themeMode: ThemeMode.light,
            darkTheme: ThemeData(
                primarySwatch: Colors.purple,
                accentColor: Colors.indigoAccent,
                canvasColor: const Color.fromRGBO(50, 50, 50, 1.0)
                ,textTheme:
              TextTheme(bodyText1: TextStyle(),headline4: TextStyle()).apply(
                bodyColor: Colors.white,
                displayColor: Colors.white
              )

            ),
            home: Start(),
          );
        },
      ),
    );
  }
}

class InvestmentFlow extends StatefulWidget {
  const InvestmentFlow({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<InvestmentFlow> createState() => _InvestmentFlowState();
}

class _InvestmentFlowState extends State<InvestmentFlow> {
  int _counter = 0;
  SchemeModel schemeModel = SchemeModel(
      1000001, "ICICI prudential liquid fund (G)", "www.google.com");
  final myController = TextEditingController();
  final databaseRef = FirebaseDatabase.instance.reference();
  final Future<FirebaseApp> _future = Firebase.initializeApp();
  var _locale = 'en';

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    var padding = 20.0;
    databaseRef.once().then((DataSnapshot snapshot) {
      print('Data : ${snapshot.value}');
    });
    var paddingAround =
        EdgeInsets.symmetric(horizontal: padding, vertical: padding);
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: paddingAround,
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(children: [
              Image.asset(
                'assets/square_emboss_logo.png',
                width: 30,
                height: 30,
              ),
              Padding(
                padding: paddingAround,
                child: const Text(
                  "CashRich",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ]),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => showModal(context),
                    child: Container(
                      child: const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text("ICICI Prudential Liquid Fund (G)"),
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey)),
                    ),
                  ),
                  Padding(
                    padding: paddingAround,
                    child: TextField(
                      maxLength: 8,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      controller: myController,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(hintText: "Enter Amount"),
                    ),
                  )
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SelectPaymentMode(
                          schemeModel: schemeModel, amount: myController.text)),
                )
              },
              child: const Text('Proceed'),
            )
          ],
        ),
      ),
    ));
  }

  void showModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            child: Text("This is a modal"),
          );
        });
  }
}
