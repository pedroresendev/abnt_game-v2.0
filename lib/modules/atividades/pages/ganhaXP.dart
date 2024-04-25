import 'dart:async';
import 'package:abntplaybic/modules/perfil/controller/perfilProvider.dart';
import 'package:abntplaybic/modules/perfil/models/perfilAluno.dart';
import 'package:abntplaybic/shared/colors.dart';
import 'package:abntplaybic/shared/components/normas/back_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GanhaXP extends StatefulWidget {
  const GanhaXP({
    required this.xpGanho,
    required this.porCompletar,
    this.delay = const Duration(seconds: 4),
    this.nextRoute,
    super.key,
  });
  final int xpGanho;
  final Route? nextRoute;
  final Duration delay;
  final String porCompletar;

  @override
  State<GanhaXP> createState() => _GanhaXPState();
}

class _GanhaXPState extends State<GanhaXP> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      (context.read<PerfilProvider>().perfilAtual as PerfilAluno)
          .addXp(widget.xpGanho);
      if (widget.nextRoute != null) {
        Timer(const Duration(seconds: 2), () {
          print("move");
          Navigator.of(context).pushReplacement(widget.nextRoute!);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        // appBar: AppBar(
        //     backgroundColor: Colors.transparent,
        //     elevation: 0,
        //     leading: const BackButtonNormas()),
        body: Stack(
      children: [
        SizedBox(
          width: size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Você ganhou:",
                style: TextStyle(fontFamily: "Righteous", fontSize: 40),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                    color: verde, borderRadius: BorderRadius.circular(12)),
                child: Text(
                  "+${widget.xpGanho.toString()} XP",
                  style: const TextStyle(
                    fontFamily: "PassionOne",
                    fontSize: 30,
                    color: branco,
                  ),
                ),
              ),
              Text(
                "Por completar ${widget.porCompletar}",
                style: const TextStyle(fontFamily: "Righteous", fontSize: 25),
              ),
            ],
          ),
        ),
        Positioned(
            top: 5,
            left: 5,
            child: widget.nextRoute == null ? BackButtonNormas() : Container())
      ],
    ));
  }
}
