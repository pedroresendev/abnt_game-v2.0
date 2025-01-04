import 'package:abntplaybic/modules/atividades/pages/ganhaXP.dart';
import 'package:abntplaybic/modules/atividades/pages/QuestaoBonus.dart';
import 'package:flutter/material.dart';

class EscolherBonus extends StatelessWidget {
  final int xpGanho;
  final String porCompletar;
  final String subTopico; 
  EscolherBonus({
    required this.xpGanho,
    required this.porCompletar,
    required this.subTopico,   });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
        automaticallyImplyLeading: false,         centerTitle: true,         title: const Text(
          'DESAFIO BÔNUS',
          style: TextStyle(
              color: Colors.purple,               fontWeight: FontWeight.bold,
              fontFamily: "Righteous",
              fontSize: 32               ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Olha só! O ',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                    text: 'Mago Coruja',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                    ),
                  ),
                  TextSpan(
                    text: ' apareceu!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              child: Image.asset('src/images/coruja_mago.png',
                  width: 300, height: 300),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 20.0),               child: Container(
               padding: EdgeInsets.all(15.0), 
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black, width: 2),
                ),
                child: Column(children: [
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(children: [
                      TextSpan(
                          text:
                              "- Tenho um desafio para você! Vou dizer uma sentença sobre o conteúdo ",
                          style: TextStyle(fontSize: 20)),
                      TextSpan(
                        text: subTopico,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple,
                        ),
                      ),
                      TextSpan(
                          text: " e, se você acertar, eu irei dobrar a sua XP!",
                          style: TextStyle(fontSize: 20))
                    ]),
                  ),
                ]),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => QuestaoBonus(
                                xpGanho: xpGanho,
                                porCompletar: porCompletar,
                                subTopico: subTopico)));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: Colors.black, width: 1),
                    ),
                  ),
                  child: Text(
                    'Aceitar',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GanhaXP(
                                xpGanho: xpGanho, porCompletar: porCompletar)));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: Colors.black, width: 1),
                    ),
                  ),
                  child: Text(
                    'Recusar',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              "Obs.: Se recusar, você receberá o XP adquirido na atividade normalmente.",
              style: TextStyle(
                  color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              "Recomenda-se o uso de fones de ouvido. Apenas aceite a atividade se você puder escutar algo com o seu dispositivo.",
              style: TextStyle(
                  color: Colors.deepPurple, fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
