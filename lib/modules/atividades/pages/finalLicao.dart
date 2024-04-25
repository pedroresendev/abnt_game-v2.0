import 'package:abntplaybic/modules/atividades/pages/carregaAtividadesPage.dart';
import 'package:abntplaybic/shared/colors.dart';
import 'package:flutter/material.dart';

class FinalLicaoPage extends StatefulWidget {
  const FinalLicaoPage(this.idTopico, this.idSubTopico, {super.key});
  final String idTopico;
  final String idSubTopico;
  @override
  State<FinalLicaoPage> createState() => _FinalLicaoPageState();
}

class _FinalLicaoPageState extends State<FinalLicaoPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Text(
            "Hora de testar seus conhecimentos!",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "Montserrat",
              fontWeight: FontWeight.w800,
              fontSize: 24,
            ),
          ),
          Image.asset("src/images/folhaFinal.png"),
          Column(
            children: [
              TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: primary,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13)),
                    fixedSize: Size(size.width * 0.65, 62),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CarregaAtividadesPage(
                                widget.idTopico, widget.idSubTopico)));
                  },
                  child: const Text(
                    "Começar Teste",
                    style: TextStyle(
                        fontFamily: "PassionOne",
                        fontSize: 32,
                        color: Colors.white),
                  )),
              const SizedBox(height: 10),
              TextButton(
                  style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13),
                          side: const BorderSide(color: primary)),
                      fixedSize: Size(size.width * 0.6, 60)),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Sair",
                    style: TextStyle(
                        fontFamily: "PassionOne", fontSize: 32, color: primary),
                  )),
            ],
          ),
        ],
      ),
    ));
  }
}
