import 'package:flutter/material.dart';

import 'localizations.dart';
import 'main.dart';

class IntroductionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(
                image: AssetImage('assets/images/creativityGuy.png'),
              ),
              Text(
                AppLocalizations.of(context).translate('fiqueEmCasa'),
                style: Theme.of(context).textTheme.headline,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Text(
                  AppLocalizations.of(context).translate('fraseIntroducao'),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 30.0),
                width: MediaQuery.of(context).size.width,
                child: FlatButton(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    AppLocalizations.of(context).translate('introducaoOK'),
                    style: Theme.of(context).textTheme.button,
                  ),
                  color: Theme.of(context).buttonColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(8.0),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(_createRoute());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => HomePage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
