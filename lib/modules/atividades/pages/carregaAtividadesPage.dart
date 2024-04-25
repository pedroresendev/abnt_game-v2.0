import 'package:abntplaybic/modules/atividades/controller/atividadeController.dart';
import 'package:abntplaybic/modules/atividades/pages/atividadePage.dart';
import 'package:abntplaybic/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CarregaAtividadesPage extends StatefulWidget {
  const CarregaAtividadesPage(this.idTopico, this.idSubTopicos, {super.key});
  final String idTopico;
  final String idSubTopicos;
  @override
  State<CarregaAtividadesPage> createState() => _CarregaAtividadesPageState();
}

class _CarregaAtividadesPageState extends State<CarregaAtividadesPage> {
  Future atividades = Future.value();

  @override
  void initState() {
    super.initState();
    atividades = context
        .read<AtividadeController>()
        .getAtividades(widget.idTopico, widget.idSubTopicos);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AtividadeController>(
      builder: (context, turma, child) => FutureBuilder(
        future: atividades,
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.done &&
              context.read<AtividadeController>().atividadeAtual?.subTopico ==
                  widget.idSubTopicos) {
            return AtividadePage(
                context.watch<AtividadeController>().atividadeAtual!
                  ..altenativas.shuffle());
          } else if (snap.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: const LinearProgressIndicator(
                    color: primary,
                    backgroundColor: lilas,
                  ),
                ),
              ),
            );
          } else {
            return Scaffold(
              appBar: AppBar(
                shadowColor: Colors.transparent,
                backgroundColor: Colors.white,
                leading: IconButton(
                  onPressed: () => Navigator.pop(context),
                  color: roxo,
                  icon: const Icon(
                    Icons.arrow_back,
                    size: 32,
                  ),
                ),
              ),
              body: Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Text(
                    'Desculpe! Ainda não há tarefas cadastradas em "${widget.idTopico}/${widget.idSubTopicos}" nesta versão do ABNT Play.',
                    style: const TextStyle(
                      color: primary,
                      fontFamily: "PassionOne",
                      fontSize: 25,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
