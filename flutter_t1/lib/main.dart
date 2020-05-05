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
      theme: new ThemeData(
        primarySwatch: Colors.blueAccent[300],
        primaryColor: Colors.blueAccent[300],
        buttonColor: Colors.blueAccent,
        backgroundColor: Colors.white,
        textTheme: new TextTheme(
          headline: TextStyle(
            fontFamily: 'Beattingvile',
            fontSize: 70,
            color: Colors.blueAccent
          ),
          button: TextStyle(
            fontSize: 18,
            color: Colors.white
          ),
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
            color: Colors.grey[600]
          ),
          body1: new TextStyle(fontSize: 18),
          body2: new TextStyle(color: Colors.red),

        )
      ),
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
        //selectedItemColor: ColorPalette.secondaryBlue,
        onTap: _onItemTapped,
      ),
    );
  }
}
