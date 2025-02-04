import 'package:abntplaybic/modules/atividades/controller/atividadeController.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:abntplaybic/modules/atividades/pages/ganhaXP.dart';
import 'package:abntplaybic/modules/atividades/pages/EscolherBonus.dart';
import 'package:abntplaybic/modules/atividades/model/atividade.dart';
import 'package:abntplaybic/modules/perfil/controller/perfilProvider.dart';
import 'package:abntplaybic/modules/perfil/models/perfilAluno.dart';
import 'package:abntplaybic/shared/colors.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class AlternativaAtividade extends StatelessWidget {
  final Alternativa alternativa;

  const AlternativaAtividade(this.alternativa, {super.key});

  
  Future<DocumentSnapshot> getExisteBonus(String subTopico, String topico) async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .doc('/topicos/$topico/subTopicos/$subTopico/bonus/audio')
        .get();
    return snapshot;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var controller = context.read<AtividadeController>();
    return InkWell(
      onTap: () async {
        var result = context
            .read<AtividadeController>()
            .atividadeAtual!
            .checkCorrect(alternativa); // Retorna true se a resposta estiver correta.

        if (result) {
          controller.addAcerto(); // Adicona mais um acerto na contagem
        }
        await showModalBottomSheet(
            enableDrag: false,
            constraints: const BoxConstraints(maxWidth: 550),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12))),
            context: context,
            isDismissible: false,
            builder: (context) => WillPopScope(
                  onWillPop: () async {
                    return false;
                  },
                  child: BottomSheet(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12))),
                      onClosing: () {},
                      enableDrag: false,
                      builder: (context) => Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 25, horizontal: 10),
                            child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                                  Text(
                                    result ? "Resposta correta!" : "Resposta incorreta...",
                                    style: TextStyle(
                                      fontFamily: "PassionOne",
                                      fontSize: 40,
                                      color: result ? verde : vermelho,
                                    ),
                                  ),
                              Column(
                                children: [
                                Text(
                                  result ? "Parabéns!!!" : "Resposta correta: ${controller.atividadeAtual!.returnCorrect().value}",
                                  style: TextStyle(
                                    fontFamily: "PassionOne",
                                    fontSize: 20,
                                    color: Colors.green,
                                  ),
                                ),
                                TextButton(
                                    style: TextButton.styleFrom(
                                      backgroundColor: primary,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(13)),
                                      fixedSize: Size(size.width * 0.75, 69),
                                    ),
                                    onPressed: () async {
                                      Navigator.pop(context);
                                      var val = controller.proximaAtividade();
                                      bool atvFeita = false;
                                      if (val == 1) {
                                        if (context
                                            .read<PerfilProvider>()
                                            .perfilAtual is PerfilAluno) {
                                          atvFeita = (context
                                                              .read<PerfilProvider>()
                                                              .perfilAtual
                                                          as PerfilAluno)
                                                      .feitos?[
                                                  controller.atividadeAtual!
                                                      .topico]?[controller
                                                  .atividadeAtual!
                                                  .subTopico]?["tarefa"] ??
                                              false;
                                          if (!atvFeita) {
                                            (context
                                                    .read<PerfilProvider>()
                                                    .perfilAtual as PerfilAluno)
                                                .marcaTarefa(
                                                    controller
                                                        .atividadeAtual!.topico,
                                                    controller.atividadeAtual!
                                                        .subTopico);
                                          }
                                        }
                                        int xpGanho = ((10 *
                                                    controller.acertos) /
                                                controller.atividades.length)
                                            .round();
                                        if (atvFeita) {
                                          Navigator.pop(context);
                                          return;
                                        }
                                        context
                                                  .read<AtividadeController>()
                                                  .limpar();
                                      context.read<AtividadeController>().limpar();

                                      DocumentSnapshot bonusSnapshot = await getExisteBonus(
                                      controller.atividadeAtual!.subTopico, controller.atividadeAtual!.topico);

                                      if (bonusSnapshot.exists) {
                                        Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                            builder: (context) => EscolherBonus(
                                              xpGanho: xpGanho,
                                              porCompletar: "mais uma tarefa",
                                              topico: controller.atividadeAtual!.topico,
                                              subTopico: controller.atividadeAtual!.subTopico,
                                            ),
                                          ),
                                        );
                                      } else {
                                        Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                            builder: (context) => GanhaXP(
                                              xpGanho: xpGanho,
                                              porCompletar: "mais uma tarefa",
                                            ),
                                          ),
                                        );
                                      }
                                      }
                                    },
                                    child: const Text(
                                      "Próximo",
                                      style: TextStyle(
                                          fontFamily: "PassionOne",
                                          fontSize: 32,
                                          color: Colors.white),
                                    ))
                              ],
                            ),
                          ],
                          ),
                          ),
                )));
      },
      child: Container(
          decoration: BoxDecoration(
              color: lilas, borderRadius: BorderRadius.circular(12)),
          margin: const EdgeInsets.symmetric(vertical: 10),
          width: size.width < 768 ? size.width * .8 : size.width * 0.35,
          constraints: BoxConstraints(
              minHeight: size.width < 768 ? size.width * .15 : 0),
          padding: const EdgeInsets.all(12),
          alignment: Alignment.center,
          child:
            MarkdownBody(
              data: alternativa.value,
              styleSheet: MarkdownStyleSheet(
                p: TextStyle(color: branco, fontSize: 25),
                strong: TextStyle(fontWeight: FontWeight.bold),
                textAlign: WrapAlignment.start,
              )
            ),
      )
    );
  }
}
