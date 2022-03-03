library payment_bridge;

import 'razorpay.dart';

abstract class PaymentBridgeGateway {
  Future create(
      {double amount = 0,
      String name = '',
      String description = '',
      String mobile = '',
      String email = ''});
}

class PaymentBridgeSuccess {
  String? status;
  String? time;
  double? amount;
  String? id;
  String? orderId;
  String? signature;

  PaymentBridgeSuccess({
    this.amount,
    this.time,
    this.status,
    this.id,
    this.orderId,
    this.signature,
  });
}

class PaymentBridgeError {
  int? code;
  String? message;

  PaymentBridgeError({
    this.code,
    this.message,
  });
}

class PaymentBridge {
  PaymentBridgeGateway? paymentGateway;

  PaymentBridge({Map? paytm, Map? razorpay, Map? paystack, Map? flutterwave}) {
    if (razorpay != null) {
      paymentGateway = PaymentBridgeGatewayRazorpay(razorpay);
    }
  }

  Future create({
    double amount = 0,
    String name = '',
    String description = '',
    String mobile = '',
    String email = '',
  }) {
    if (paymentGateway != null) {
      paymentGateway?.create(
        amount: amount,
        name: name,
        description: description,
        mobile: mobile,
        email: email,
      );
    }
    return Future.value(12);
  }
}
