import 'package:abntplaybic/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CardNotificacao extends StatefulWidget {
  const CardNotificacao({super.key});

  @override
  State<CardNotificacao> createState() => _CardNotificacaoState();
}

class _CardNotificacaoState extends State<CardNotificacao> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {
          
        },
        splashColor: lilas.withOpacity(0.3),
        highlightColor: roxo.withOpacity(0.1),
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(
              color: roxo,
              width: 3,
            ) 
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 3, horizontal: 15),
          title: Text(
            "Sumário - Geral",
            style: TextStyle(
              color: roxo,
              fontSize: 20,
              fontFamily: "Montserrat",
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: Icon(
            Icons.notifications,
            color: roxo,
            size: 35,
          ),
          tileColor: lilas,
        ),
      ),
    );
  }
}
