import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_t1/google_map.dart';
import 'package:flutter_t1/graficos.dart';
import 'package:flutter_t1/introducao.dart';
import 'package:flutter_t1/localizations.dart';
import 'package:flutter_t1/survey_view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final AppLanguage appLanguage;

  MyApp({this.appLanguage});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppLanguage>(
        builder: (_) => appLanguage,
        child: Consumer<AppLanguage>(builder: (context, model, child) {
          return MaterialApp(
            //locale: model.appLocal,
            supportedLocales: [
              Locale('pt', ''),
              Locale('en', 'US'),
            ],
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            theme: new ThemeData(
                primarySwatch: Colors.blueAccent[300],
                primaryColor: Colors.blueAccent[300],
                buttonColor: Colors.blueAccent,
                backgroundColor: Colors.white,
                textTheme: new TextTheme(
                  headline: TextStyle(
                      fontFamily: 'Beattingvile',
                      fontSize: 70,
                      color: Colors.blueAccent),
                  button: TextStyle(fontSize: 18, color: Colors.white),
                  display1: TextStyle(
                    fontSize: 15,
                  ),
                  display2: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                    fontFamily: 'Quicksand',
                    fontWeight: FontWeight.w700,
                  ),
                  display3: TextStyle(
                    fontSize: 22,
                    color: Colors.black,
                    fontFamily: 'Quicksand',
                    fontWeight: FontWeight.w700,
                  ),
                  display4: TextStyle(
                      fontSize: 15,
                      fontFamily: 'Quicksand',
                      fontWeight: FontWeight.w700,
                      color: Colors.grey[600]),
                  body1: new TextStyle(fontSize: 18),
                  body2: new TextStyle(color: Colors.red),
                )),
            home: IntroductionPage(),
          );
        }));
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static final graphsView = GraphsView();
  static final survey = Survey();
  static final mapView = MapView();
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    graphsView,
    survey,
    mapView,
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _widgetOptions),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.graphic_eq),
            title: Text(AppLocalizations.of(context).translate('estatisticas')),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text(AppLocalizations.of(context).translate('enquete')),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            title: Text(AppLocalizations.of(context).translate('mapa')),
          ),
        ],
        currentIndex: _selectedIndex,
        //selectedItemColor: ColorPalette.secondaryBlue,
        onTap: _onItemTapped,
      ),
    );
  }
}

class AppLanguage extends ChangeNotifier {
  Locale _appLocale = Locale('pt');

  Locale get appLocal => _appLocale ?? Locale("pt");
  fetchLocale() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getString('language_code') == null) {
      _appLocale = Locale('pt');
      return Null;
    }
    _appLocale = Locale(prefs.getString('language_code'));
    return Null;
  }

  void changeLanguage(Locale type) async {
    var prefs = await SharedPreferences.getInstance();
    if (_appLocale == type) {
      return;
    }
    if (type == Locale("pt")) {
      _appLocale = Locale("pt");
      await prefs.setString('language_code', 'pt');
      await prefs.setString('countryCode', '');
    } else {
      _appLocale = Locale("en");
      await prefs.setString('language_code', 'en');
      await prefs.setString('countryCode', 'US');
    }
    notifyListeners();
  }
}
