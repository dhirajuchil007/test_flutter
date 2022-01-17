import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_flutter/ChangeNotifier/app_language.dart';
import 'package:test_flutter/routes/dynamic_sip.dart';
import 'package:test_flutter/routes/get_location_data.dart';
import 'package:test_flutter/routes/home_screen.dart';
import 'package:test_flutter/routes/main.dart';
import 'package:test_flutter/routes/otp_verification.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Start extends StatefulWidget {
  const Start({Key? key}) : super(key: key);

  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {
  String selectedValue="English";
  @override
  Widget build(BuildContext context) {
    var appLanguage = Provider.of<AppLanguage>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select a demo"),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: DropdownButton<String>(
                  value: selectedValue,
                    items: ['English', 'Hindi'].map((e) {
                      return DropdownMenuItem(
                        child: Text(e),
                        value: e,
                      );
                    }).toList(),
                    onChanged: (item) {
                    switch(item){
                      case 'English':

                       appLanguage.changeLanguage(Locale('en'));
                        break;

                      case 'Hindi':
                        appLanguage.changeLanguage(Locale('hi'));
                        break;

                    }

                    setState(() {
                      selectedValue=item??"";
                    });

                    }),
              ),
              StartItem(
                optionName: AppLocalizations.of(context)!.otpVerification,
                callback: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const OTPVerification()),
                  )
                },
              ),
              StartItem(
                optionName: AppLocalizations.of(context)!.investment,
                callback: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => InvestmentFlow(title: "My app")),
                  )
                },
              ),
              StartItem(
                  optionName: AppLocalizations.of(context)!.dynamicSIP,
                  callback: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const DynamicSIP()),
                        )
                      }),
              StartItem(
                  optionName: AppLocalizations.of(context)!.getAddress,
                  callback: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const GetLocation()),
                        )
                      }),
              StartItem(
                  optionName: AppLocalizations.of(context)!.homeScreen,
                  callback: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeScreen()),
                        )
                      })
            ],
          ),
        ),
      ),
    );
  }
}

class StartItem extends StatelessWidget {
  String optionName;
  Function callback;

  StartItem({Key? key, required this.optionName, required this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: GestureDetector(
        onTap: () {
          callback.call();
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey)),
          child: Padding(
            child: Text(optionName),
            padding: EdgeInsets.all(24),
          ),
        ),
      ),
    );
  }
}
