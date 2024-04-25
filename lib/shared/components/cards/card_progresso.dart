import 'package:abntplaybic/shared/colors.dart';
import 'package:abntplaybic/shared/components/botoes/custom_checkbox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CardProgress extends StatefulWidget {
  final String texto;
  final bool isChecked;

  const CardProgress({super.key, required this.texto, required this.isChecked});

  @override
  State<CardProgress> createState() => _CardProgressState();
}

class _CardProgressState extends State<CardProgress> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(23, 0, 23, 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.texto,
            style: TextStyle(
              color: lilas,
              fontFamily: "BebasNeue",
              fontSize: 20,
            ),
          ),
          CustomCheckbox(
            isChecked: widget.isChecked,
            selectedColor: lilas,
            borderColor: primary,
            checkIcon: MdiIcons.trophy,
            selectedIconColor: ouro,
          )
        ],
      ),
    );
  }
}
