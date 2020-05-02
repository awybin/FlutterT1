import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.orangeAccent),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() {
    // TODO: implement createState
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  AnimationController _firstAnimationController;
  AnimationController _perguntaSingleController;
  AnimationController _perguntaMultController;

  int curIndex = 0;

  List<Pergunta> perguntas = [
    Pergunta(
      "Você teve febre nos ultimos 10 dias (Temperatura igual ou superior a 38º)?",
      ["Sim", "Não" ]
    ),
    Pergunta(
      "Apresentou algum desses sintomas?",
      ["Tosse", "Dor de garganta", "Coriza/ Nariz Entupido", "Dores no corpo/mialgia", "Náuseas/ Vomitos", 
      "Diarreia", "Perda de Olfato (cheiro) e/ ou paladar (gosto)", "Falta de ar / Dificuldade de respirar", 
      "Nenhum dos anteriores"]
    ),
    Pergunta(
      "É portador de alguma doença crônica?",
      ["Doença cardiovascular", "Doença pulmonar", "Diabetes", "Obesidade", "Cirrose", "Neoplasia em tratamento", 
      "Insuficiência renal", "Hepatopatia", "Transplantados", "Faz uso de algum tratamento imunosupressor", 
      "Nenhum dos anteriores"]
    ),
    Pergunta(
      "Teve contato com algum caso suspeito ou confirmado de COVID-19 no Domicilio?",
      ["Sim", "Não" ]
    ),
    Pergunta(
      "Você é profissional de saúde?",
      ["Sim", "Não" ]
    )
  ];

  Animation<double> perguntaSingleAnimation;
  Animation<double> perguntaMultAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _firstAnimationController = AnimationController(
        duration: Duration(milliseconds: 2000), vsync: this);
    _perguntaSingleController = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);
    _perguntaMultController = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);

    perguntaSingleAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: _perguntaSingleController,
            curve: Interval(
              0.1,
              1.0,
              curve: Curves.fastOutSlowIn,
            )));

    perguntaMultAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: _perguntaMultController,
            curve: Interval(
              0.1,
              1.0,
              curve: Curves.fastOutSlowIn,
            )));

    _firstAnimationController.addListener(() {
      setState(() {});
    });
    
    _perguntaSingleController.addListener(() {
      setState(() {});
    });

    _perguntaMultController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _firstAnimationController.dispose();
    _perguntaSingleController.dispose();
    _perguntaMultController.dispose();
    super.dispose();
  }

  Future _startAnimation() async {
    try {
      await _firstAnimationController.forward().orCancel;
      setState(() {});
    } on TickerCanceled {}
  }

  Future _startPerguntaSingleAnimation() async {
    try {
      await _perguntaSingleController.forward().orCancel;
    } on TickerCanceled {}
  }

  Future _startPerguntaMultAnimation() async {
    try {
      await _perguntaMultController.forward().orCancel;
    } on TickerCanceled {}
  }

  @override
  Widget build(BuildContext context) {
    final ui.Size logicalSize = MediaQuery.of(context).size;
    final double _width = logicalSize.width;

    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: _firstAnimationController.isCompleted
              ? getPages(_width)
              : AnimationBox(
                  controller: _firstAnimationController,
                  screenWidth: _width - 32.0,
                  primeiraPergunta: PerguntaSingle(
                    animation: _firstAnimationController,
                    pergunta: perguntas[0].pergunta,
                    tituloPergunta: "Pergunta 1",
                    respostas: perguntas[0].respostas,
                  ),
                  onStartAnimation: () {
                    _startAnimation();
                  },
                ),
        ),
      ),
      bottomNavigationBar: _firstAnimationController.isCompleted
          ? BottomAppBar(
              child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [BoxShadow(color: Colors.grey.withAlpha(200))]),
              height: 50.0,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    curIndex += 1;
                    if (curIndex == 1) {
                      _perguntaMultController.value = 0;
                      _startPerguntaMultAnimation();
                    } else if (curIndex == 2) {
                      _perguntaMultController.value = 0;
                      _startPerguntaMultAnimation();
                    } else if (curIndex == 3) {
                      _perguntaSingleController.value = 0;
                      _startPerguntaSingleAnimation();
                    } else if (curIndex == 4) {
                      _perguntaSingleController.value = 0;
                      _startPerguntaSingleAnimation();
                    }
                  });
                },
                child: Center(
                    child: Text(
                  curIndex < 4 ? 'Continue' : 'Finish',
                  style: TextStyle(fontSize: 20.0, color: Colors.orangeAccent),
                )),
              ),
            ))
          : null,
    );
  }

  Widget getPages(double _width) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
//                color: Colors.blue,
          margin: EdgeInsets.only(top: 30.0),
          height: 10.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: List.generate(5, (int index) {
              return Container(
                decoration: BoxDecoration(
//                    color: Colors.orangeAccent,
                  color: index <= curIndex ? Colors.orangeAccent : Colors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(2.0)),
                ),
                height: 10.0,
                width: (_width - 32.0 - 20.0) / 5.0,
                margin: EdgeInsets.only(left: index == 0 ? 0.0 : 5.0),
              );
            }),
          ),
        ),
        curIndex == 0
            ? new PerguntaSingle(tituloPergunta: "Pergunta 1" ,pergunta: perguntas[0].pergunta, respostas: perguntas[0].respostas, animation: _firstAnimationController,)
            : curIndex == 1
              ? new PerguntaMult(tituloPergunta: "Pergunta 2" ,pergunta: perguntas[1].pergunta, respostas: perguntas[1].respostas, animation: perguntaMultAnimation,)
              : curIndex == 2 
              ? new PerguntaMult(tituloPergunta: "Pergunta 3" ,pergunta: perguntas[2].pergunta, respostas: perguntas[2].respostas, animation: perguntaMultAnimation,)
                : curIndex == 3 
                ? new PerguntaSingle(tituloPergunta: "Pergunta 4" ,pergunta: perguntas[3].pergunta, respostas: perguntas[3].respostas, animation: perguntaSingleAnimation,)
                  : new PerguntaSingle(tituloPergunta: "Pergunta 5" ,pergunta: perguntas[4].pergunta, respostas: perguntas[4].respostas, animation: perguntaSingleAnimation,)
      ],
    );
  }

}

class AnimationBox extends StatelessWidget {
  AnimationBox(
      {Key key, this.controller, this.screenWidth, this.onStartAnimation, this.primeiraPergunta,

      })
      : width = Tween<double>(
          begin: screenWidth,
          end: 40.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.1,
              0.3,
              curve: Curves.fastOutSlowIn,
            ),
          ),
        ),
        alignment = Tween<AlignmentDirectional>(
          begin: AlignmentDirectional.bottomCenter,
          end: AlignmentDirectional.topStart,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.3,
              0.6,
              curve: Curves.fastOutSlowIn,
            ),
          ),
        ),
        radius = BorderRadiusTween(
          begin: BorderRadius.circular(20.0),
          end: BorderRadius.circular(2.0),
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.6,
              0.8,
              curve: Curves.ease,
            ),
          ),
        ),
        height = Tween<double>(
          begin: 40.0,
          end: 0.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.3,
              0.8,
              curve: Curves.ease,
            ),
          ),
        ),
        movement = EdgeInsetsTween(
          begin: EdgeInsets.only(top: 0.0),
          end: EdgeInsets.only(top: 30.0),
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.3,
              0.6,
              curve: Curves.fastOutSlowIn,
            ),
          ),
        ),
        scale = Tween<double>(
          begin: 1.0,
          end: 0.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.8,
              1.0,
              curve: Curves.fastOutSlowIn,
            ),
          ),
        ),
        opacity = Tween<double>(
          begin: 1.0,
          end: 0.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.8,
              1.0,
              curve: Curves.fastOutSlowIn,
            ),
          ),
        ),
        numberOfStep = IntTween(
          begin: 1,
          end: 5,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.8,
              1.0,
              curve: Curves.fastOutSlowIn,
            ),
          ),
        ),
        super(key: key);

  final VoidCallback onStartAnimation;
  final Animation<double> controller;
  final Animation<double> width;
  final Animation<double> height;
  final Animation<AlignmentDirectional> alignment;
  final Animation<BorderRadius> radius;
  final Animation<EdgeInsets> movement;
  final Animation<double> opacity;
  final Animation<double> scale;
  final Animation<int> numberOfStep;
  final double screenWidth;
  final double overral = 3.0;
  final Widget primeiraPergunta;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget child) {
        return Stack(
          alignment: alignment.value,
          children: <Widget>[
            Opacity(
              opacity: 1.0 - opacity.value,
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 30.0),
                    height: 10.0,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: List.generate(numberOfStep.value, (int index) {
                        return Container(
                          decoration: BoxDecoration(
                            color:
                                index == 0 ? Colors.orangeAccent : Colors.grey,
                            borderRadius:
                                BorderRadius.all(Radius.circular(2.0)),
                          ),
                          height: 10.0,
                          width: (screenWidth - 20.0) / 5.0,
                          margin: EdgeInsets.only(left: index == 0 ? 0.0 : 5.0),
                        );
                      }),
                    ),
                  ),
                  primeiraPergunta,
                ],
              ),
            ),
            Opacity(
              opacity:
                  controller.status == AnimationStatus.dismissed ? 1.0 : 0.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Expanded(
                      child: Center(
                          child: FlutterLogo(
                            colors: Colors.orange,
                    size: 100.0,
                  ))),
                  Text(
                    'Pesquisa sobre Corona virus.',
                    style: TextStyle(
                        color: Colors.orangeAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0, bottom: 120.0),
                    child: Text(
                      'By answering this 3 minutes survey, you help us improve our service event better for you',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Opacity(
              opacity: opacity.value,
              child: GestureDetector(
                onTap: onStartAnimation,
                child: Transform.scale(
                  scale: scale.value,
                  child: Container(
                    margin: movement.value,
                    width: width.value,
                    child: GestureDetector(
                      child: Container(
                        height: height.value,
                        decoration: BoxDecoration(
                            color: Colors.orangeAccent,
                            borderRadius: radius.value),
                        child: Center(
                          child: controller.status == AnimationStatus.dismissed
                              ? Text(
                                  'Take the survey',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20.0),
                                )
                              : null,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
//            Opacity(
//              opacity: 1.0 - opacity.value,
//              child:
//            ),
          ],
        );
      },
    );
  }
}

class PerguntaSingle extends StatefulWidget{
  
  PerguntaSingle({
    Key key, 
    this.tituloPergunta,
    this.pergunta,
    this.respostas,
    this.animation,
    this.animationGetValue,
  }) : super(key: key);
  
    final String tituloPergunta;
    final String pergunta;
    final List<String> respostas;
    final Animation<double> animation;
    final Animation<double> animationGetValue;

  int selecionado = -1;

  @override
  PerguntaSingleState createState() => PerguntaSingleState();
}

class PerguntaSingleState extends State<PerguntaSingle>{
  
  @override
  void initState() {
    super.initState();
  }

  int selecionado;
  
  @override
  Widget build(BuildContext context) {
    return new PerguntaConstructor(
      tituloPergunta: widget.tituloPergunta,
      pergunta: widget.pergunta,
      respostas: widget.respostas,
      animation: widget.animation,
      animationGetValue: widget.animationGetValue,
      conteudo: ListView.builder(
        itemCount: widget.respostas.length,
        padding: const EdgeInsets.all(0.0),
        itemBuilder: (context, index) {
          final resposta = widget.respostas[index];
          return GestureDetector(
            onTapUp: (detail) {
              setState(() {
                selecionado = index;
              });
            },
            child: Container(
              height: 50.0,
              color: selecionado == index
                ? Colors.orangeAccent.withAlpha(100)
                : Colors.white,
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Radio(
                        activeColor: Colors.orangeAccent,
                        value: index,
                        groupValue: selecionado,
                        onChanged: (int value) {
                          setState(() {
                            selecionado = value;
                          });
                        }
                      ),
                      Text(resposta)
                    ],
                  ),
                  Divider(
                    height: index < widget.respostas.length
                      ? 1.0
                      : 0.0,
                  ),
                ],
              ),
            ),
          );
        },
      )
    );
  }
}

class PerguntaMult extends StatefulWidget{
  
  PerguntaMult({
    Key key, 
    this.tituloPergunta,
    this.pergunta,
    this.respostas,
    this.animation,
    this.animationGetValue,
  }) : super(key: key);
  
    final String tituloPergunta;
    final String pergunta;
    final List<String> respostas;
    final Animation<double> animation;
    final Animation<double> animationGetValue;

  List<int> selecionado = new List<int>();

  @override
  PerguntaMultState createState() => PerguntaMultState();
}

class PerguntaMultState extends State<PerguntaMult>{
  
  @override
  void initState() {
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return new PerguntaConstructor(
      tituloPergunta: widget.tituloPergunta,
      pergunta: widget.pergunta,
      respostas: widget.respostas,
      animation: widget.animation,
      conteudo: ListView.builder(
        itemCount: widget.respostas.length,
        padding: const EdgeInsets.all(0.0),
        itemBuilder: (context, index) {
          final resposta = widget.respostas[index];
          return GestureDetector(
            onTapUp: (detail) {
              setState(() {
                if(widget.selecionado.contains(index))
                  widget.selecionado.remove(index);
                else if(index == widget.respostas.length - 1){
                  widget.selecionado.removeRange(0, widget.selecionado.length);
                  widget.selecionado.add(index);
                }
                else{
                  if(widget.selecionado.contains(widget.respostas.length - 1))
                    widget.selecionado.remove(widget.respostas.length - 1);
                  widget.selecionado.add(index);
                }
              });
            },
            child: Container(
              height: 50.0,
              color: widget.selecionado.contains(index)
                ? Colors.orangeAccent.withAlpha(100)
                : Colors.white,
              child: Row(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Checkbox(
                        activeColor: Colors.orangeAccent,
                        value: widget.selecionado.contains(index),
                        onChanged: (bool value) {
                          setState(() {
                            if(widget.selecionado.contains(index))
                              widget.selecionado.remove(index);
                            else if(index == widget.respostas.length - 1){
                              widget.selecionado.removeRange(0, widget.selecionado.length);
                              widget.selecionado.add(index);
                            }
                            else{
                              if(widget.selecionado.contains(widget.respostas.length - 1))
                                widget.selecionado.remove(widget.respostas.length - 1);
                              widget.selecionado.add(index);
                            }
                          });
                        }
                      ),
                      Text(resposta)
                    ],
                  ),
                  Divider(
                    height: index < widget.respostas.length
                      ? 1.0
                      : 0.0,
                  ),
                ],
              ),
            ),
          );
        },
      )
    );
  }
}

class PerguntaConstructor extends StatelessWidget{
  
  PerguntaConstructor({
    Key key, 
    this.tituloPergunta,
    this.pergunta,
    this.respostas,
    this.animation,
    this.animationGetValue,
    this.conteudo,
  }) : super(key: key);
  
    final String tituloPergunta;
    final String pergunta;
    final List<String> respostas;
    final Animation<double> animation;
    final Animation<double> animationGetValue;
    final Widget conteudo;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 34.0),
        child: Transform(
          transform: new Matrix4.translationValues(
            0.0, 50.0 * (1.0 - animation.value), 0.0
          ),
          child: Opacity(
            opacity: animation.value,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(tituloPergunta),
                Container(
                  margin: EdgeInsets.only(top: 16.0, bottom: 0),
                  child: Text(pergunta)
                ),
                Expanded(
                  child: Center(
                    child: Container(
                      height: respostas.length * 50.0 + 5,
                      child: Card(
                        child: conteudo
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class Pergunta {

  Pergunta(
    this.pergunta, 
    this.respostas
  );

  final String pergunta;
  final List<String> respostas;

}