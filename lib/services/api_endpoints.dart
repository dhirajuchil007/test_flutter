import 'dart:convert';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:test_flutter/models/invest.dart';
import 'package:test_flutter/models/mfpayment_response.dart';
import 'package:test_flutter/services/constants.dart';

class API_Endpoints {
  Future<InvestResponse> invest(String customerId, String schemeId,
      double investmentAmount, String pin) async {
    var client = http.Client();
    var investResponse = null;

    try {
      var response = await client.post(Uri.parse(Constants.BASE_URL +
          "invest.json" +
          "?uname=${Constants.API_UNAME}" +
          "&pwd=${Constants.API_PWD}" +
          "&customer_id=$customerId" +
          "&scheme_id=$schemeId" +
          "&investment_amount=$investmentAmount" +
          "&customer_pin=$pin"));

      if (response.statusCode == 200) {
        var jsonString = response.body;
        print("api success: ${jsonString}");
        var jsonMap = json.decode(jsonString);
        investResponse = InvestResponse.fromJson(jsonMap);
      } else {
        print("api failed: ${response.statusCode}");
      }
    } catch (e) {
      print(e.toString());
    }
    return investResponse;
  }

  Future<MfPaymentResponse> mfPayment(String customerId, String mfOrderId,
      int paymentMethod, int customerBankId) async {
    var client = http.Client();
    var mfpaymentResponse = null;

    try {
      var response = await client.post(Uri.parse(Constants.BASE_URL +
          "mfPayment.json" +
          "?uname=${Constants.API_UNAME}" +
          "&pwd=${Constants.API_PWD}" +
          "&customer_id=$customerId" +
          "&payment_method=$paymentMethod" +
          "&customer_bank_id=$customerBankId" +
          "&mf_order_id=$mfOrderId"));

      if (response.statusCode == 200) {
        var jsonString = response.body;
        print("api success: ${jsonString}");
        var jsonMap = json.decode(jsonString);
        mfpaymentResponse = MfPaymentResponse.fromJson(jsonMap);
      } else {
        print("api failed: ${response.statusCode}");
      }
    } catch (e) {
      print(e.toString());
    }

    return mfpaymentResponse;
  }
}
