import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gymratz/main.dart';
import 'package:gymratz/resources/gymratz_localizations.dart';

class DrawerMenu extends StatefulWidget {
  final BuildContext context;
  DrawerMenu({
    @required this.context,
  });

  @override
  State<StatefulWidget> createState() {
    return DrawerMenuState();
  }
}

class DrawerMenuState extends State<DrawerMenu> with WidgetsBindingObserver {
  FirebaseUser user;
  @override
  void initState() {
    super.initState();
    this.user = authAPI.user;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
            child: ListView(
      children: <Widget>[
        DrawerHeader(
          decoration: BoxDecoration(color: teal),
          child: user == null
              ? Container(
                  alignment: Alignment.centerLeft,
                  child: Text(GymratzLocalizations.of(context).text('Guest'),
                      style:
                          TextStyle(color: Colors.white, fontSize: headerFont)))
              : Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(user.displayName,
                        style: TextStyle(
                            color: Colors.white, fontSize: headerFont)),
                    Text(user.email,
                        style: TextStyle(
                            color: Colors.white, fontSize: subheaderFont)),
                  ],
                ),
        ),
        ListTile(
          leading: Icon(Icons.home),
          title: Text(GymratzLocalizations.of(context).text('Home'),
              style: TextStyle(fontSize: subheaderFont)),
          onTap: () {
            Navigator.pushNamed(context, '/');
          },
        ),
        ListTile(
          leading: Icon(Icons.search),
          title: Text(GymratzLocalizations.of(context).text('Search'),
              style: TextStyle(fontSize: subheaderFont)),
          onTap: () {
            Navigator.pushNamed(context, '/search');
          },
        ),
        ListTile(
          leading: Icon(Icons.person),
          title: Text(GymratzLocalizations.of(context).text('Profile'),
              style: TextStyle(fontSize: subheaderFont)),
          onTap: () {
            Navigator.pushNamed(context, '/profile');
          },
        ),
        ListTile(
          leading: Icon(Icons.star),
          title: Text('My Problems', style: TextStyle(fontSize: subheaderFont)),
          onTap: () {
            Navigator.pushNamed(context, '/myProblems');
          },
        ),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text(GymratzLocalizations.of(context).text('Settings'),
              style: TextStyle(fontSize: subheaderFont)),
          onTap: () {
            Navigator.pushNamed(context, '/settings');
          },
        ),
        ListTile(
          leading: Icon(Icons.verified_user),
          title: Text('Admin', style: TextStyle(fontSize: subheaderFont)),
          onTap: () {
            Navigator.pushNamed(context, '/admin');
          },
        ),
        (user == null)
            ? ListTile(
                leading: Icon(Icons.account_box),
                title: Text("Login", style: TextStyle(fontSize: subheaderFont)),
                onTap: () {
                  Navigator.of(context).pushNamed('/login');
                },
              )
            : ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text(GymratzLocalizations.of(context).text('LogOut'),
                    style: TextStyle(fontSize: subheaderFont)),
                onTap: () {
                  //TODO: clear information and kill authentication
                  authAPI.logout();
                  setState(() {
                    user = authAPI.user;
                  });
                  print('SET STATE');
                  print(user);
                  //Remove all routes in the stack so that user cannot go back to the previous routes after they have logged out.
                },
              ),
      ],
    )));
  }
}
