import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:hello/hello.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
  }


Map msg={};

  void openpay() async{
    Map<String, dynamic> options = new Map();
    options.putIfAbsent("amount", () => "100");
    Map<dynamic,dynamic> paymentResponse = new Map();

    try {
      paymentResponse = await Hello.showPaymentForm(options);
    } on PlatformException {
      paymentResponse = {"msg":"sas"};
    }

    setState(() {
      msg = paymentResponse;
    });



  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(children:[Text('Running on: $_platformVersion\n'),
          RaisedButton(child: Text("openRazorpay"),onPressed: (){
            openpay();
          },),

            Text(msg.toString())
          ]),
        ),
      ),
    );
  }
}
