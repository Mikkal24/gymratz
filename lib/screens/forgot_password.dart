import 'package:flutter/material.dart';
import 'package:gymratz/main.dart';
import 'package:gymratz/resources/gymratz_localizations.dart';
import 'package:gymratz/resources/gymratz_localizations_delegate.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ForgotPasswordScreenState();
  }
}

class ForgotPasswordScreenState extends State<ForgotPasswordScreen>
    with WidgetsBindingObserver {
  final TextEditingController _emailCtrl = TextEditingController();
  GymratzLocalizationsDelegate _newLocaleDelegate;

  @override
  void initState() {
    super.initState();
    _newLocaleDelegate = GymratzLocalizationsDelegate(newLocale: null);
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _emailCtrl.dispose();
    super.dispose();
  }

  void sendEmail() {
    authAPI.sendPasResetEmail(_emailCtrl.text).then((msg) {
      print(msg);
      // todo KL: Alert that an email has been sent.
    });
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
                    GymratzLocalizations.of(context).text('ForgotPassword?'),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: subheaderFont,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 10.0),
                  child: Text(
                    GymratzLocalizations.of(context)
                        .text('EnterEmailToRecoverPassword'),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: bodyFont,
                    ),
                    textAlign: TextAlign.center,
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
                        onFieldSubmitted: (str) {
                          sendEmail();
                          Navigator.pushNamed(context, '/');
                        },
                        style: TextStyle(color: Colors.white),
                        validator: (val) {
                          return val.length < 10
                              ? GymratzLocalizations.of(context)
                                  .text('InvalidEmail')
                              : null;
                        },
                        decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: TextStyle(color: Colors.white),
                            enabledBorder: new UnderlineInputBorder(
                                borderSide:
                                    new BorderSide(color: Colors.white)),
                            focusedBorder: new UnderlineInputBorder(
                                borderSide:
                                    new BorderSide(color: Colors.white))),
                        textInputAction: TextInputAction.next,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 30.0),
                        width: double.infinity,
                        child: RaisedButton(
                          padding: const EdgeInsets.all(10.0),
                          onPressed: () {
                            sendEmail();
                            Navigator.pushNamed(context, '/');
                          },
                          color: Theme.of(context).primaryColor,
                          child: Text(
                              GymratzLocalizations.of(context).text('Send'),
                              style: TextStyle(
                                  color: Colors.white, fontSize: bodyFont)),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 30.0),
                        width: double.infinity,
                        child: RaisedButton(
                          padding: const EdgeInsets.all(10.0),
                          onPressed: () {
                            Navigator.pushNamed(context, '/');
                          },
                          color: Colors.grey,
                          child: Text(
                              GymratzLocalizations.of(context)
                                  .text('NeverMind'),
                              style: TextStyle(
                                  color: Colors.white, fontSize: bodyFont)),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
