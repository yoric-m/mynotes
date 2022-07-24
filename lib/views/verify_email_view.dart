import 'package:flutter/material.dart';
import 'package:mynotes/services/auth/auth_service.dart';
import '../constants/routes.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({Key? key}) : super(key: key);

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verify email'),
      ),
      body: Column(
        children: [
          Text('We sent you an email verification.'),
          Text(
              'If you havent receive a verification email, please resend the verification email with the button below.'),
          TextButton(
            onPressed: () async {
              final user = AuthService.firebase().currentUser;
              await AuthService.firebase().sendEmailVerification();
            },
            child: Text('send email verification'),
          ),
          TextButton(
            onPressed: () async {
              await AuthService.firebase().logOut();
              Navigator.pushNamedAndRemoveUntil(
                  context, registerRoute, (route) => false);
            },
            child: Text('Restart'),
          ),
        ],
      ),
    );
  }
}
