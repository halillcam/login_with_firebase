import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_with_firebase/core/auth/views/user_page.dart';

class PhoneVerify extends StatefulWidget {
  const PhoneVerify({super.key, required this.verficiationID});
  final String verficiationID;
  @override
  State<PhoneVerify> createState() => _PhoneVerifyState();
}

class _PhoneVerifyState extends State<PhoneVerify> {
  final TextEditingController _otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Card(
          child: SizedBox(
            width: 400,
            height: 350,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Enter your OTP code",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    keyboardType: TextInputType.phone,
                    controller: _otpController,
                    decoration: InputDecoration(
                      fillColor: Colors.grey,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        final cred = PhoneAuthProvider.credential(
                          verificationId: widget.verficiationID,
                          smsCode: _otpController.text,
                        );
                        await FirebaseAuth.instance.signInWithCredential(cred);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                UserPage(userName: "userName"),
                          ),
                        );
                      } catch (e) {
                        print(e.toString());
                      }
                    },
                    child: Text("Verify"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
