

// ignore_for_file: avoid_print, prefer_function_declarations_over_variables, prefer_const_constructors, prefer_final_fields, use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class OTPScreen extends StatefulWidget {
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _otpController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  String _verificationId = '';

  Future<void> verifyPhone() async {
    try {
      PhoneVerificationCompleted verificationCompleted =
          (PhoneAuthCredential phoneAuthCredential) async {
        await _auth.signInWithCredential(phoneAuthCredential);
        print("Phone number automatically verified: ${_auth.currentUser!.phoneNumber}");
      };

      PhoneVerificationFailed verificationFailed =
          (FirebaseAuthException authException) {
        print('Phone number verification failed: ${authException.message}');
      };

      PhoneCodeSent codeSent =
          (String verificationId, int? resendToken) async {
        setState(() {
          _verificationId = verificationId;
        });
        print('OTP sent to ${_phoneNumberController.text}');
      };

      PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
          (String verificationId) {
        setState(() {
          _verificationId = verificationId;
        });
        print("Time out");
      };

      await _auth.verifyPhoneNumber(
        phoneNumber: '+91${_phoneNumberController.text}',
        timeout: Duration(seconds: 60),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
      );
    } catch (e) {
      print('Error: $e');
    }
  }

  void signInWithOTP() async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: _otpController.text,
      );
      await _auth.signInWithCredential(credential);
      print('OTP Verified: ${_auth.currentUser!.uid}');
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase OTP Auth'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _phoneNumberController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(labelText: 'Enter Phone Number'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async{
                await verifyPhone();
                Map<String,dynamic> data = {
                  "verificationId":_verificationId,
                  "phoneNumber":_phoneNumberController.text
                };
                Navigator.pushNamed(context, '/otpInputScreen',arguments: data);
              },
              child: Text('Send OTP'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _otpController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Enter OTP'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: signInWithOTP,
              child: Text('Verify OTP'),
            ),
          ],
        ),
      ),
    );
  }
}
 