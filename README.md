Single package to manage payments from various proivders like RazorPay, Paytm


### Example

```dart
PaymentBridge paymentBridge = PaymentBridge(
    razorpay: {
        'key': 'rzp_live_########',
        'testKey': 'rzp_test_########',
    },
);

paymentBridge.create(
    amount: 100,
    name: 'Alice Bob',
    description: 'Registration Charges',
    mobile: '+919876543210',
    email: 'alice.bob@example.com',
).then((payment) async {
    // print(payment.json);
    // {
    //    'id': id,
    //    'time': time,
    //    'amount': amount,
    //    'status': status,
    //    'orderId': orderId,
    //    'signature': signature,
    // }
});
```

## Supported Providers

+ RazorPay : Android, iOS, MacOS, Web, Windows
+ Paytm : Under development
+ Stripe : Under development
