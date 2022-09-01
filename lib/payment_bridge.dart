library payment_bridge;

import 'razorpay.dart';

abstract class PaymentBridgeGateway {
  Future<PaymentBridgeResponse> create({
    double amount = 0,
    String name = '',
    String description = '',
    String mobile = '',
    String email = '',
  });
}

abstract class PaymentBridgeResponse {
  Map get json;
}

class PaymentBridgeSuccess extends PaymentBridgeResponse {
  String? id;
  String? time;
  double? amount;
  String? status;
  String? orderId;
  String? signature;

  PaymentBridgeSuccess({
    this.id,
    this.time,
    this.amount,
    this.status,
    this.orderId,
    this.signature,
  });

  @override
  Map get json {
    return {
      'id': id,
      'time': time,
      'amount': amount,
      'status': status,
      'orderId': orderId,
      'signature': signature,
    };
  }
}

class PaymentBridgeError extends PaymentBridgeSuccess {
  int? code;
  String? message;

  PaymentBridgeError({
    this.code,
    this.message,
    String? id,
    String? time,
    double? amount,
    String? status,
    String? orderId,
    String? signature,
  }) : super(
          id: id,
          time: time,
          amount: amount,
          status: status,
          orderId: orderId,
          signature: signature,
        );

  @override
  Map get json {
    return {
      ...super.json,
      'code': code,
      'message': message,
    };
  }
}

class PaymentBridge {
  PaymentBridgeGateway? paymentGateway;

  PaymentBridge({Map? paytm, Map? razorpay, Map? paystack, Map? flutterwave}) {
    if (razorpay != null) {
      paymentGateway = PaymentBridgeGatewayRazorpay(razorpay);
    }
  }

  Future<PaymentBridgeResponse> create({
    double amount = 0,
    String name = '',
    String description = '',
    String mobile = '',
    String email = '',
  }) {
    if (paymentGateway != null) {
      return paymentGateway!.create(
        amount: amount,
        name: name,
        description: description,
        mobile: mobile,
        email: email,
      );
    }

    return Future.error(
      PaymentBridgeError(
        code: 0,
        message: 'NO_GATEWAY_REGISTERED',
      ),
    );
  }
}
