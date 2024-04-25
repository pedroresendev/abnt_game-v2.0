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
        title: Text('Tutorial do Professor'),
      ),
      body: PageView(
        controller: controller,
        children: <Widget>[
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '''Seja bem vindo professor! Agora, você poderá criar as suas turmas virtuais. Te ensinaremos como fazer isso!''',
                  style: TextStyle(fontFamily: "BebasNeue", color: roxo, fontSize: 20),
                ),
                Image.asset(
                  "src/images/coruja_login.png",
                  width: size.width * .40,
                ),
              ],
            ),
          ),
          // Adicione mais páginas aqui
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '''PASSO 1: Clique no ícone de tabela localizado na parte inferior da tela.''',
                  style: TextStyle(fontFamily: "BebasNeue", color: roxo, fontSize: 20),
                ),
                Padding(padding: EdgeInsets.all(10)),
                Image.asset(
                  "src/images/tela_inicial.png",
                  width: size.width * .50,
                ),
                Padding(padding: EdgeInsets.all(10)),
                Text(
                'PASSO 2: Você será redirecionado para a aba de criação de turmas. Aperte em “Criar nova turma”!',
                style: TextStyle(fontFamily: "BebasNeue", color: roxo, fontSize: 20),
                ),
                Image.asset(
                  "src/images/btn_nova_turma.png",
                  width: size.width * .50,
                ),
              ],
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                  Text(
                    'PASSO 3: Ao clicar, você será redirecionado para uma nova sessão. Nela, será possível colocar o nome da sua turma e tambémtodos os conteúdos que queria deixar disponível.',
                    style: TextStyle(fontFamily: "BebasNeue", color: roxo, fontSize: 20),
                  ),
                  Padding(padding: EdgeInsets.all(1)),
                  Image.asset(
                    "src/images/criando_turma.png",
                    width: size.width * .40,
                  ),
                ],
                ),
              ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
              Text(
              'Clique no ícone de tabela localizado na parte inferior da tela novamente.',
              style: TextStyle(fontFamily: "BebasNeue", color: roxo, fontSize: 20),
            ),
            Padding(padding: EdgeInsets.all(15)),
            Image.asset(
              "src/images/tela_inicial.png",
              width: size.width * .50,
            ),
            Padding(padding: EdgeInsets.all(10)),
            Text(
              'Agora, a turma que você criou aparecerá. Clique nela!',
              style: TextStyle(fontFamily: "BebasNeue", color: roxo, fontSize: 20),
            ),
            Padding(padding: EdgeInsets.all(15)),
            Image.asset(
              "src/images/ver_turma.png",
              width: size.width * .40,
              height: size.height * .40,
            ),
            Text(
              'Nesse caso, vamos entrar na turma "Turma Joia"',
              style: TextStyle(fontFamily: "BebasNeue", color: preto, fontSize: 10),
            )
            ],
          ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RichText(
                  text: TextSpan(
                    style: TextStyle(fontFamily: "BebasNeue", color: roxo, fontSize: 20),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Agora, você será redirecionado para a aba da turma. Nela, você poderá ver todos os conteúdos que disponibilizou para os alunos.',
                      ),
                      TextSpan(
                        text: '\n\n', // Adiciona uma linha em branco entre os parágrafos
                      ),
                      TextSpan(
                        text: 'Um ranking de alunos é disponibilizado, mostrando os alunos que mais pontuaram na turma. A pontuação aumenta com o número de acertos nas atividades!',
                      ),
                    ],
                  ),
                ),
            Padding(padding: EdgeInsets.all(25)),
            Image.asset(
              "src/images/ranking_alunos.png",
              width: size.width * .50,
              height: size.height * .40,
            ),
            Padding(padding: EdgeInsets.all(20)),
            Text(
              ' Pronto! Agora você já pode criar e acessar as suas turmas virtuais!!!',
              style: TextStyle(fontFamily: "BebasNeue", color: roxo, fontSize: 20),
            ),
              TextButton(
                    child: Text('IR PARA A PÁGINA INICIAL'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RedirectPage()),
                      );
                    },
                  ),
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
              mainAxisAlignment: MainAxisAlignment.center,
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