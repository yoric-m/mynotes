import 'package:flutter/material.dart';
import 'package:mynotes/services/auth/auth_service.dart';
import '../constants/routes.dart';
import '../enums/menu_action.dart';

class NotesView extends StatefulWidget {
  const NotesView({Key? key}) : super(key: key);

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main UI'),
        actions: [
          PopupMenuButton<MenuAction>(
            onSelected: (value) async {
              switch (value) {
                case MenuAction.logout:
                  final shouldLogout = await showLogOutDialog(context);
                  if (shouldLogout) {
                    await AuthService.firebase().logOut();
                    Navigator.restorablePushNamedAndRemoveUntil(
                        context, loginRoute, (route) => false);
                  }
                  break;
              }
            },
            itemBuilder: (context) {
              return [
                PopupMenuItem<MenuAction>(
                  value: MenuAction.logout,
                  child: Text('Log out'),
                )
              ];
            },
          ),
        ],
      ),
    );
  }
}

Future<bool> showLogOutDialog(BuildContext context) {
  return showDialog<bool>(
      context: context,
      builder: ((context) {
        return AlertDialog(
          title: Text('Log out'),
          content: Text('Are you sure you want to log out?'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context, false);
                },
                child: Text('Cancel')),
            TextButton(
                onPressed: () {
                  Navigator.pop(context, true);
                },
                child: Text('Log out')),
          ],
        );
      })).then((value) => value ?? false);
}
