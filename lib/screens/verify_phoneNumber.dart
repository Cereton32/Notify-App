import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_pratice/screens/post_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:velocity_x/velocity_x.dart';
import '../components/round_button.dart';
import '../components/scaffold_massenser.dat.dart';

class VerifyOtp extends StatefulWidget {
  final String verificationId;

  const VerifyOtp({super.key, required this.verificationId});

  @override
  State<VerifyOtp> createState() => _VerifyOtpState();
}

class _VerifyOtpState extends State<VerifyOtp> {
  final TextEditingController otpController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  void _verifyOtp() async {
    String otp = otpController.text;
    if (otp.isNotEmpty) {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: otp,
      );
      try {
        await _auth.signInWithCredential(credential);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
        Fluttertoast.showToast(
          msg: "Phone number verified",

          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
      } catch (error) {
        Fluttertoast.showToast(
          msg: "Error: ${error.toString()}",

          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    } else {
      Fluttertoast.showToast(
        msg: "Please enter OTP",

        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verify OTP'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: otpController,
              decoration: InputDecoration(
                labelText: 'Enter OTP',
                border: OutlineInputBorder(
                  borderSide: BorderSide(),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            RoundButton(
              name: 'Verify',
              ontap: _verifyOtp,
            ),
          ],
        ),
      ),
    );
  }
}
