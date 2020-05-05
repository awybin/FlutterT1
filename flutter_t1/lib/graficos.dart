import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_t1/Model/corona_summary.dart';
import 'package:flutter_t1/repository/corona_repository.dart';
import 'package:intl/intl.dart';

import 'color_palette.dart';

class GraphsView extends StatefulWidget {
  @override
  _GraphsViewState createState() => _GraphsViewState();
}

class _GraphsViewState extends State<GraphsView> {
  Future<CoronaSummary> summary;
  String selectedCountry = 'United States of America';
  int selectedIndex = 0;
  Map<String, String> countriesCodeList;
  bool isGlobal = false;

  _updateSelected(index) {
    selectedIndex = index;
    selectedCountry = countriesCodeList.keys.toList()[index];
  }

  @override
  void initState() {
    super.initState();
    summary = CoronaRepository.fetchAlbum();
    countriesCodeList = CoronaRepository.countryCode;
  }

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
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      width: MediaQuery.of(context).size.width,
                      child: GestureDetector(
                        onDoubleTap: () {
                          setState(() {
                            isGlobal = !isGlobal;
                          });
                        },
                        child: FlatButton(
                          padding: EdgeInsets.all(10.0),
                          disabledColor: Colors.blueAccent,
                          child: Text(
                            isGlobal ? 'Global' : selectedCountry,
                            style: Theme.of(context).textTheme.button,
                          ),
                          color: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(8.0),
                          ),
                          onPressed: () {
                            showModalBottomSheet(
                                isDismissible: true,
                                context: context,
                                builder: (BuildContext builder) {
                                  return CupertinoPicker(
                                    scrollController:
                                        FixedExtentScrollController(
                                            initialItem: selectedIndex),
                                    magnification: 1,
                                    itemExtent: 40,
                                    children: <Widget>[
                                      for (var country
                                          in countriesCodeList.keys)
                                        Center(child: Text(country))
                                    ],
                                    onSelectedItemChanged: (index) {
                                      setState(() {
                                        _updateSelected(index);
                                      });
                                    },
                                  );
                                });
                          },
                        ),
                      ),
                    ),
                    Text(
                      'Estatísticas',
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: FutureBuilder<CoronaSummary>(
                        future: summary,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            CountrySummary countryData =
                                CoronaRepository.getSummaryFor(snapshot.data,
                                    isGlobal ? 'Global' : selectedCountry);
                            countriesCodeList = CoronaRepository.countryCode;
                            return Row(
                              children: <Widget>[
                                CasesCounter(
                                    type: 'confirmed',
                                    cases: countryData.totalConfirmed),
                                CasesCounter(
                                    type: 'recovered',
                                    cases: countryData.totalRecovered),
                                CasesCounter(
                                    type: 'fatal',
                                    cases: countryData.totalDeaths),
                              ],
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                            );
                          }
                          return CircularProgressIndicator();
                        },
                      ),
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
    'confirmed': 'YellowCorona.png',
    'recovered': 'GreenCorona.png',
    'fatal': 'RedCorona.png',
  };

  CasesCounter({this.type, this.cases});

  @override
  Widget build(BuildContext context) {
    var fmt = NumberFormat.compact();

    return Column(
      children: <Widget>[
        Image(
          image: AssetImage('assets/images/' + this._typeColor[type]),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            fmt.format(this.cases),
          ),
        ),
      ],
    );
  }
}
