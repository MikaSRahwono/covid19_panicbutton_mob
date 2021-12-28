import 'package:flutter/material.dart';
import '../screens/login.dart';
import '../screens/register.dart';
import '../screens/logout.dart';
import '../cookie_request.dart';
import 'package:provider/provider.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isLoggedIn = Provider.of<CookieRequest>(context).loggedIn;
    return Drawer(
      child: Container(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
        color: Color.fromRGBO(128, 128, 255, 1),
        child: ListView(
          children: <Widget> [
            const SizedBox(height: 24),
            const Center(
                child: Text("Drawer", style: TextStyle(fontSize: 25))),
            const SizedBox(height: 48),
            buildListTile("Login", !isLoggedIn, () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginScreen())
                );
              },
            ),
            SizedBox(height: !isLoggedIn ? 24 : 0),
            buildListTile("Register", !isLoggedIn, () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => RegisterScreen())
                );
              },
            ),
            SizedBox(height: !isLoggedIn ? 24 : 0),
            buildListTile("Log Out", isLoggedIn, () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LogoutScreen())
                );
              },
            ),
            SizedBox(height: isLoggedIn ? 24 : 0),
            buildListTile("Dummy1", true, () {
              Navigator.pop(context);
            }),
            const SizedBox(height: 24),
            buildListTile("Dummy2", true, () {
              Navigator.pop(context);
            }),
          ]
        )
      )
    );
  }

  Widget buildListTile(String title, bool enableFlag, Function() tapHandler) {
    if (enableFlag == false) {
      return SizedBox(height: 0);
    }

    return Material(
        child: ListTile(
          tileColor: Color.fromRGBO(160, 160, 255, 1),
          title: Text(
            title,
            style: TextStyle(
              fontFamily: 'RobotoCondensed',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: tapHandler,
        )
    );
  }
}
