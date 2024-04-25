import 'package:abntplaybic/core/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp( // Inicializa o Firebase com as opções padrões. Await é usado para "obrigar" que a inicialização do Firebase ocorra antes de prosseguir com o código.
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp()); // Inicializa o aplicativo. MyApp é o widget raiz do aplicativo localizado no arquivo app.dart.
}
