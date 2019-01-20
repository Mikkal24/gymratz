import 'package:flutter/material.dart';
import 'package:gymratz/main.dart';
import 'package:gymratz/application.dart';
import 'package:gymratz/resources/gymratz_localizations.dart';
import 'package:gymratz/resources/gymratz_localizations_delegate.dart';

class LoginScreen extends StatefulWidget {
  // Component ID Keys
  static final Key signUpButtonKey = new Key('signUpButton');
  @override
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> with WidgetsBindingObserver {
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _pwdCtrl = TextEditingController();
  FocusNode _userFocusNode;
  FocusNode _passwordFocusNode;

  bool _pwdHidden = true;
  GymratzLocalizationsDelegate _newLocaleDelegate;

  @override
  void initState() {
    super.initState();
    _newLocaleDelegate = GymratzLocalizationsDelegate(newLocale: null);
    application.onLocaleChanged = onLocaleChange;
    WidgetsBinding.instance.addObserver(this);
    _userFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _userFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: null,
        body: SafeArea(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/mainImage.jpg'),
                    fit: BoxFit.cover,
                    alignment: FractionalOffset(0.6, 0.0))),
            child: ListView(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 100.0),
                  child: Text(
                    GymratzLocalizations.of(context).text('gymratz'),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 50.0,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: _emailCtrl,
                        keyboardType: TextInputType.emailAddress,
                        textCapitalization: TextCapitalization.none,
                        autocorrect: false,
                        focusNode: _userFocusNode,
                        onFieldSubmitted: (str) {
                          _userFocusNode.unfocus();
                          FocusScope.of(context)
                              .requestFocus(_passwordFocusNode);
                        },
                        style: TextStyle(color: Colors.white),
                        validator: (val) {
                          return val.length < 10 ? GymratzLocalizations.of(context).text('InvalidEmail') : null;
                        },
                        decoration: InputDecoration(
                            labelText: GymratzLocalizations.of(context).text('Email'),
                            labelStyle: TextStyle(color: Colors.white),
                            enabledBorder: new UnderlineInputBorder(
                                borderSide:
                                    new BorderSide(color: Colors.white)),
                            focusedBorder: new UnderlineInputBorder(
                                borderSide:
                                    new BorderSide(color: Colors.white))),
                        textInputAction: TextInputAction.next,
                      ),
                      Stack(
                        children: <Widget>[
                          TextFormField(
                            controller: _pwdCtrl,
                            obscureText: _pwdHidden,
                            textCapitalization: TextCapitalization.none,
                            autocorrect: false,
                            focusNode: _passwordFocusNode,
                            style: TextStyle(color: Colors.white),
                            // onFieldSubmitted: onSubmitted,
                            decoration: InputDecoration(
                                labelText: GymratzLocalizations.of(context).text('Password'),
                                labelStyle: TextStyle(color: Colors.white),
                                enabledBorder: new UnderlineInputBorder(
                                    borderSide:
                                        new BorderSide(color: Colors.white)),
                                focusedBorder: new UnderlineInputBorder(
                                    borderSide:
                                        new BorderSide(color: Colors.white))),
                            textInputAction: TextInputAction.go,
                          ),
                          Container(
                            padding: const EdgeInsets.only(top: 15.0),
                            alignment: FractionalOffset.bottomRight,
                            child: IconButton(
                                icon: Icon(
                                  _pwdHidden
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _pwdHidden = !_pwdHidden;
                                  });
                                }),
                          )
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        alignment: Alignment.bottomRight,
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/forgotPassword');
                          },
                          child: Text(GymratzLocalizations.of(context).text('ForgotPassword?'),
                              style: TextStyle(
                                  color: Colors.white, fontSize: xsFont)),
                        ),
                      ),
                      Container(
                          height: MediaQuery.of(context).size.height * 0.25,
                          margin: const EdgeInsets.only(top: 10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: double.infinity,
                                child: RaisedButton(
                                  padding: const EdgeInsets.all(10.0),
                                  onPressed: () {
                                    //TODO: navigate to home page after authenticating
                                    authAPI
                                        .handleSignIn(
                                            _emailCtrl.text, _pwdCtrl.text)
                                        .then((user) {
                                      Navigator.pushNamed(context, '/home');
                                    });
                                  },
                                  color: Theme.of(context).primaryColor,
                                  child: Text(GymratzLocalizations.of(context).text('LogIn'),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: smallFont)),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                child: InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(context, '/register');
                                    },
                                    key: LoginScreen.signUpButtonKey,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(GymratzLocalizations.of(context).text('DontHaveAnAccount?'),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: xsFont)),
                                        Text(' ' + GymratzLocalizations.of(context).text('SignUp!'),
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .accentColor)),
                                      ],
                                    )),
                              ),
                              Container(
                                width: double.infinity,
                                child: RaisedButton(
                                  padding: const EdgeInsets.all(10.0),
                                  onPressed: () {
                                    // TODO: If (first time signed in) {
                                    //   register anonymously
                                    // } else {
                                    //   look at phone storage for anonymous user id;
                                    // }
                                    // authAPI.registerAnonymous().then((user) {
                                    //   print(user.uid);
                                      //save UID to phone storage so you can sign in with same
                                      // guest account.
                                      Navigator.pushNamed(context, '/home');
                                    // });
                                  },
                                  color: Colors.grey,
                                  child: Text(GymratzLocalizations.of(context).text('ContinueAsGuest'),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: smallFont)),
                                ),
                              ),
                            ],
                          ))
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
  void onLocaleChange(Locale locale) {
    setState(() {
      _newLocaleDelegate = GymratzLocalizationsDelegate(newLocale: locale);
    });
  }
}
