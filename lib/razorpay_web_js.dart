@JS() // Sets the context, which in this case is `window`
library main; // required library declaration called main, or whatever name you wish

import 'package:js/js.dart';

@JS()
@anonymous
class PaymentOptionsPrefill {
  external factory PaymentOptionsPrefill({contact, email});

  external String contact;
  external String email;
}

@JS()
@anonymous
class PaymentOptions {
  external factory PaymentOptions({key, amount, name, description, prefill});

  external String key;
  external double amount;
  external String name;
  external String description;
  external PaymentOptionsPrefill prefill;
}

@JS('Razorpay')
class Razorpay {
  external Razorpay(PaymentOptions options);

  external void open();
}

@JS('console.log')
external void log(PaymentOptions options);
