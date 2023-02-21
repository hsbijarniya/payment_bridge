import 'package:payment_bridge/payment_bridge.dart';

PaymentBridge paymentBridge = PaymentBridge(
  razorpay: {
    'key': 'rzp_live_########',
    'testKey': 'rzp_test_########',
  },
);

sampleCode() {
  paymentBridge
      .create(
    amount: 100,
    name: 'Alice Bob',
    description: 'Registration Charges',
    mobile: '+919876543210',
    email: 'alice.bob@example.com',
  )
      .then((payment) async {
    // payment.json;
    // {
    //    'id': id,
    //    'time': time,
    //    'amount': amount,
    //    'status': status,
    //    'orderId': orderId,
    //    'signature': signature,
    // }
  });
}
