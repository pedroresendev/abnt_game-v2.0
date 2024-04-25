import 'package:abntplaybic/core/redirectPage.dart';
import 'package:abntplaybic/modules/atividades/controller/atividadeController.dart';
import 'package:abntplaybic/modules/perfil/controller/perfilProvider.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) { // Retorna um MaterialApp com o tema padrão e o widget RedirectPage como página inicial.
    return MultiProvider(
      providers: [ // Cria uma lista de providers para serem usados no aplicativo.
        ChangeNotifierProvider(create: (_) => PerfilProvider()), // Cria um provider para o PerfilProvider.
        ChangeNotifierProvider(create: (_) => AtividadeController()) // Cria um provider para o AtividadeController.
      ],
      child: MaterialApp(
        builder: BotToastInit(),
        navigatorObservers: [BotToastNavigatorObserver()],
        debugShowCheckedModeBanner: false,
        title: 'ABNT Play',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const RedirectPage(), // Define a página inicial do aplicativo.
      ),
    );
  }
}
