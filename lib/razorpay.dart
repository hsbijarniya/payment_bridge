import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'payment_bridge.dart';
import 'razorpay_web.dart' as payment;

class PaymentBridgeGatewayRazorpay implements PaymentBridgeGateway {
  Map<String, dynamic> options = {
    'prefill': {},
  };

  PaymentBridgeGatewayRazorpay(Map opts) {
    options['key'] = opts['key'];

    // print('PaymentBridgeGatewayRazorpay constructor');

    if (kIsWeb) {
      var razorpay = payment.Razorpay();
      razorpay.init();
    }
  }

  @override
  Future<PaymentBridgeResponse> create({
    double amount = 0,
    String name = '',
    String description = '',
    String mobile = '',
    String email = '',
  }) {
    var completer = Completer<PaymentBridgeResponse>();

    options['amount'] = amount * 100;
    options['name'] = name;
    options['description'] = description;
    options['prefill']['contact'] = mobile;
    options['prefill']['email'] = email;

    if (kIsWeb) {
      var razorpay = payment.Razorpay();
      razorpay.open(options);
    } else {
      var razorpay = Razorpay();

      razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
          (PaymentSuccessResponse response) {
        completer.complete(PaymentBridgeSuccess(
          id: response.paymentId,
          amount: amount,
          orderId: response.orderId,
          signature: response.signature,
        ));
      });

      razorpay.on(Razorpay.EVENT_PAYMENT_ERROR,
          (PaymentFailureResponse response) {
        completer.completeError(PaymentBridgeError(
          code: response.code,
          message: response.message,
        ));
      });

      razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET,
          (ExternalWalletResponse response) {
        // Do something when an external wallet was selected
      });

      razorpay.open(options);
    }

    return completer.future;
  }
}
