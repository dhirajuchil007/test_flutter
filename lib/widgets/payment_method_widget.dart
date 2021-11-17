import 'package:flutter/material.dart';
import 'package:test_flutter/models/payment_method_model.dart';

class PaymentMethod extends StatelessWidget {
  final PaymentMethodModel paymentMethodModel;

  const PaymentMethod({Key? key, required this.paymentMethodModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: isMethodSelected(),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Text(
              paymentMethodModel.name,
            ),
            Text(paymentMethodModel.bank)
          ],
        ),
      ),
    );
  }

  Color isMethodSelected() {
    if (paymentMethodModel.isEnabled) {
      return Colors.green;
    } else {
      return Colors.white;
    }
  }
}
