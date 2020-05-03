import 'package:flutter/material.dart';

import 'main.dart';

class IntroductionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(
                image: AssetImage('assets/images/creativity.gif'),
              ),
              Text(
                'fique em casa',
                style: TextStyle(
                    fontFamily: 'Beattingvile',
                    fontSize: 70,
                    color: Colors.blueAccent),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Text(
                  'Agora é a hora de ficar em casa e usar o tempo para evoluir, trabalhar o seu interior e sair dessa fase uma pessoa melhor!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 30.0),
                width: MediaQuery.of(context).size.width,
                child: FlatButton(
                  padding: EdgeInsets.all(15.0),
                  disabledColor: Colors.blueAccent,
                  child: Text(
                    'Ótima ideia!',
                    style: TextStyle(fontSize: 18.0, color: Colors.white),
                  ),
                  color: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(8.0),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(_createRoute());
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => MyHomePage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
