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
    return Scaffold(
      appBar: AppBar(
        title: Text("Pesquisa"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CardPergunta(
              pergunta: "Teste",
              respostas: respostas,
              perguntaAnterior: null,
              proxPergunta: null,
            )
          ],
        ),
      ),
    );
  }
}


class CardPergunta extends StatelessWidget{

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pesquisa"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Texto(texto: pergunta,),
            Spacer(),
            Expanded(
              child: ListView.builder(
                itemCount: respostas.length,
                itemBuilder: (context, index) {
                  final item = respostas[index];
                  return CardResposta(
                    resposta: item,
                    proxPergunta: proxPergunta,
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Row(
        children: <Widget>[
          CardChangePage(
            pagina: perguntaAnterior,
            texto: "Voltar",
            icon: Icons.arrow_back,
          ),
          Spacer(),
          CardChangePage(
            pagina: proxPergunta,
            texto: "Pular",
            icon: Icons.arrow_forward,
          ),
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

class CardResposta extends StatelessWidget{

  CardResposta({
    Key key, 
    this.resposta,
    this.proxPergunta
  }) : super(key: key);
  
    final String resposta;
    final CardPergunta proxPergunta;

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 100,
      child: Card(
        color: Colors.white70,
        child: Center(
          child: ListTile(
            title: Texto(texto: resposta,),
            onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => proxPergunta),
            );
          },
          ),
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
    return new Container(
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
    );
  }
}