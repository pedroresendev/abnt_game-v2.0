import 'package:flutter/material.dart';

import '../../../../core/redirectPage.dart';
import '../../../../shared/colors.dart';

class TutorialProfessorPage extends StatefulWidget {
  const TutorialProfessorPage({super.key});

  @override
  _TutorialProfessorPageState createState() => _TutorialProfessorPageState();
}

class _TutorialProfessorPageState extends State<TutorialProfessorPage> {
  final controller = PageController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Tutorial do Professor'), centerTitle: true,
      ),
      body: PageView(
        controller: controller,
        children: <Widget>[
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                padding: EdgeInsets.all(20),
                  child: Text(
                    'Seja bem vindo professor! Agora, você poderá criar as suas turmas virtuais e compartilhar com os seus alunos. Te ensinarei como fazer isso passo a passo!',
                    style: TextStyle(fontFamily: "Montserrat", color: roxo, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: EdgeInsets.zero,
                  padding: EdgeInsets.zero,
                  child: Image.asset(
                    "src/images/coruja.png",
                    width: 250, // Define a largura da imagem
                    height: 250, 
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),
          // Adicione mais páginas aqui
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                padding: EdgeInsets.all(20), 
                 child: Text(
                    '''PASSO 1: Clique no ícone de tabela localizado na parte de baixo da tela.''',
                    style: TextStyle(fontFamily: "Montserrat", color: roxo, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(padding: EdgeInsets.all(1)),
                Image.asset(
                  "src/images/tela_inicial.png",
                  width: size.width * .50,
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 30, 0 ,0),
                  child: Text(
                    'Ao clicar, você será redirecionado para a aba de turmas. Aperte em "Criar nova Turma"!',
                    style: TextStyle(fontFamily: "Montserrat", color: roxo, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Image.asset(
                  "src/images/btn_nova_turma.PNG",
                  width: size.width * .50,
                ),
              ],
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    'PASSO 3: Ao clicar, você será redirecionado para uma nova sessão. Nela, será possível colocar o nome da sua turma e também todos os conteúdos que queria deixar disponível.',
                    style: TextStyle(fontFamily: "Montserrat", color: roxo, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Image.asset(
                  "src/images/criando_turma.PNG",
                  width: size.width * .50,
                  height: size.height * .40,
                ),
              ],
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
              Container(
                padding: EdgeInsets.all(20),
                child: Text(
                  'Clique no ícone de tabela localizado na parte inferior da tela novamente.',
                  style: TextStyle(fontFamily: "Montserrat", color: roxo, fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            Padding(padding: EdgeInsets.all(10)),
            Image.asset(
              "src/images/tela_inicial.png",
              width: size.width * .50,
            ),
            Padding(padding: EdgeInsets.all(10)),
            Text(
              'Agora, a turma que você criou aparecerá. Clique nela!',
              style: TextStyle(fontFamily: "Montserrat", color: roxo, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Padding(padding: EdgeInsets.all(10)),
            Image.asset(
              "src/images/ver_turma.PNG",
              width: size.width * .40,
              height: size.height * .40,
            ),
            ],
          ),
          ),
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20),
              child: RichText(
                text: TextSpan(
                  style: TextStyle(fontFamily: "Montserrat", color: roxo, fontSize: 20, fontWeight: FontWeight.bold),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Agora, você será redirecionado para a aba da turma.',
                    ),
                    TextSpan(
                      text: '\n\n',
                    ),
                    TextSpan(
                      text: 'Aqui, um ranking de alunos é disponibilizado, mostrando os alunos que mais pontuaram na turma. A pontuação aumenta com o número de acertos nas atividades!',
                    ),
                  ],
                ),
              ),
            ),
            Padding(padding: EdgeInsets.all(15)),
            Image.asset(
              "src/images/ranking_alunos.PNG",
            width: size.width * .50,
            height: size.height * .40,
            ),
            Padding(padding: EdgeInsets.all(5)),
            ElevatedButton(
              child: Text(
                'IR PARA A PÁGINA INICIAL',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Cor de fundo
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0), // Botão retangular
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RedirectPage()),
                );
              },
            )
            ],
          ),
          ),
        ],
      ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.transparent,
          elevation: 0,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FloatingActionButton(
                  onPressed: () => controller.previousPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  ),
                  child: Icon(Icons.arrow_back),
                  backgroundColor: const Color.fromARGB(0, 0, 0, 0),
                  hoverColor: Colors.transparent,
                  elevation: 0,
                  highlightElevation: 0,
                ),
                SizedBox(width: 10),
                FloatingActionButton(
                  onPressed: () => controller.nextPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  ),
                  child: Icon(Icons.arrow_forward),
                  backgroundColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  splashColor: null,
                  elevation: 0,
                  highlightElevation: 0,
                ),
                ],
            ),
          ),
        ),
    );
  }
}