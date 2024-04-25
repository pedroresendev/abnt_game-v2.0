import 'package:abntplaybic/shared/colors.dart';
import 'package:flutter/material.dart';

class BackButtonNormas extends StatelessWidget {
  Function? onPressed;
  BackButtonNormas({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 45, 15, 10),
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: primary,
              width: 3,
            ),
          ),
          child: Center(
            child: IconButton(
              onPressed: () {
                if (onPressed != null) {
                  print("function");
                  onPressed!();
                } else {
                  Navigator.pop(context);
                }
              },
              color: primary,
              icon: const Icon(
                Icons.arrow_back,
                size: 28,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
