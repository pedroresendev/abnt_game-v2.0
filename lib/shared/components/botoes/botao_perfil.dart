import 'package:abntplaybic/modules/login/pages/login.dart';
import 'package:abntplaybic/shared/colors.dart';
import 'package:abntplaybic/shared/components/dialogs/alerta_confirm.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class BotaoPerfil extends StatefulWidget {
  final Function() funcaoBotao;
  final IconData icone;
  final String text;
  final Color bgcolor;

  const BotaoPerfil(
      {super.key,
      required this.funcaoBotao,
      required this.icone,
      required this.text,
      required this.bgcolor});

  @override
  State<BotaoPerfil> createState() => _BotaoPerfilState();
}

class _BotaoPerfilState extends State<BotaoPerfil> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ElevatedButton.icon(
        icon: Icon(widget.icone),
        onPressed: widget.funcaoBotao,
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.bgcolor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        label: Text(
          widget.text,
          style: const TextStyle(
            fontFamily: "BebasNeue",
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
