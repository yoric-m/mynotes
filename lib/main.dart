import 'package:flutter/material.dart';
import 'package:mynotes/services/auth/auth_service.dart';
import 'package:mynotes/views/login_view.dart';
import 'firebase_options.dart';
import 'views/notes_view.dart';
import 'views/register_view.dart';
import 'views/verify_email_view.dart';
import 'dart:developer' as devtools show log;
import 'constants/routes.dart';
import 'services/auth/firebase_auth_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: const HomePage(),
    routes: {
      loginRoute: (context) => LoginView(),
      registerRoute: (context) => RegisterView(),
      notesRoute: (context) => NotesView(),
      verifyEmailRoute: (context) => VerifyEmailView(),
    },
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthService.firebase().initialize(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = AuthService.firebase().currentUser;
            if (user != null) {
              if (user.isEmailVerified) {
                return NotesView();
              } else {
                return VerifyEmailView();
              }

              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => const VerifyEmailView()));

            } else {
              return LoginView();
            }

          default:
            return CircularProgressIndicator();
        }
      },
    );
  }
}
