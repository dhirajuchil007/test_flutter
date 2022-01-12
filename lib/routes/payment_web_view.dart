import 'package:flutter/material.dart';
import 'package:test_flutter/routes/investment_summary.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentWebView extends StatefulWidget {
  String? page;
  String? link;
  int? paymentType;
  String? mfOrderId;

  PaymentWebView(
      {Key? key, this.page, this.link, this.paymentType, this.mfOrderId})
      : super(key: key);

  @override
  _PaymentWebViewState createState() =>
      _PaymentWebViewState(page, link, paymentType, mfOrderId);
}

class _PaymentWebViewState extends State<PaymentWebView> {
  String? page;
  String? link;
  int? paymentType;
  String? mfOrderId;

  int step = 1;

  _PaymentWebViewState(this.page, this.link, this.paymentType, this.mfOrderId);

  WebViewController? _webViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Theme(
          data: ThemeData.light(),
          child: WebView(
            initialUrl: getRequiredPage(),
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (controller) {
              _webViewController = controller;
            },
            onPageFinished: pageLoaded,
          ),
        ),
      ),
    );
  }

  void pageLoaded(url) {
    if (!isCurrentUrlForFinalPage(url)) {
      if (paymentType == 902) {
        if (step == 1) {
          _webViewController!.runJavascript("javascript: (function() {" +
              "var n = document.getElementById('mainTBL').rows.length;" +
              "var checkboxes = document.getElementsByTagName('input');" +
              "for (var i = 0; i < n-1; i++) {" +
              "             var checkboxType = document.getElementById('chk_'+i);" +
              "             if (checkboxType.type == 'checkbox') {" +
              "                  checkboxType.checked = false;" +
              "             }" +
              "             var hdnOrderNoVal = document.getElementById('hdnOrderNo_'+i).value;" +
              "console.log(hdnOrderNoVal);" +
              "             if(hdnOrderNoVal == '$mfOrderId') {" +
              "                   checkboxType.checked = true;" +
              "             }" +
              "         }" +
              "}" +
              ") ();");

          _webViewController!.runJavascript("javascript:AddAmount()");
          _webViewController!.runJavascript(
              "javascript: (function() {document.getElementById('ddlMode').selectedIndex = '3';}) ();");
          _webViewController!.runJavascript(
              "javascript: (function() {var element = document.getElementById('ddlMode'); var event = new Event('change'); element.dispatchEvent(event);}) ();");
          step++;
        } else {
          if (step == 2) {
            _webViewController!.runJavascript(
                "javascript: (function() {for ( var i = 0; i < document.getElementById('ddlBank').options.length; i++ ) { " +
                    "if (document.getElementById('ddlBank').options[i].value == '" +
                    "ICI" +
                    "') {" +
                    " document.getElementById('ddlBank').options[i].selected = true;" +
                    "break;" +
                    "}}}) ();");
            _webViewController!.runJavascript(
                "javascript: (function() {var element = document.getElementById('ddlBank'); var event = new Event('change'); element.dispatchEvent(event);}) ();");
            step++;
          } else if (step == 3) {
            _webViewController!.runJavascript(
                "javascript: (function() {for ( var i = 0; i < document.getElementById('ddlAccNo').options.length; i++ ) { " +
                    "if (document.getElementById('ddlAccNo').options[i].value == '" +
                    "239001515561" +
                    "') {" +
                    " document.getElementById('ddlAccNo').options[i].selected = true;" +
                    "break;" +
                    "}}}) ();");
            _webViewController!.runJavascript(
                "javascript: (function() {var element = document.getElementById('ddlAccNo'); var event = new Event('change'); element.dispatchEvent(event);}) ();");
            step++;
          } else if (step == 4) {
            _webViewController!.runJavascript(
                "javascript: (function() {for ( var i = 0; i < document.getElementById('ddlMandateId').options.length; i++ ) { " +
                    "if (document.getElementById('ddlMandateId').options[i].value == '" +
                    "4297807" +
                    "') {" +
                    " document.getElementById('ddlMandateId').options[i].selected = true;" +
                    "break;" +
                    "}}}) ();");
            _webViewController!.runJavascript(
                "javascript: (function() {var element = document.getElementById('ddlMandateId'); var event = new Event('change'); element.dispatchEvent(event);}) ();");
            step++;
          } else if (step == 5) {
            _webViewController!.runJavascript(
                "javascript: (function() {document.getElementById('btnSend').click();}) ();");
            step++;
          }
        }
      }
    }
  }

  @override
  void initState() {}

  bool isCurrentUrlForFinalPage(String url) {
    if (url.contains("cashrich/jsp/bse_payment_success.jsp") ||
        url.contains("cashrich/jsp/bse_payment_pending.jsp")) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => InvestmentSummary()));
      return true;
    }
    return false;
  }

  getRequiredPage() {
    if (paymentType == 901 && page != null) {
      return Uri.dataFromString(page!, mimeType: 'text/html').toString();
    } else {
      return link;
    }
  }
}
