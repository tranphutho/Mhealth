import 'dart:async';
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:singleclinic/main.dart';
import 'package:singleclinic/screens/LoginScreen.dart';
import 'package:singleclinic/screens/home/HomeScreen.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/splashScreen';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String token = "";

  @override
  void initState() {
    super.initState();
    openHomeScreen();
  }

  openHomeScreen() async {
    // TODO
    token = await FirebaseMessaging.instance.getToken();
    SharedPreferences.getInstance().then((value) async {

      final response =
      await post(Uri.parse("$SERVER_ADDRESS/api/savetoken"), body: {
        "token": token,
        "type": "1",
      });

      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200 ) {
        final jsonResponse = jsonDecode(response.body);
        print(jsonResponse);

        if( jsonResponse['status'] == 1){
          value.setBool("isTokenExist", true);
          Timer(Duration(seconds: 3), () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => RootScreen()),
            );
          });
        }

      }
      else{
        Timer(Duration(seconds: 3), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
        });
      }
      // if (value.getBool("isLoggedIn")??false) {
      //   Timer(Duration(seconds: 3), () {
      //     Navigator.pushReplacement(
      //       context,
      //       MaterialPageRoute(builder: (context) => RootScreen()),
      //     );
      //   });
      // } else {
      //
      //
      //   Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(builder: (context) => LoginScreen()),
      //   );
      //
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NAVY_BLUE,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: FittedBox(child: Image.asset('assets/splashScreen/splash.jpg'),
    fit: BoxFit.cover)
    ));
  }
}
