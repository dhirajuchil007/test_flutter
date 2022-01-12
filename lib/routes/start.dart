import 'package:flutter/material.dart';
import 'package:test_flutter/routes/dynamic_sip.dart';
import 'package:test_flutter/routes/get_location_data.dart';
import 'package:test_flutter/routes/otp_verification.dart';

import '../main.dart';

class Start extends StatelessWidget {
  const Start({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select a demo"),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            StartItem(
              optionName: "OTP Verification",
              callback: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const OTPVerification()),
                )
              },
            ),
            StartItem(
              optionName: "Investment",
              callback: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => InvestmentFlow(title: "My app")),
                )
              },
            ),
            StartItem(
                optionName: "Dynamic SIP",
                callback: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const DynamicSIP()),
                      )
                    }),
            StartItem(
                optionName: "Get address",
                callback: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const GetLocation()),
                      )
                    })
          ],
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
