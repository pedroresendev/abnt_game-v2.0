import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class QuestaoBonus extends StatefulWidget {
  final int xpGanho;
  final String porCompletar;

  const QuestaoBonus(
      {super.key, required this.xpGanho, required this.porCompletar});

  @override
  State<QuestaoBonus> createState() => _QuestaoBonusState();
}

class _QuestaoBonusState extends State<QuestaoBonus> {
  final AudioPlayer _audioPlayer = AudioPlayer();

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
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
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
                  onPressed: () async {
                    // await _audioPlayer.play('assets/owl_sound.mp3');
                  },
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
                  onPressed: () {
                    // Ação para o botão "Verdade"
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('A sentença é verdadeira', style: TextStyle(color: Colors.white, fontSize: 18),),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Ação para o botão "Mentira"
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(' A sentença é falsa ', style: TextStyle(color: Colors.white, fontSize: 18)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
