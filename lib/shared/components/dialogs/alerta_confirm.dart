import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../colors.dart';

alertaConfirmaApp(BuildContext context, String message, Function() funcaoConfirma,
    [String buttonText1 = "Cancelar", String buttonText2 = "Confirmar"]) {
  var size = MediaQuery.of(context).size;
  showDialog(
      context: context,
      builder: (context) => Dialog(
            backgroundColor: branco,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(13),
                side: const BorderSide(color: primary, width: 3)),
            child: Container(
              width: size.width * 0.9,
              height: size.width * 0.6,
              constraints: BoxConstraints(
                minWidth: size.width * 0.9,
                minHeight: size.width * 0.6,
              ),
              padding: const EdgeInsets.only(
                  top: 10, left: 10, right: 10, bottom: 10),
              child: Column(
                //mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: Text(message,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontFamily: "PassionOne",
                              fontSize: 32,
                              color: primary)),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: primary,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(13)),
                          fixedSize: Size(size.width * 0.21, 40),
                        ),
                        child: Text(
                          buttonText1,
                          style: const TextStyle(
                              fontFamily: "PassionOne",
                              fontSize: 20,
                              color: Colors.white),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: primary,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(13)),
                            fixedSize: Size(size.width * 0.25, 40),
                          ),
                          onPressed: funcaoConfirma,
                          child: Text(
                            buttonText2,
                            style: const TextStyle(
                                fontFamily: "PassionOne",
                                fontSize: 20,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ));
}
