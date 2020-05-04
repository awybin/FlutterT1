import 'package:flutter/material.dart';
import 'package:flutter_t1/color_palette.dart';
import 'package:flutter_t1/graficos.dart';
import 'package:flutter_t1/introducao.dart';
import 'package:flutter_t1/survey_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Coronations',
      home: IntroductionPage(),
    );
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
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static final List<Widget> _widgetOptions = <Widget>[
    graphsView,
    survey,
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
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.graphic_eq),
            title: Text('Estatísticas'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text('Enquete'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: ColorPalette.secondaryBlue,
        onTap: _onItemTapped,
      ),
    );
  }
}
