import 'package:flutter/material.dart';
import '../cookie_request.dart';
import 'package:provider/provider.dart';

class LogoutScreen extends StatelessWidget {
  const LogoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Covid-19 Panic Button'),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 48),
            const Text("Are you sure you want to log out?"),
            const SizedBox(height: 24),
            ElevatedButton(
              child: const Text("logout",
                  style: TextStyle(fontSize: 20, color: Colors.white)),
              onPressed: () {
                Provider.of<CookieRequest>(context, listen: false).logout();
                Navigator.of(context).pop();
              }
            )
          ],
        )
      )
    );
  }
}