import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'color_palette.dart';

class GraficosMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorPalette.backgroundRed,
        body: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 250),
              decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(30.0),
                  topRight: const Radius.circular(30.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 20.0),
                      width: MediaQuery.of(context).size.width,
                      child: FlatButton(
                        padding: EdgeInsets.all(10.0),
                        disabledColor: Colors.blueAccent,
                        child: Text(
                          'Brasil',
                          style: TextStyle(fontSize: 18.0, color: Colors.white),
                        ),
                        color: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(8.0),
                        ),
                        onPressed: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (BuildContext builder) {
                                return CupertinoPicker(
                                  magnification: 1,
                                  itemExtent: 40,
                                  children: <Widget>[
                                    Center(child: Text('Brasil')),
                                    Center(child: Text('Estados Unidos'))
                                  ],
                                );
                              });
                        },
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        CasesCounter(type: 'recovered', cases: 35935),
                        CasesCounter(type: 'active', cases: 45412),
                        CasesCounter(type: 'fatal', cases: 6017)
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 40.0),
              child: Image(
                image: AssetImage('assets/images/GirlReading.png'),
              ),
            )
          ],
        ));
  }
}

class CasesCounter extends StatelessWidget {
  final String type;
  final int cases;

  final _typeColor = {
    'active': 'YellowCorona.png',
    'recovered': 'GreenCorona.png',
    'fatal': 'RedCorona.png',
  };

  CasesCounter({this.type, this.cases});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Image(
          image: AssetImage('assets/images/' + this._typeColor[type]),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            this.cases.toString(),
            style: TextStyle(fontSize: 18),
          ),
        ),
      ],
    );
  }
}
