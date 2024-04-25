import 'package:abntplaybic/shared/colors.dart';
import 'package:flutter/material.dart';

class CardPerfil extends StatefulWidget {
  final String title;
  final String text;
  final Color bgcolor;

  const CardPerfil(
      {super.key,
      required this.title,
      required this.text,
      required this.bgcolor});

  @override
  State<CardPerfil> createState() => _CardPerfilState();
}

class _CardPerfilState extends State<CardPerfil> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width < 768 ? size.width * 0.4 : size.width * 0.28,
      height: size.height * 0.11,
      decoration: BoxDecoration(
        color: widget.bgcolor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            widget.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: "BebasNeue",
              fontSize: 16,
            ),
          ),
          Text(
            widget.text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: ouro,
              fontFamily: "BebasNeue",
              fontSize: 35,
            ),
          ),
        ],
      ),
    );
  }
}
