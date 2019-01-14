import 'package:flutter/material.dart';
import 'package:gymratz/main.dart';
import 'package:gymratz/widgets/account_needed.dart';
import 'package:gymratz/widgets/app_bar.dart';
import 'package:gymratz/widgets/drawer.dart';

class MyGymsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyGymsScreenState();
  }
}

class MyGymsScreenState extends State<MyGymsScreen> {
  var currentUser;
  bool auth = false;

  void checkForToken() {
    authAPI.getAuthenticatedUser().then((user) {
      if (user != null) {
        if (!user.isAnonymous) {
          setState(() {
            auth = true;
            currentUser = user;
          });
        } else {
          setState(() {
            currentUser = 'Guest User';
          });
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    checkForToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(context),
        drawer: drawerMenu(context, currentUser),
        body: SafeArea(
            child: auth
                ? Container(child: Text('my gyms'))
                : accountNeeded(context)));
  }
}
