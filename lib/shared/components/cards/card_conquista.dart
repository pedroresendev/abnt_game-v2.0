import 'package:abntplaybic/shared/colors.dart';
import 'package:abntplaybic/shared/components/cards/card_progresso.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:im_stepper/stepper.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class CardConquista extends StatefulWidget {
  final String titulo;
  final int progresso;
  final Color cor;
  final String progresso1;
  final String progresso2;
  final String progresso3;

  const CardConquista(
      {super.key,
      required this.titulo,
      required this.progresso,
      required this.cor,
      required this.progresso1,
      required this.progresso2,
      required this.progresso3});

  @override
  State<CardConquista> createState() => _CardConquistaState();
}

class _CardConquistaState extends State<CardConquista> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () => showModalBottomSheet(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(25),
            ),
          ),
          context: context,
          builder: ((context) {
            return Container(
              height: size.height * 0.5,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 20, 10, 15),
                    child: AutoSizeText(
                      widget.titulo,
                      maxLines: 1,
                      style: const TextStyle(
                        color: Colors.black,
                        fontFamily: "PassionOne",
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      "SEU PROGRESSO",
                      style: TextStyle(
                        color: prata,
                        fontFamily: "BebasNeue",
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(22, 10, 22, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "0%",
                          style: TextStyle(
                            color: roxo,
                            fontFamily: "BebasNeue",
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Text(
                            "50%",
                            style: TextStyle(
                              color: roxo,
                              fontFamily: "BebasNeue",
                              fontSize: 15,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Text(
                          "100%",
                          style: TextStyle(
                            color: roxo,
                            fontFamily: "BebasNeue",
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        LinearPercentIndicator(
                          backgroundColor: lilas.withOpacity(0.5),
                          progressColor: lilas,
                          percent: widget.progresso == 0
                              ? 0
                              : widget.progresso == 1
                                  ? 0.106
                                  : widget.progresso == 2
                                      ? 0.5
                                      : widget.progresso == 3
                                          ? 1
                                          : 0,
                          lineHeight: size.height * 0.08,
                          padding:
                              const EdgeInsets.symmetric(horizontal: 20),
                          barRadius: const Radius.circular(9),
                          animation: true,
                          animateFromLastPercent: true,
                        ),
                        IconStepper(activeStepBorderPadding: 0,
                          lineLength: 100,
                          stepColor: lilas,
                          activeStepColor: roxo,
                          activeStepBorderColor: Colors.transparent,
                          lineColor: Colors.transparent,
                          enableNextPreviousButtons: false,
                          enableStepTapping: false,
                          activeStep: widget.progresso - 1 > 0
                              ? widget.progresso - 1
                              : 0,
                          stepRadius: 20,
                          stepReachedAnimationDuration:
                              const Duration(seconds: 2),
                          icons: [
                            Icon(
                              MdiIcons.trophy,
                              color: widget.progresso >= 1
                                  ? ouro
                                  : ouro.withOpacity(0.3),
                              size: 24,
                            ),
                            Icon(
                              MdiIcons.trophy,
                              color: widget.progresso >= 2
                                  ? ouro
                                  : ouro.withOpacity(0.3),
                              size: 32,
                            ),
                            Icon(
                              MdiIcons.trophy,
                              color: widget.progresso == 3
                                  ? ouro
                                  : ouro.withOpacity(0.3),
                              size: 40,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  CardProgress(
                    texto: widget.progresso1, 
                    isChecked: widget.progresso == 0
                          ? false
                          : widget.progresso == 1
                              ? true
                              : widget.progresso == 2
                                  ? true
                                  : widget.progresso == 3
                                      ? true
                                      : false,
                  ),
                  CardProgress(
                    texto: widget.progresso2, 
                    isChecked: widget.progresso == 0
                          ? false
                          : widget.progresso == 1
                              ? false
                              : widget.progresso == 2
                                  ? true
                                  : widget.progresso == 3
                                      ? true
                                      : false,
                  ),
                  CardProgress(
                    texto: widget.progresso3, 
                    isChecked: widget.progresso == 0
                          ? false
                          : widget.progresso == 1
                              ? false
                              : widget.progresso == 2
                                  ? false
                                  : widget.progresso == 3
                                      ? true
                                      : false,
                  ),
                  Hero(
                    tag: "botao",
                    child: TextButton(
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                            side: const BorderSide(color: primary)),
                        fixedSize: Size(size.width * 0.9, 50),
                      ),
                      child: const Text(
                        "Voltar",
                        style: TextStyle(
                            fontFamily: "PassionOne",
                            fontSize: 32,
                            color: primary),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            );
          })),
      borderRadius: BorderRadius.circular(9),
      child: Ink(
        width: size.width * 0.9,
        height: size.height * 0.1,
        decoration: BoxDecoration(
            color: widget.cor, borderRadius: BorderRadius.circular(9)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: AutoSizeText(
                  widget.titulo,
                  maxLines: 1,
                  style: TextStyle(
                    color: widget.progresso != 0
                        ? Colors.white
                        : Colors.white.withOpacity(0.4),
                    fontFamily: "BebasNeue",
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "PROGRESSO",
                      style: TextStyle(
                        color: widget.progresso != 0
                            ? Colors.white
                            : Colors.white.withOpacity(0.4),
                        fontFamily: "BebasNeue",
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Icon(
                          MdiIcons.trophy,
                          color: widget.progresso >= 1
                              ? ouro
                              : ouro.withOpacity(0.4),
                          size: 26,
                        ),
                        Icon(
                          MdiIcons.trophy,
                          color: widget.progresso >= 2
                              ? ouro
                              : ouro.withOpacity(0.4),
                          size: 32,
                        ),
                        Icon(
                          MdiIcons.trophy,
                          color: widget.progresso >= 3
                              ? ouro
                              : ouro.withOpacity(0.4),
                          size: 40,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
