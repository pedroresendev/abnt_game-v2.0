import 'package:abntplaybic/modules/atividades/controller/atividadeController.dart';
import 'package:abntplaybic/modules/atividades/model/atividade.dart';
import 'package:abntplaybic/shared/colors.dart';
import 'package:abntplaybic/shared/components/botoes/alternativaAtividade.dart';
import 'package:abntplaybic/shared/components/normas/back_button.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:provider/provider.dart';

class AtividadePage extends StatefulWidget {
  final Atividade atividade;
  const AtividadePage(this.atividade, {super.key});

  @override
  State<AtividadePage> createState() => _AtividadePageState();
}

class _AtividadePageState extends State<AtividadePage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var titulo = widget.atividade.title.replaceAll("\\n", "\n");
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: size.width < 768
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const SizedBox(height: 80),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: MarkdownBody(
                              data: titulo,
                              styleSheet: MarkdownStyleSheet(
                                p: TextStyle(fontFamily: "PassionOne", fontSize: 25),
                                h1: TextStyle(fontSize: 18),
                                h1Align: WrapAlignment.start,
                                strong: TextStyle(fontWeight: FontWeight.bold),
                                textAlign: WrapAlignment.center
                              )
                            ),
                        ),
                        Column(children: [
                          ...widget.atividade.altenativas
                              .map(
                                (e) => AlternativaAtividade(e),
                              )
                              .toList()
                        ])
                      ],
                    )
                  : SizedBox(
                      height: size.height,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: size.width * 0.35,
                            padding: const EdgeInsets.all(20),
                            child: MarkdownBody(
                              data: titulo,
                              styleSheet: MarkdownStyleSheet(
                                p: TextStyle(fontFamily: "PassionOne", fontSize: 25),
                                h1: TextStyle(fontSize: 18),
                                h1Align: WrapAlignment.start,
                                strong: TextStyle(fontWeight: FontWeight.bold),
                                textAlign: WrapAlignment.center
                              )
                            ),
                          ),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ...widget.atividade.altenativas
                                    .map(
                                      (e) => AlternativaAtividade(e),
                                    )
                                    .toList()
                              ])
                        ],
                      ),
                    ),
            ),
          ),
          Positioned(
              top: 5,
              left: 5,
              child: BackButtonNormas(
                onPressed: () async {
                  print("function2");
                  await showDialog(
                      context: context,
                      //barrierDismissible: false,
                      builder: (context) => Dialog(
                            child: Container(
                                width: size.width * 0.9,
                                height: size.width * 0.6,
                                constraints: const BoxConstraints(
                                    maxHeight: 250, maxWidth: 450),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    const AutoSizeText(
                                      "Deseja pausar o jogo?",
                                      style: TextStyle(
                                          color: primary,
                                          fontSize: 30,
                                          fontFamily: "BebasNeue"),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        TextButton(
                                          style: TextButton.styleFrom(
                                            padding: const EdgeInsetsDirectional
                                                    .symmetric(
                                                horizontal: 20, vertical: 12),
                                            backgroundColor: primary,
                                            maximumSize: const Size(200, 50),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                          ),
                                          onPressed: () {
                                            context
                                                .read<AtividadeController>()
                                                .pausar();
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                          },
                                          child: const Text("Pausar",
                                              style: TextStyle(
                                                  color: branco,
                                                  fontFamily: "Righteous")),
                                        ),
                                        TextButton(
                                            onPressed: () {
                                              context
                                                  .read<AtividadeController>()
                                                  .limpar();
                                              Navigator.pop(context);
                                              Navigator.pop(context);
                                            },
                                            child: const Text(
                                              "Sair",
                                              style: TextStyle(
                                                  color: primary,
                                                  fontFamily: "Righteous"),
                                            ))
                                      ],
                                    ),
                                  ],
                                )),
                          ));
                },
              )),
          Positioned(
              top: 25,
              child: SizedBox(
                  width: size.width,
                  child: Center(
                      child: Text(
                    "${(context.watch<AtividadeController>().atividades.indexOf(widget.atividade)) + 1}/${context.watch<AtividadeController>().atividades.length.toString()}",
                    style:
                        const TextStyle(fontFamily: "Righteous", fontSize: 25),
                  ))))
        ],
      ),
    ));
  }
}
