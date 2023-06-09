// ignore_for_file: deprecated_member_use
/*
import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_braintree/flutter_braintree.dart';
import 'package:get/get.dart';
import 'package:pay/pay.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'package:weight_loser/Model/SignupBody.dart';
import 'package:weight_loser/Service/Responsive.dart';
import 'package:weight_loser/Service/paymentService.dart';
import 'package:weight_loser/screens/Bottom_Navigation/bottom_bar.dart';
import 'package:weight_loser/screens/auth/signup.dart';
import 'package:weight_loser/screens/card_information.dart';
import 'package:weight_loser/widget/SideMenu.dart';

import 'Bottom_Navigation/bottom.dart';

class ChooseMethodTest extends StatefulWidget {
  ChooseMethodTest({Key key, this.signUpBody}) : super(key: key);
  SignUpBody signUpBody;

  @override
  _ChooseMethodTestState createState() => _ChooseMethodTestState();
}

class _ChooseMethodTestState extends State<ChooseMethodTest> {
  SharedPreferences prefs;

  Token _paymentToken;
  PaymentMethod _paymentMethod;
  String _error;
  final String _currentSecret =
      "sk_test_51LBcCuHHHtu1VEhSwLnlDPyPcs7Fn5fmfu5ydHTnYqa7ZgaUwyeQFrPC0ZNHE20zOaWq9l6B2hkBSoSmoZvhLEBP00jXNKeD52"; //set this yourself, e.g using curl
  PaymentIntentResult _paymentIntent;
  Source _source;

  ScrollController _controller = ScrollController();

  final CreditCard testCard = CreditCard(
    number: '4111111111111111',
    expMonth: 08,
    expYear: 22,
  );

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  initState() {
    super.initState();

    StripePayment.setOptions(StripeOptions(
        publishableKey:
            "pk_test_51LBcCuHHHtu1VEhSRmHtY2Pj4IofwmJGKnmStq2SaXRgGH4WY5iQV56vJ5ogT4kYhU9QNxsQYWY9BVihIWYhZ68e00AivGV9LD",
        merchantId: "acct_1LBcCuHHHtu1VEhS",
        androidPayMode: 'test'));
  }

  void setError(dynamic error) {
    _scaffoldKey.currentState
        .showSnackBar(SnackBar(content: Text(error.toString())));
    setState(() {
      _error = error.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      key: _scaffoldKey,
      appBar: new AppBar(
        title: new Text(
          'Stripe Payment Demo',
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              setState(() {
                _source = null;
                _paymentIntent = null;
                _paymentMethod = null;
                _paymentToken = null;
              });
            },
          )
        ],
      ),
      body: ListView(
        controller: _controller,
        padding: const EdgeInsets.all(20),
        children: <Widget>[
          RaisedButton(
            child: Text("Create Source"),
            onPressed: () {
              StripePayment.createSourceWithParams(SourceParams(
                type: 'ideal',
                amount: 2102,
                currency: 'eur',
                returnURL: 'example://stripe-redirect',
              )).then((source) {
                _scaffoldKey.currentState.showSnackBar(
                    SnackBar(content: Text('Received ${source.sourceId}')));
                setState(() {
                  _source = source;
                });
              }).catchError(setError);
            },
          ),
          Divider(),
          RaisedButton(
            child: Text("Create Token with Card Form"),
            onPressed: () {
              StripePayment.paymentRequestWithCardForm(CardFormPaymentRequest())
                  .then((paymentMethod) {
                _scaffoldKey.currentState.showSnackBar(
                    SnackBar(content: Text('Received ${paymentMethod.id}')));
                setState(() {
                  _paymentMethod = paymentMethod;
                });
              }).catchError(setError);
            },
          ),
          RaisedButton(
            child: Text("Create Token with Card"),
            onPressed: () {
              StripePayment.createTokenWithCard(
                testCard,
              ).then((token) {
                _scaffoldKey.currentState.showSnackBar(
                    SnackBar(content: Text('Received ${token.tokenId}')));
                setState(() {
                  _paymentToken = token;
                });
              }).catchError(setError);
            },
          ),
          Divider(),
          RaisedButton(
            child: Text("Create Payment Method with Card"),
            onPressed: () {
              StripePayment.createPaymentMethod(
                PaymentMethodRequest(
                  card: testCard,
                ),
              ).then((paymentMethod) {
                _scaffoldKey.currentState.showSnackBar(
                    SnackBar(content: Text('Received ${paymentMethod.id}')));
                setState(() {
                  _paymentMethod = paymentMethod;
                });
              }).catchError(setError);
            },
          ),
          RaisedButton(
            child: Text("Create Payment Method with existing token"),
            onPressed: _paymentToken == null
                ? null
                : () {
                    StripePayment.createPaymentMethod(
                      PaymentMethodRequest(
                        card: CreditCard(
                          token: _paymentToken.tokenId,
                        ),
                      ),
                    ).then((paymentMethod) {
                      _scaffoldKey.currentState.showSnackBar(SnackBar(
                          content: Text('Received ${paymentMethod.id}')));
                      setState(() {
                        _paymentMethod = paymentMethod;
                      });
                    }).catchError(setError);
                  },
          ),
          Divider(),
          RaisedButton(
            child: Text("Confirm Payment Intent"),
            onPressed: _paymentMethod == null || _currentSecret == null
                ? null
                : () {
                    StripePayment.confirmPaymentIntent(
                      PaymentIntent(
                        clientSecret: _currentSecret,
                        paymentMethodId: _paymentMethod.id,
                      ),
                    ).then((paymentIntent) {
                      _scaffoldKey.currentState.showSnackBar(SnackBar(
                          content: Text(
                              'Received ${paymentIntent.paymentIntentId}')));
                      setState(() {
                        _paymentIntent = paymentIntent;
                      });
                    }).catchError(setError);
                  },
          ),
          RaisedButton(
            child: Text("Authenticate Payment Intent"),
            onPressed: _currentSecret == null
                ? null
                : () {
                    StripePayment.authenticatePaymentIntent(
                            clientSecret: _currentSecret)
                        .then((paymentIntent) {
                      _scaffoldKey.currentState.showSnackBar(SnackBar(
                          content: Text(
                              'Received ${paymentIntent.paymentIntentId}')));
                      setState(() {
                        _paymentIntent = paymentIntent;
                      });
                    }).catchError(setError);
                  },
          ),
          Divider(),
          RaisedButton(
            child: Text("Native payment"),
            onPressed: () {
              if (Platform.isIOS) {
                _controller.jumpTo(450);
              }
              StripePayment.paymentRequestWithNativePay(
                androidPayOptions: AndroidPayPaymentRequest(
                  totalPrice: "2.40",
                  currencyCode: "EUR",
                ),
                applePayOptions: ApplePayPaymentOptions(
                  countryCode: 'DE',
                  currencyCode: 'EUR',
                  items: [
                    ApplePayItem(
                      label: 'Test',
                      amount: '27',
                    )
                  ],
                ),
              ).then((token) {
                setState(() {
                  _scaffoldKey.currentState.showSnackBar(
                      SnackBar(content: Text('Received ${token.tokenId}')));
                  _paymentToken = token;
                });
              }).catchError(setError);
            },
          ),
          RaisedButton(
            child: Text("Complete Native Payment"),
            onPressed: () {
              StripePayment.completeNativePayRequest().then((_) {
                _scaffoldKey.currentState.showSnackBar(
                    SnackBar(content: Text('Completed successfully')));
              }).catchError(setError);
            },
          ),
          Divider(),
          Text('Current source:'),
          Text(
            JsonEncoder.withIndent('  ').convert(_source?.toJson() ?? {}),
            style: TextStyle(fontFamily: "Monospace"),
          ),
          Divider(),
          Text('Current token:'),
          Text(
            JsonEncoder.withIndent('  ').convert(_paymentToken?.toJson() ?? {}),
            style: TextStyle(fontFamily: "Monospace"),
          ),
          Divider(),
          Text('Current payment method:'),
          Text(
            JsonEncoder.withIndent('  ')
                .convert(_paymentMethod?.toJson() ?? {}),
            style: TextStyle(fontFamily: "Monospace"),
          ),
          Divider(),
          Text('Current payment intent:'),
          Text(
            JsonEncoder.withIndent('  ')
                .convert(_paymentIntent?.toJson() ?? {}),
            style: TextStyle(fontFamily: "Monospace"),
          ),
          Divider(),
          Text('Current error: $_error'),
        ],
      ),
    );
  }
}
*/