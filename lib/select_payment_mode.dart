import 'package:flutter/material.dart';
import 'package:test_flutter/models/invest.dart';
import 'package:test_flutter/models/mfpayment_response.dart';
import 'package:test_flutter/models/payment_method_model.dart';
import 'package:test_flutter/payment_web_view.dart';
import 'package:test_flutter/services/api_endpoints.dart';
import 'package:test_flutter/widgets/payment_method_widget.dart';

import 'models/scheme_model.dart';

class SelectPaymentMode extends StatefulWidget {
  final SchemeModel schemeModel;
  final String amount;

  const SelectPaymentMode(
      {Key? key, required this.schemeModel, required this.amount})
      : super(key: key);

  @override
  _SelectPaymentModeState createState() =>
      _SelectPaymentModeState(schemeModel, amount);
}

class _SelectPaymentModeState extends State<SelectPaymentMode> {
  SchemeModel schemeModel;
  String amount;
  bool isInternetBankingSelected = false;
  bool isQuickPaySelected = false;
  Future<InvestResponse>? _investResponse;
  Future<MfPaymentResponse>? _paymentResponse;

  _SelectPaymentModeState(this.schemeModel, this.amount);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: size.width,
          height: size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Investing In",
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                schemeModel.schemeName,
                style: const TextStyle(fontSize: 22),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Pay via",
                style: TextStyle(fontSize: 22),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isInternetBankingSelected = true;
                            isQuickPaySelected = false;
                          });
                        },
                        child: PaymentMethod(
                          paymentMethodModel: PaymentMethodModel(
                              1,
                              "Internet Banking",
                              "ICICI Bank",
                              isInternetBankingSelected),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isInternetBankingSelected = false;
                            isQuickPaySelected = true;
                          });
                        },
                        child: PaymentMethod(
                          paymentMethodModel: PaymentMethodModel(
                              2, "Quickpay", "ICICI Bank", isQuickPaySelected),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                  onPressed: () async {
                    _investResponse = API_Endpoints().invest(
                        "96022",
                        schemeModel.schemeMasterId.toString(),
                        double.parse(amount),
                        "1234");
                    _investResponse!.then((value) => {
                          if (value.mfOrderId != null)
                            {
                              API_Endpoints()
                                  .mfPayment(
                                      "96022",
                                      value.mfOrderId!,
                                      isInternetBankingSelected ? 901 : 902,
                                      15365)
                                  .then(
                                    (v) => {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => PaymentWebView(
                                              link: v.response!.link,
                                              page: v.response!.page,
                                              paymentType:
                                                  isInternetBankingSelected
                                                      ? 901
                                                      : 902,
                                              mfOrderId: value.mfOrderId),
                                        ),
                                      ),
                                    },
                                  )
                            }
                        });
                    setState(() {
                      print(_investResponse.toString());
                    });
                  },
                  child: Text("Invest")),
              FutureBuilder<InvestResponse>(
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(snapshot.data.toString());
                  } else {
                    return Container();
                  }
                },
                future: _investResponse,
              ),
              FutureBuilder(
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(snapshot.data.toString());
                  } else {
                    return Container();
                  }
                },
                future: _paymentResponse,
              )
            ],
          ),
        ),
      ),
    );
  }
}
