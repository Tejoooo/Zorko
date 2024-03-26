// ignore_for_file: avoid_print, prefer_function_declarations_over_variables, prefer_const_constructors, prefer_final_fields, use_key_in_widget_constructors, library_private_types_in_public_api, use_build_context_synchronously, file_names, prefer_const_literals_to_create_immutables
// ignore_for_file: avoid_print, prefer_function_declarations_over_variables, prefer_const_constructors, prefer_final_fields, use_key_in_widget_constructors, library_private_types_in_public_api, use_build_context_synchronously, file_names

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zorko/components/snackBar.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _phoneNumberController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  String _verificationId = '';
  TextEditingController countryController = TextEditingController();

  Future<void> verifyPhone() async {
    try {
      PhoneVerificationCompleted verificationCompleted =
          (PhoneAuthCredential phoneAuthCredential) async {
        await _auth.signInWithCredential(phoneAuthCredential);
        print(
            "Phone number automatically verified: ${_auth.currentUser!.phoneNumber}");
      };

      PhoneVerificationFailed verificationFailed =
          (FirebaseAuthException authException) {
        print('Phone number verification failed: ${authException.message}');
      };

      PhoneCodeSent codeSent = (String verificationId, int? resendToken) async {
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

  @override
  Widget build(BuildContext context) {
    countryController.text = "+91";
    bool _showErrorMessage = false;
    return Scaffold(
      extendBodyBehindAppBar: true,
      // backgroundColor: [Color(0xFFFFCE92), Color(0xFFED8F03)],
      appBar: AppBar(
        // title: Text('Firebase OTP Auth'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context)
                .pop(); // Navigate back when the button is pressed
          },
        ),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned(
              top: -270, // Move the circle up by adjusting this value
              left: -100, // Optional: Adjust left position if needed
              child: Container(
                width: 600, // Adjust width of the circle if needed
                height: 600, // Adjust height of the circle if needed
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [Color(0xFFFFCE92), Color(0xFFED8F03)],
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 100,
                    ),
                    // SizedBox(
                    //     height: 80,
                    //   ),
                    Container(
                      decoration: BoxDecoration(),
                      child: Image.asset('assets/h19.jpg'),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 55,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: 40,
                            child: TextField(
                              controller: countryController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          Text(
                            "|",
                            style: TextStyle(fontSize: 33, color: Colors.grey),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: TextField(
                            keyboardType: TextInputType.phone,
                            controller: _phoneNumberController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Phone Number",
                            ),
                            onChanged: (text) {
                              setState(() {
                                _showErrorMessage = text.isEmpty;
                              });
                            },
                          )),
                          
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFEF7931),
                          padding: EdgeInsets.all(15.0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      onPressed: () async {
                        if (_phoneNumberController.text.isEmpty || _phoneNumberController.text.length < 10) {
                          ErrorSnackBar(context, 'Enter valid phone number');
                          return;
                        }
                        await verifyPhone();
                        Map<String, dynamic> data = {
                          "verificationId": _verificationId,
                          "phoneNumber": _phoneNumberController.text
                        };
                        Navigator.pushNamed(context, '/otpscreen',
                            arguments: data);
                      },
                      child: Text(
                        'SEND OTP',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
