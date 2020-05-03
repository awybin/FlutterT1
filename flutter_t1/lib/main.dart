import 'package:flutter/material.dart';
import 'package:flutter_t1/color_palette.dart';
import 'package:flutter_t1/graficos.dart';
import 'package:flutter_t1/pesquisa.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    GraficosMain(),
    App(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.graphic_eq),
            title: Text('Graficos'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text('Responder Pesquisa'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: ColorPalette.secondaryBlue,
        onTap: _onItemTapped,
      ),
    );
  }
}
