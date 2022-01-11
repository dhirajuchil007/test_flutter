import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'main.dart';

class OTPVerification extends StatefulWidget {
  const OTPVerification({Key? key}) : super(key: key);

  @override
  _OTPVerificationState createState() => _OTPVerificationState();
}

class _OTPVerificationState extends State<OTPVerification> {
  final Future<FirebaseApp> _future = Firebase.initializeApp();
  final myController = TextEditingController();
  bool showEnterOTP = false;
  String verificationID = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("OTP verification"),
      ),
      body: getUI(showEnterOTP, context),
    );
  }

  Column getUI(bool showEnterOTP, BuildContext context) {
    String ins = "";
    if (showEnterOTP)
      ins = "Enter OTP";
    else
      ins = "Ennter mobile number";
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          ins,
          style: TextStyle(
            fontSize: 18,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: myController,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            textAlign: TextAlign.center,
            maxLength: 10,
            style: TextStyle(fontSize: 25),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
              onPressed: () {
                if (showEnterOTP) {
                  verifyOTP(context, myController.text, verificationID);
                } else {
                  startAuth(context, myController.text);
                }
              },
              child: const Text("Proceed")),
        )
      ],
    );
  }

  void startAuth(BuildContext context, String text) async {
    String number = "+91$text";
    print("Mobile Number $number");
    FirebaseAuth auth = FirebaseAuth.instance;
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+91$text',
      verificationCompleted: (PhoneAuthCredential credential) async {
        //todo add auto read later
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e.message);
      },
      codeSent: (String verificationId, int? resendToken) {
        this.verificationID = verificationId;
        setState(() {
          showEnterOTP = true;
          myController.clear();
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  void verifyOTP(
      BuildContext context, String text, String verificationId) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    // Create a PhoneAuthCredential with the code
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: text);
    print("verified $credential.token");
    // Sign the user in (or link) with the credential
    await auth.signInWithCredential(credential).whenComplete(() => {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => InvestmentFlow(title: "My app")),
          )
        });
  }
}
