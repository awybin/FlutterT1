

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_t1/color_palette.dart';
import 'package:image_picker/image_picker.dart';

class Survey extends StatefulWidget {
  @override
  _SurveyState createState() => _SurveyState();
}

class _SurveyState extends State<Survey> {
  List<SurveyQuestion> questions = [
    SurveyQuestion(
      'Você apresentou algum dos sintomas abaixo?',
      subtitle:
          'Tosse, Febre, Dor de garganta, Coriza, Dores no corpo, Náusea, Falta de ar',
      mainColor: ColorPalette.surveyYellow,
      assetImage: 'FeverMeasurement.png',
    ),
    SurveyQuestion(
      'Você teve contato com algum caso suspeito ou confirmado de COVID-19 nos últimos dias?',
      mainColor: ColorPalette.surveyGreen,
      assetImage: 'MeetingCouple.png',
    ),
    SurveyQuestion(
      'Você é um profissional da saúde?',
      mainColor: ColorPalette.surveyRed,
      assetImage: 'HealthTeam.png',
    ),
    SurveyQuestion(
      'Você continua fazendo suas atividades de casa?',
      mainColor: ColorPalette.surveyPurple,
      assetImage: 'WorkingGuy.png',
    )
  ];

  List<bool> answers = [];

  bool didFinish = false;
  int _currentIndex = 0;
  get currentQuestion {
    return questions[_currentIndex];
  }
  get _question {
    if (_currentIndex == questions.length){
      return new PerguntaFoto(
        
      );
    }
    else{
      return new SurveyQuestionView(
        currentQuestion,
        answerCallback: answered,
      );
    }
  }

  void answered(bool answer) {
    setState(() {
      answers.add(answer);
      if (_currentIndex == questions.length) {
        didFinish = true;
      } else {
        _currentIndex++;
      }
    });
    print(_currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(40.0),
        child: _question
      ),
    );
  }
}

class SurveyQuestionView extends StatelessWidget {
  final currentQuestion;
  final answerCallback;

  SurveyQuestionView(this.currentQuestion, {this.answerCallback});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Card(
          elevation: 0,
          color: Colors.transparent,
          child: Column(
            children: <Widget>[
              currentQuestion.image,
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  currentQuestion.question,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.display3,
                ),
              ),
              Visibility(
                visible: !currentQuestion.hasSubtitle,
                child: Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Text(
                    currentQuestion.subtitle,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.display4,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 30),
          width: MediaQuery.of(context).size.width,
          child: FlatButton(
            padding: EdgeInsets.all(15.0),
            child: Text(
              'Sim',
              style: Theme.of(context).textTheme.display2,
            ),
            color: currentQuestion.mainColor,
            shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(8.0),
            ),
            onPressed: () {
              answerCallback(true);
            },
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
          width: MediaQuery.of(context).size.width,
          child: FlatButton(
            padding: EdgeInsets.all(15.0),
            disabledColor: Colors.grey,
            child: Text(
              'Não',
              style: Theme.of(context).textTheme.display2,
            ),
            color: Colors.grey,
            shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(8.0),
            ),
            onPressed: () {
              answerCallback(false);
            },
          ),
        ),
      ],
    );
  }
}

class SurveyQuestion {
  String question;
  String subtitle;
  Color mainColor;
  String assetImage;

  get image {
    return new Image(image: AssetImage('assets/images/' + assetImage));
  }

  get hasSubtitle {
    return subtitle == '';
  }

  SurveyQuestion(this.question,
      {this.subtitle = '', this.mainColor, this.assetImage});
}


class PerguntaFoto extends StatefulWidget {
  PerguntaFoto({
    Key key,
    
  }) : super(key: key);
  

  @override
  PerguntaFotoState createState() => PerguntaFotoState();
}

class PerguntaFotoState extends State<PerguntaFoto> {
  @override
  void initState() {
    super.initState();
  }

  File imageFile;

  _openGallery(BuildContext context) async{
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState(() {
      imageFile = picture;
    });
    Navigator.of(context).pop();
  }
  
  _openCamera(BuildContext context) async{
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState(() {
      imageFile = picture;
    });
    Navigator.of(context).pop();
  }


  Future <void> _showChoiceDialog(BuildContext context){
    return showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: Text("Make a choice"),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              GestureDetector(
                child: Text("Gallery"),
                onTap: (){
                  _openGallery(context);
                },
              ),
              Padding(padding: EdgeInsets.all(8.0),),
              GestureDetector(
                child: Text("Camera"),
                onTap: (){
                  _openCamera(context);
                },
              )
            ],
          )
        ),
      );
    });
  }

  Widget _decideImageView(){
    if(imageFile == null){
      return Text("SelecionarImagem");
    }
    else{
      Image.file(imageFile, width: 400, height: 400,);  
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _decideImageView(),
              RaisedButton(
                onPressed: (){
                  _showChoiceDialog(context);
                },
                child: Text("Select Image"),
              )
            ],
          ),
        )
    );
  }
}