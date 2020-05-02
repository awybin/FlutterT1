import 'package:flutter/material.dart';


class PesquisaMain extends StatefulWidget{

  List<int> respostas;

  @override
  PesquisaMainState createState() => PesquisaMainState();
}

class PesquisaMainState extends State<PesquisaMain>{

  List<String> respostas = new List<String>();
    
  @override
  void initState() {
    super.initState();
    respostas.add("AAAA");
    respostas.add("BBBB");
    respostas.add("CCCC");
    respostas.add("DDDD");
  }

  @override
  Widget build(BuildContext context) {
    return CardPergunta(
      pergunta: "Teste",
      respostas: respostas,
      perguntaAnterior: null,
      proxPergunta: null,
    );


    //Scaffold(
      //appBar: AppBar(
        //title: Text("Pesquisa"),
      //),
      //body: Center(
        //child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          //children: <Widget>[
            //CardPergunta(
              //pergunta: "Teste",
              //respostas: respostas,
              //perguntaAnterior: null,
             // proxPergunta: null,
           // )
         // ],
       // ),
      //),
   // );
  }
}


class CardPergunta extends StatefulWidget{

  CardPergunta({
    Key key, 
    this.pergunta,
    this.respostas,
    this.proxPergunta,
    this.perguntaAnterior,
  }) : super(key: key);
  
    final String pergunta;
    final List<String> respostas;
    final CardPergunta proxPergunta;
    final CardPergunta perguntaAnterior;


  @override
  CardPerguntaState createState() => CardPerguntaState();
}
  
class CardPerguntaState extends State<CardPergunta>{

  Widget bottom1;
  Widget bottom2;
    
  @override
  void initState() {
    super.initState();

    if(widget.perguntaAnterior != null){
      bottom1 = new CardChangePage(
        pagina: widget.perguntaAnterior,
        texto: "Voltar",
        icon: Icons.arrow_back,
      );
    }
    else
      bottom1 = new EmptyWidget();

    if(widget.proxPergunta != null){
      bottom2 = new CardChangePage(
        pagina: widget.proxPergunta,
        texto: "Pular",
        icon: Icons.arrow_forward,
      );
    }
    else
      bottom2 = new EmptyWidget();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pesquisa"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Texto(texto: widget.pergunta,),
            //Spacer(),
            Expanded(
              child: ListView.builder(
                itemCount: widget.respostas.length,
                itemBuilder: (context, index) {
                  final item = widget.respostas[index];
                  return CardResposta(
                    resposta: item,
                    proxPergunta: widget.proxPergunta,
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Row(
        children: <Widget>[
          bottom1,
          Spacer(),
          bottom2
        ],
      ),
    );
  }
}

class Texto extends StatelessWidget{

  Texto({
    Key key, 
    this.texto,
  }) : super(key: key);
  
    final String texto;

  Widget build(BuildContext context) {
    return new Text(
      texto,
      style: const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 20.0,
      ),
    );
  }
}

class CardResposta extends StatefulWidget{

  CardResposta({
    Key key, 
    this.resposta,
    this.proxPergunta
  }) : super(key: key);
  
    final String resposta;
    final CardPergunta proxPergunta;

  @override
  CardRespostaState createState() => CardRespostaState();

}

class CardRespostaState extends State<CardResposta>{
//https://stackoverflow.com/questions/45153204/how-can-i-handle-a-list-of-checkboxes-dynamically-created-in-flutter
  IconData iconData = Icons.check_box_outline_blank;
  Icon icon = Icon(Icons.check_box_outline_blank);

  @override
  void initState() {
    super.initState();
    iconData = Icons.check_box_outline_blank;
  }

  void changeIcon(){
    setState((){
      if(iconData == Icons.check_box_outline_blank)
        iconData = Icons.check_box;
      else
        iconData = Icons.check_box;
      icon = new Icon(iconData);
    }
    );    
  }

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onDoubleTap: (){
          Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => widget.proxPergunta),
        );
      },
      onTap: (){
        changeIcon();
      },
      child: Container(
        height: 100,
        child: Card(
          color: Colors.white70,
          child: Center(
            child: ListTile(
              leading: Icon(Icons.check_box_outline_blank),//icon,
              title: Texto(texto: widget.resposta,),
            ),
          )
        )
      )
    );
  }
}


class CardChangePage extends StatelessWidget{

  CardChangePage({
    Key key, 
    this.icon,
    this.texto,
    this.pagina
  }) : super(key: key);
  
  final IconData icon;
  final String texto;
  final Widget pagina;  
    
  @override
  Widget build(BuildContext context) {
    return new Expanded(
      child: Container(
        height: 30,
        child: Card(
          color: Colors.yellow[50],
          child: Center(
            child: ListTile(
              leading: Icon(icon),
              title: Texto(texto: texto,),
              onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => pagina),
              );
            },
            ),
          )
        )
      )
    );
  }
}


class EmptyWidget extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0,
    );
  }
}