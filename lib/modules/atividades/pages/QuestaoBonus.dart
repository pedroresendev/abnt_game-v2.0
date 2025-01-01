import 'package:abntplaybic/modules/atividades/pages/ganhaXP.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:audioplayers/audioplayers.dart';

class QuestaoBonus extends StatefulWidget {
  final int xpGanho;
  final String porCompletar;
  final String subTopico; // Adiciona o parâmetro subTopico

  const QuestaoBonus(
      {super.key,
      required this.xpGanho,
      required this.porCompletar,
      required this.subTopico});

  @override
  State<QuestaoBonus> createState() => _QuestaoBonusState();
}

class _QuestaoBonusState extends State<QuestaoBonus> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool verdade = true;
  bool mentira = false;

  Future<void> _playAudioFromFirebase() async {
    try {
      // Substitua 'path/to/audio/file.mp3' pelo caminho do seu arquivo de áudio no Firebase Storage
      String audioPath = '/atividades/indice/classificacao/audio_teste.mp3';
      print(audioPath);
      String audioUrl =
          await FirebaseStorage.instance.ref(audioPath).getDownloadURL();
      await _audioPlayer.play(UrlSource(audioUrl));
    } catch (e) {
      print('Erro ao tocar o áudio: $e');
    }
  }

  // Função para buscar a variável resposta do Firebase
  Future<bool> getResposta(String subTopico) async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .doc('/topicos/indice/subTopicos/classificacao/bonus/res')
        .get();
    return snapshot['resposta'] as bool;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color.fromARGB(255, 29, 28, 28),
      appBar: AppBar(
        automaticallyImplyLeading: false, // Remove a seta para voltar
        centerTitle: true, // Centraliza o título
        title: const Text(
          'DESAFIO BÔNUS',
          style: TextStyle(
              color: Colors.purple, // Cor dourada
              fontWeight: FontWeight.bold,
              fontFamily: "Righteous",
              fontSize: 32 // Negrito
              ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Clique no balão de fala e escute atentamente o que a coruja diz:',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('src/images/coruja_mago_falando.png',
                    width: 270, height: 270),
                IconButton(
                  iconSize: 55.0,
                  icon: const Icon(Icons.chat_bubble_outline_rounded),
                  color: Colors.black,
                  onPressed: _playAudioFromFirebase,
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              "Dica: Utilize fones de ouvido para uma melhor experiência.",
              style: TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 10, // Espaço horizontal entre os botões
              runSpacing: 10, // Espaço vertical entre os botões
              alignment: WrapAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    bool respostaFirebase = await getResposta(widget.subTopico);
                    if (respostaFirebase == true) {
                      showModalBottomSheet(
                        enableDrag: false,
                        isDismissible: false,
                        constraints: const BoxConstraints(maxWidth: 650),
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12))),
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  'Resposta correta!',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Você acertou a questão bônus! Muito bem!',
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 20),
                                SizedBox(
                                width: double.infinity, 
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    int xpGanhoDobrado = widget.xpGanho * 2;
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => GanhaXP(
                                          xpGanho: xpGanhoDobrado,
                                          porCompletar:
                                              "mais uma atividade e acertar a questão bônus!",
                                        ),
                                      ),
                                    );
                                  },
                                  child: Text('Continuar', style: TextStyle(fontSize: 24, color: Colors.white), ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.purple,
                                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: BorderSide(color: Colors.black, width: 1),
                                    ),
                                  ),
                                ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    } else {
                      showModalBottomSheet(
                        enableDrag: false,
                        isDismissible: false,
                        constraints: const BoxConstraints(maxWidth: 650),
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12))),
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  'Resposta incorreta',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Você errou a questão bônus! Que pena...',
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 20),
                                SizedBox(
                                width: double.infinity, 
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => GanhaXP(
                                          xpGanho: widget.xpGanho,
                                          porCompletar:
                                              "mais uma atividade",
                                        ),
                                      ),
                                    );
                                  },
                                  child: Text('Continuar', style: TextStyle(fontSize: 24, color: Colors.white), ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.purple,
                                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: BorderSide(color: Colors.black, width: 1),
                                    ),
                                  ),
                                ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: Colors.black, width: 1),
                    ),
                  ),
                  child: const Text(
                    'A sentença é verdadeira',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    bool respostaFirebase = await getResposta(widget.subTopico);
                    if (respostaFirebase == false) {
                      showModalBottomSheet(
                        enableDrag: false,
                        isDismissible: false,
                        constraints: const BoxConstraints(maxWidth: 650),
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12))),
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  'Resposta correta!',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Você acertou a questão bônus! Muito bem!',
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 20),
                                SizedBox(
                                width: double.infinity, 
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    int xpGanhoDobrado = widget.xpGanho * 2;
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => GanhaXP(
                                          xpGanho: xpGanhoDobrado,
                                          porCompletar:
                                              "mais uma atividade e acertar a questão bônus!",
                                        ),
                                      ),
                                    );
                                  },
                                  child: Text('Continuar', style: TextStyle(fontSize: 24, color: Colors.white), ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.purple,
                                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: BorderSide(color: Colors.black, width: 1),
                                    ),
                                  ),
                                ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    } else {
                      showModalBottomSheet(
                        enableDrag: false,
                        isDismissible: false,
                        constraints: const BoxConstraints(maxWidth: 650),
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12))),
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  'Resposta incorreta',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Você errou a questão bônus! Que pena...',
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 20),
                                SizedBox(
                                width: double.infinity, 
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => GanhaXP(
                                          xpGanho: widget.xpGanho,
                                          porCompletar:
                                              "mais uma atividade",
                                        ),
                                      ),
                                    );
                                  },
                                  child: Text('Continuar', style: TextStyle(fontSize: 24, color: Colors.white), ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.purple,
                                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: BorderSide(color: Colors.black, width: 1),
                                    ),
                                  ),
                                ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: Colors.black, width: 1),
                    ),
                  ),
                  child: const Text('A sentença é mentirosa',
                      style: TextStyle(color: Colors.white, fontSize: 18)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
