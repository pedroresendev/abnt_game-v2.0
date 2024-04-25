import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class TelaSubtopicos extends StatefulWidget {
  final Widget corpo;
  final String descricao;

  const TelaSubtopicos(
      {super.key,
      required this.corpo,
      required this.descricao});

  @override
  State<TelaSubtopicos> createState() => _TelaSubtopicosState();
}

class _TelaSubtopicosState extends State<TelaSubtopicos> {
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scrollbar(
      child: SingleChildScrollView(
          child: size.width < 768
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: size.width,
                      constraints: BoxConstraints(minHeight: size.height * 0.4),
                      padding: const EdgeInsets.only(top: 30),
                      child: Align(
                        alignment: Alignment.center,
                        child: widget.corpo,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        constraints: BoxConstraints(
                          maxWidth: size.width * 0.9,
                          minHeight: size.height * 0.19,
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                            ),
                            borderRadius: BorderRadius.circular(10)),
                        child: AutoSizeText(
                          widget.descricao,
                          style: const TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                  ],
                )
              : Column(
                  children: [
                    SizedBox(
                      height: size.height - 50,
                      //padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: size.width * 0.35,
                            //constraints:
                            //BoxConstraints(minHeight: size.height * 0.4),
                            //padding: const EdgeInsets.only(top: 30),
                            child: Align(
                              alignment: Alignment.center,
                              child: widget.corpo,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              constraints: BoxConstraints(
                                maxWidth: size.width * 0.45,
                                minHeight: size.height * 0.19,
                              ),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                  ),
                                  borderRadius: BorderRadius.circular(10)),
                              child: AutoSizeText(
                                widget.descricao,
                                style: const TextStyle(
                                  fontFamily: "Montserrat",
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
    );
  }
}
