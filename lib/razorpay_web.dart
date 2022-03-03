import 'dart:html';
import 'dart:js_util';
import 'payment_bridge.dart';

class Razorpay {
  void init() {
    ScriptElement customCode = ScriptElement();

    customCode.innerText = '''
        function loadRazorpay(details) {
          var rzp = new Razorpay(details);

          rzp.on('payment.error', (error) => {
            window.postMessage({
              error: {
                code: response.error.code,
                description: response.error.description,
                source: response.error.source,
                step: response.error.step,
                reason: response.error.reason,
                metadata: response.error.metadata
              }
            });
          });

          rzp.open();
        };

        window.addEventListener('PaymentBridge.razorpay.open', (ev) => {

          ev.detail.handler = (response) => {
            window.postMessage({
              success: {
                id: response.razorpay_payment_id,
                orderId: response.razorpay_order_id,
                signature: response.razorpay_signature
              }
            });
          };

          loadRazorpay(ev.detail);
        });
      ''';

    querySelector('head')?.append(customCode);

    window.onMessage.listen((MessageEvent ev) {
      if (ev.data['success'] != null) {
        PaymentBridgeSuccess(
          id: ev.data['success']['id'],
          orderId: ev.data['success']['orderId'],
          signature: ev.data['success']['signature'],
        );
      }

      if (ev.data['error'] != null) {
        PaymentBridgeError(
          code: ev.data['error']['code'],
          message: ev.data['error']['message'],
        );
      }
    });
  }

  open(Map<String, dynamic> options) {
    window.dispatchEvent(CustomEvent(
      'PaymentBridge.razorpay.open',
      detail: options,
    ));
  }
}
