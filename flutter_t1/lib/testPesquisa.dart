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
  AnimationController _animateController;
  AnimationController _longPressController;
  AnimationController _secondStepController;
  AnimationController _thirdStepController;

  int curIndex = 0;
  String usingTimes = 'Daily';

  bool isFairly = false;
  bool isClear = false;
  bool isEasy = false;
  bool isFriendly = false;

  List<Resposta> respostas = [
    Resposta(0, 'Daily'),
    Resposta(1, 'Once a week'),
    Resposta(2, 'Once a month'),
    Resposta(3, 'Every 2-3 months'),
    Resposta(4, 'Less than 5 a years'),
  ];

  Animation<double> longPressAnimation;
  Animation<double> secondTranformAnimation;
  Animation<double> thirdTranformAnimation;
  Animation<double> fourTranformAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _animateController = AnimationController(
        duration: Duration(milliseconds: 2000), vsync: this);
    _longPressController = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);
    _secondStepController = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);
    _thirdStepController = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);
    longPressAnimation =
        Tween<double>(begin: 1.0, end: 2.0).animate(CurvedAnimation(
            parent: _longPressController,
            curve: Interval(
              0.1,
              1.0,
              curve: Curves.fastOutSlowIn,
            )));

    secondTranformAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: _secondStepController,
            curve: Interval(
              0.1,
              1.0,
              curve: Curves.fastOutSlowIn,
            )));

    thirdTranformAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: _thirdStepController,
            curve: Interval(
              0.1,
              1.0,
              curve: Curves.fastOutSlowIn,
            )));

    _longPressController.addListener(() {
      setState(() {});
    });

    _secondStepController.addListener(() {
      setState(() {});
    });

    _thirdStepController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animateController.dispose();
    _secondStepController.dispose();
    _thirdStepController.dispose();
    _longPressController.dispose();
    super.dispose();
  }

  Future _startAnimation() async {
    try {
      await _animateController.forward().orCancel;
      setState(() {});
    } on TickerCanceled {}
  }

  Future _startLongPressAnimation() async {
    try {
      await _longPressController.forward().orCancel;
    } on TickerCanceled {}
  }

  Future _startSecondStepAnimation() async {
    try {
      await _secondStepController.forward().orCancel;
    } on TickerCanceled {}
  }

  Future _startThirdStepAnimation() async {
    try {
      await _thirdStepController.forward().orCancel;
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
          child: _animateController.isCompleted
              ? getPages(_width)
              : AnimationBox(
                  controller: _animateController,
                  screenWidth: _width - 32.0,
                  onStartAnimation: () {
                    _startAnimation();
                  },
                ),
        ),
      ),
      bottomNavigationBar: _animateController.isCompleted
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
                      _startThirdStepAnimation();
                    } else if (curIndex == 2) {
                      _startThirdStepAnimation();
                    } else if (curIndex == 3) {
                      _startSecondStepAnimation();
                    } else if (curIndex == 4) {
                      _startSecondStepAnimation();
                    }
                  });
                },
                child: Center(
                    child: Text(
                  curIndex < 5 ? 'Continue' : 'Finish',
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
            children: List.generate(4, (int index) {
              return Container(
                decoration: BoxDecoration(
//                    color: Colors.orangeAccent,
                  color: index <= curIndex ? Colors.orangeAccent : Colors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(2.0)),
                ),
                height: 10.0,
                width: (_width - 32.0 - 15.0) / 4.0,
                margin: EdgeInsets.only(left: index == 0 ? 0.0 : 5.0),
              );
            }),
          ),
        ),
        curIndex == 0
            ? PerguntaSingle(tituloPergunta: "Pergunta 1" ,pergunta: "AAAA", respostas: respostas, animation: secondTranformAnimation,)
            : curIndex == 1
              ? PerguntaMult(tituloPergunta: "Pergunta 2" ,pergunta: "AAAA", respostas: respostas, animation: thirdTranformAnimation,)
              : curIndex == 2 
              ? PerguntaMult(tituloPergunta: "Pergunta 3" ,pergunta: "AAAA", respostas: respostas, animation: thirdTranformAnimation,)
                : curIndex == 3 
                ? PerguntaSingle(tituloPergunta: "Pergunta 4" ,pergunta: "AAAA", respostas: respostas, animation: secondTranformAnimation,)
                  : PerguntaSingle(tituloPergunta: "Pergunta 5" ,pergunta: "AAAA", respostas: respostas, animation: secondTranformAnimation,)
      ],
    );
  }

  /*
  Widget _getSecondStep() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 34.0),
        child: Transform(
          transform: new Matrix4.translationValues(
              0.0, 50.0 * (1.0 - secondTranformAnimation.value), 0.0),
          child: Opacity(
            opacity: secondTranformAnimation.value,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text('Question 2'),
                Container(
                    margin: EdgeInsets.only(top: 16.0),
                    child: Text('How often do you typically use our service?')),
                Expanded(
                  child: Center(
                    child: Container(
                      height: 258.0,
                      child: Card(
                        child: Column(
                          children: List.generate(usingCollection.length,
                              (int index) {
                            final using = usingCollection[index];
                            return GestureDetector(
                              onTapUp: (detail) {
                                setState(() {
                                  usingTimes = using.identifier;
                                });
                              },
                              child: Container(
                                height: 50.0,
                                color: usingTimes == using.identifier
                                    ? Colors.orangeAccent.withAlpha(100)
                                    : Colors.white,
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Radio(
                                            activeColor: Colors.orangeAccent,
                                            value: using.identifier,
                                            groupValue: usingTimes,
                                            onChanged: (String value) {
                                              setState(() {
                                                usingTimes = value;
                                              });
                                            }),
                                        Text(using.displayContent)
                                      ],
                                    ),
                                    Divider(
                                      height: index < usingCollection.length
                                          ? 1.0
                                          : 0.0,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<ThirdQuestion> thirdQuestionList = [
    ThirdQuestion('Fairly cheaper price', false),
    ThirdQuestion('Clear tracking system', false),
    ThirdQuestion('Easy to use', false),
    ThirdQuestion('Friendly customer service', false),
  ];
  Widget _getThirdStep() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 34.0),
        child: Transform(
          transform: new Matrix4.translationValues(
              0.0, 50.0 * (1.0 - thirdTranformAnimation.value), 0.0),
          child: Opacity(
            opacity: thirdTranformAnimation.value,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text('Question 3'),
                Container(
                    margin: EdgeInsets.only(top: 16.0),
                    child: Text('What do you like about our service?')),
                Expanded(
                  child: Center(
                    child: Container(
                      height: 213.0,
                      child: Card(
                        child: Column(
                          children: List.generate(thirdQuestionList.length,
                              (int index) {
                            ThirdQuestion question = thirdQuestionList[index];
                            return Column(
                              children: <Widget>[
                                GestureDetector(
                                  onTapUp: (detail) {
                                    setState(() {
                                      question.isSelected =
                                          !question.isSelected;
//                                  isFairly = !isFairly;
                                    });
                                  },
                                  child: Container(
                                    height: 50.0,
                                    color: question.isSelected
                                        ? Colors.orangeAccent.withAlpha(100)
                                        : Colors.white,
                                    child: Row(
                                      children: <Widget>[
                                        Checkbox(
                                            activeColor: Colors.orangeAccent,
                                            value: question.isSelected,
                                            onChanged: (bool value) {
//                                          print(value);
                                              setState(() {
                                                question.isSelected = value;
                                              });
                                            }),
                                        Text(question.displayContent)
                                      ],
                                    ),
                                  ),
                                ),
                                Divider(
                                  height: index < thirdQuestionList.length
                                      ? 1.0
                                      : 0.0,
                                ),
                              ],
                            );
                          }),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  */
}

class AnimationBox extends StatelessWidget {
  AnimationBox(
      {Key key, this.controller, this.screenWidth, this.onStartAnimation})
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
          end: 4,
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
//                color: Colors.blue,
                    margin: EdgeInsets.only(top: 30.0),
                    height: 10.0,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: List.generate(numberOfStep.value, (int index) {
                        return Container(
                          decoration: BoxDecoration(
//                    color: Colors.orangeAccent,
                            color:
                                index == 0 ? Colors.orangeAccent : Colors.grey,
                            borderRadius:
                                BorderRadius.all(Radius.circular(2.0)),
                          ),
                          height: 10.0,
                          width: (screenWidth - 15.0) / 5.0,
                          margin: EdgeInsets.only(left: index == 0 ? 0.0 : 5.0),
                        );
                      }),
                    ),
                  ),
                  Expanded(
                    child: Container(
//                color: Colors.blue,
                      margin: EdgeInsets.only(top: 34.0),
//                height: 10.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text('Question 1'),
                          Container(
                              margin: EdgeInsets.only(top: 16.0),
                              child: Text(
                                  'Overall, how would you rate our service?')),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 50.0),
                            child: Text(
                              'Good',
                              style: TextStyle(
                                  color: Colors.orangeAccent,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30.0),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
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

class Resposta {

  Resposta(
    this.chave, 
    this.texto
  );

  final int chave;
  final String texto;
}

class PerguntaSingle extends StatefulWidget{
  
  PerguntaSingle({
    Key key, 
    this.tituloPergunta,
    this.pergunta,
    this.respostas,
    this.animation,
  }) : super(key: key);
  
    final String tituloPergunta;
    final String pergunta;
    final List<Resposta> respostas;
    final Animation<double> animation;

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
      conteudo: ListView.builder(
        itemCount: widget.respostas.length,
        padding: const EdgeInsets.all(0.0),
        itemBuilder: (context, index) {
          final resposta = widget.respostas[index];
          return GestureDetector(
            onTapUp: (detail) {
              setState(() {
                selecionado = resposta.chave;
              });
            },
            child: Container(
              height: 50.0,
              color: selecionado == resposta.chave
                ? Colors.orangeAccent.withAlpha(100)
                : Colors.white,
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Radio(
                        activeColor: Colors.orangeAccent,
                        value: resposta.chave,
                        groupValue: selecionado,
                        onChanged: (int value) {
                          setState(() {
                            selecionado = value;
                          });
                        }
                      ),
                      Text(resposta.texto)
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
  }) : super(key: key);
  
    final String tituloPergunta;
    final String pergunta;
    final List<Resposta> respostas;
    final Animation<double> animation;

  @override
  PerguntaMultState createState() => PerguntaMultState();
}

class PerguntaMultState extends State<PerguntaMult>{
  
  @override
  void initState() {
    super.initState();

  }

  List<int> selecionado = new List<int>();
  
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
                if(selecionado.contains(resposta.chave))
                  selecionado.remove(resposta.chave);
                else
                  selecionado.add(resposta.chave);
              });
            },
            child: Container(
              height: 50.0,
              color: selecionado.contains(resposta.chave)
                ? Colors.orangeAccent.withAlpha(100)
                : Colors.white,
              child: Row(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Checkbox(
                        activeColor: Colors.orangeAccent,
                        value: selecionado.contains(resposta.chave),
                        onChanged: (bool value) {
                          setState(() {
                            if(selecionado.contains(resposta.chave))
                            selecionado.remove(resposta.chave);
                            else
                            selecionado.add(resposta.chave);
                          });
                        }
                      ),
                      Text(resposta.texto)
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
    this.conteudo,
  }) : super(key: key);
  
    final String tituloPergunta;
    final String pergunta;
    final List<Resposta> respostas;
    final Animation<double> animation;
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