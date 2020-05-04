import 'package:flutter/material.dart';
import 'package:flutter_t1/color_palette.dart';

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

  void answered(bool answer) {
    setState(() {
      answers.add(answer);
      if (_currentIndex == questions.length - 1) {
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
        child: SurveyQuestionView(
          currentQuestion,
          answerCallback: answered,
        ),
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
        currentQuestion.image,
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Text(
            currentQuestion.question,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 25, fontFamily: 'Quicksand'),
          ),
        ),
        Visibility(
          visible: !currentQuestion.hasSubtitle,
          child: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Text(
              currentQuestion.subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.w700,
                  color: Colors.grey[600]),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 30),
          width: MediaQuery.of(context).size.width,
          child: FlatButton(
            padding: EdgeInsets.all(15.0),
            child: Text(
              'Sim',
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
                fontFamily: 'Quicksand',
              ),
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
              style: TextStyle(
                  fontSize: 20.0, color: Colors.white, fontFamily: 'Quicksand'),
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