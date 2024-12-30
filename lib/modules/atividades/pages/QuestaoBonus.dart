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
      backgroundColor: const Color.fromARGB(255, 29, 28, 28),
      appBar: AppBar(
        automaticallyImplyLeading: false, // Remove a seta para voltar
        centerTitle: true, // Centraliza o título
        title: const Text(
          'DESAFIO BÔNUS',
          style: TextStyle(
            color: Colors.amber, // Cor dourada
            fontWeight: FontWeight.bold, // Negrito
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
                  color: Colors.white),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('src/images/coruja_mago_falando.png',
                    width: 300, height: 300),
                IconButton(
                  iconSize: 50.0,
                  icon: const Icon(Icons.chat_bubble),
                  color: Colors.white,
                  onPressed: _playAudioFromFirebase,
                ),
              ],
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
                      int xpGanhoDobrado = widget.xpGanho * 2;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              GanhaXP(xpGanho: xpGanhoDobrado, porCompletar: "mais uma atividade e acertar a questão bônus!",),
                        ),
                      );
                    } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              GanhaXP(xpGanho: widget.xpGanho, porCompletar: "mais uma atividade. Infelizmente, você errou a questão bônus.",),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
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
                      int xpGanhoDobrado = widget.xpGanho * 2;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              GanhaXP(xpGanho: xpGanhoDobrado, porCompletar: "mais uma atividade e acertar a questão bônus!",),
                        ),
                      );
                    } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              GanhaXP(xpGanho: widget.xpGanho, porCompletar: "mais uma atividade. Infelizmente, você errou a questão bônus.",),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(' A sentença é falsa ',
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
