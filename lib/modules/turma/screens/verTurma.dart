import 'package:abntplaybic/modules/home/pages/telas/classificacao.dart';
import 'package:abntplaybic/modules/turma/models/turma.dart';
import 'package:abntplaybic/modules/turma/screens/editarTurma.dart';
import 'package:abntplaybic/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class VerTurmaScreen extends StatefulWidget {
  const VerTurmaScreen(this.turma, {super.key});
  final Turma turma;
  @override
  State<VerTurmaScreen> createState() => _VerTurmaScreenState();
}

class _VerTurmaScreenState extends State<VerTurmaScreen>
    with SingleTickerProviderStateMixin {
  int atualIndice = 0;
  List<Widget> telas = [];
  late TabController tabCont;

  @override
  void initState() {
    super.initState();
    telas = [
      ClassificacaoPage(
        turma: widget.turma.id,
      ),
      EditarTurmaPage(widget.turma)
    ];
    tabCont = TabController(length: 2, vsync: this);
    tabCont.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: lilas,
        title: Text(widget.turma.nome),
        bottom: TabBar(
          indicatorColor: primary,
          controller: tabCont,
          tabs: [
            Column(
              children: [
                Icon(
                  tabCont.index == 0
                      ? MdiIcons.signalCellular3
                      : MdiIcons.signalCellularOutline,
                ),
                const Text("Ranking"),
              ],
            ),
            Column(
              children: [
                Icon(
                  tabCont.index == 1
                      ? MdiIcons.bookEdit
                      : MdiIcons.bookEditOutline,
                ),
                const Text("Editar"),
              ],
            )
          ],
        ),
      ),
      body: TabBarView(controller: tabCont, children: telas),
    );
  }
}
