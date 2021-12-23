import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

import 'home_page.dart';

class FingerPrintAuthPage extends StatefulWidget {

  @override
  _FingerPrintAuthPageState createState() => _FingerPrintAuthPageState();
}

class _FingerPrintAuthPageState extends State<FingerPrintAuthPage> {

  LocalAuthentication auth = LocalAuthentication();
  late bool _canCheckBiometric;
  late List<BiometricType> _availableBiometric;
  String authorized = 'Not Authorized';

  Future<void> _checkBiometric() async {
    late bool canCheckBiometric;
    try {
      canCheckBiometric = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
    }
    if(!mounted) return;
    setState(() {
      _canCheckBiometric = canCheckBiometric;
    });
  }

  //check if we're allowed to check our biometric; get available biometric
  Future<void> _getAvailableBiometric() async {
    late List<BiometricType> availableBiometric;
    try{
      availableBiometric = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print(e);
    }
    setState(() {
      _availableBiometric = availableBiometric;
    });
  }

  // authentication
  Future<void> _authenticate() async{
    late bool authenticated = false;
    try {
      authenticated = await auth.authenticate(
          localizedReason: 'Scan your finger to authenticate',
          useErrorDialogs: true,
        stickyAuth: false
      );
    } on PlatformException catch (e) {
      print(e);
    }

    if(!mounted) return;
    setState(() {
      authorized = authenticated ? 'Authorized success' : 'Failed to authenticate';
      if(authenticated) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
      }
      print(authorized);
    });
  }

  @override
  void initState() {
    _checkBiometric();
    _getAvailableBiometric();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: Color(0xFF3C3E52),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: ElevatedButton.icon(
                  onPressed: _authenticate,
                  icon: const Icon(Icons.fingerprint_sharp, color: Colors.black,),
                  label: const Text('FingerPrint', style: TextStyle(color: Colors.black),),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
    );
  }
}
