import 'package:charts_flutter/flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_t1/Model/corona_summary.dart';
import 'package:flutter_t1/repository/corona_repository.dart';
import 'package:intl/intl.dart';

import 'color_palette.dart';
import 'localizations.dart';

class GraphsView extends StatefulWidget {
  @override
  _GraphsViewState createState() => _GraphsViewState();
}

class _GraphsViewState extends State<GraphsView> {
  Future<CoronaSummary> summary;
  String selectedCountry = 'United States';
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
                      AppLocalizations.of(context).translate('estatisticas'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: FutureBuilder<CoronaSummary>(
                        future: summary,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            CountrySummary countryData =
                                CoronaRepository.getSummaryFor(snapshot.data,
                                    isGlobal ? 'Global' : selectedCountry);
                            countriesCodeList = CoronaRepository.countryCode;
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 25.0),
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    height: 230,
                                    child: Container(
                                      child: PieChart(
                                        _createSeriesFrom(snapshot.data),
                                        animate: true,
                                        defaultRenderer: ArcRendererConfig(
                                            arcWidth: 60,
                                            arcRendererDecorators: [
                                              new ArcLabelDecorator()
                                            ]),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            );
                          }
                          return CircularProgressIndicator();
                        },
                      ),
                    ),
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

  List<Series<CountrySummary, String>> _createSeriesFrom(CoronaSummary data) {
    var fmt = NumberFormat.compact(locale: 'pt-br');
    var top10 = data.countries.getRange(0, 10).toList(growable: false);
    top10.shuffle();
    return [
      new Series<CountrySummary, String>(
        id: 'Top 10',
        domainFn: (CountrySummary country, _) =>
            country.countryCode.toUpperCase(),
        measureFn: (CountrySummary country, _) => country.totalConfirmed,
        data: top10,
        labelAccessorFn: (CountrySummary country, _) =>
            '${country.countryCode.toUpperCase()} - ${fmt.format(country.totalConfirmed / data.global.totalConfirmed * 100)} %',
      )
    ];
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
