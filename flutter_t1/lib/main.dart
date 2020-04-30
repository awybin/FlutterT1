import 'package:flutter/material.dart';
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
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            new CardMenu(
              color: Colors.blue,
              title: "Pesquisa",
              icon: Icons.search,
              nextScreen: PesquisaMain(),
            ),
            new CardMenu(
              color: Colors.blue,
              title: "Graficos",
              icon: Icons.graphic_eq,
              nextScreen: GraficosMain(),
            )
          ],
        ),
      ),
    );
  }
}


class CardMenu extends StatelessWidget{

  CardMenu({
    Key key, 
    String this.title,
    IconData this.icon,
    MaterialColor this.color,
    Widget this.nextScreen,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final MaterialColor color;
  final Widget nextScreen;
  
  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 100,
      child: Card(
        color: color,
        child: Center(
          child: ListTile(
            leading: Icon(icon),
            title: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20.0,
              ),
            ),
            onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => nextScreen),
            );
          },
          ),
        )
      )
    );
  }
}