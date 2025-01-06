import 'package:flutter/material.dart';

import '../../../../core/redirectPage.dart';

class TutorialProfessorPage extends StatefulWidget {
  const TutorialProfessorPage({super.key});

  @override
  _TutorialProfessorPageState createState() => _TutorialProfessorPageState();
}

class _TutorialProfessorPageState extends State<TutorialProfessorPage> {
  final controller = PageController();
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {
        currentPage = controller.page!.round();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
                centerTitle: true,
        toolbarHeight: 80,         title: const Text(
          'TUTORIAL PARA O PROFESSOR',
          style: TextStyle(
              color: Colors.purple,               fontWeight: FontWeight.bold,
              fontFamily: "Righteous",
              fontSize: 25               ),
          softWrap: true,
          overflow: TextOverflow.visible,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: PageView(
        controller: controller,
        children: <Widget>[
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Image.asset('src/images/coruja_cartola.png',
                      width: 300, height: 300),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 20.0),                   child: Container(
                    padding: EdgeInsets.all(15.0),                     decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black, width: 2),
                    ),
                    child: Column(children: [
                      Text(
                        '- Seja bem vindo professor! Agora, eu irei te guiar para que você possa criar as suas turmas virtuais e compartilhar o acesso a ela com os seus alunos!',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ]),
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 20.0),                   child: Container(
                    padding: EdgeInsets.all(15.0),                     decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black, width: 2),
                    ),
                    child: Column(children: [
                      Text(
                        '- Clique no ícone de tabela localizado na parte de baixo da tela.',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 5),
                    ]),
                  ),
                ),
                Container(
                  child: Image.asset('src/images/tela_inicial.png',
                      width: 350, height: 350),
                ),
              ],
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 20.0),                   child: Container(
                    padding: EdgeInsets.all(15.0),                     decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black, width: 2),
                    ),
                    child: Column(children: [
                      Text(
                        '- Ao clicar, você será redirecionado para a aba de turmas. Aperte em "Criar nova Turma"!',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 5),
                    ]),
                  ),
                ),
                Container(
                  child: Image.asset('src/images/btn_nova_turma.PNG',
                      width: 350, height: 350),
                ),
              ],
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Image.asset('src/images/criando_turma.PNG',
                      width: 350, height: 350),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 20.0),                   child: Container(
                    padding: EdgeInsets.all(15.0),                     decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black, width: 2),
                    ),

                    child: Column(children: [
                      Text(
                        '- Ao clicar, você será redirecionado para uma nova sessão. Nela, será possível colocar o nome da turma e também todos os conteúdos que preferir.',
                        style: TextStyle(
                          fontSize: 19,
                        ),
                      ),
                    ]),
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 20.0),                   child: Container(
                    padding: EdgeInsets.all(15.0),                     decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black, width: 2),
                    ),
                    child: Column(children: [
                      Text(
                        '- Clique no ícone de tabela localizado na parte inferior da tela novamente.',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 5),
                    ]),
                  ),
                ),
                Container(
                  child: Image.asset('src/images/tela_inicial.png',
                      width: 350, height: 350),
                ),
              ],
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 20.0),                   child: Container(
                    padding: EdgeInsets.all(15.0),                     decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black, width: 2),
                    ),
                    child: Column(children: [
                      Text(
                        '- Agora, a turma que você criou aparecerá. O código da turma será exibido ao lado direito do nome da turma. Clique na turma!',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ]),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  child: Image.asset('src/images/ver_turma.PNG',
                      width: 350, height: 350),
                ),
              ],
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Image.asset('src/images/ranking_alunos.PNG',
                      width: 300, height: 300),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 20.0),                   child: Container(
                    padding: EdgeInsets.all(15.0),                     decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black, width: 2),
                    ),

                    child: Column(children: [
                      Text(
                        '- Dentro da sua turma, um ranking mostrando os alunos que mais pontuaram na turma é exibido. A pontuação aumenta com o número de acertos nas atividades!',
                        style: TextStyle(
                          fontSize: 19,
                        ),
                      ),
                    ]),
                  ),
                ),
                SizedBox(height: 12),
                ElevatedButton(
                  child: Text(
                    'IR PARA A PÁGINA INICIAL',
                    style: TextStyle(
                        fontSize: 22,
                        fontFamily: "Righteous",
                        color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: Colors.black, width: 1),
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
        if (currentPage > 0)
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
