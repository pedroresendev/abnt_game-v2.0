import 'package:abntplaybic/modules/atividades/pages/principal.dart';
import 'package:abntplaybic/shared/colors.dart';
import 'package:abntplaybic/shared/components/dialogs/alerta.dart';
import 'package:flutter/material.dart';

class BotaoInicio extends StatefulWidget {
  final Map<String, String> data;
  final bool desbloqueado;
  const BotaoInicio({super.key, required this.data, this.desbloqueado = true});

  @override
  State<BotaoInicio> createState() => _BotaoInicioState();
}

class _BotaoInicioState extends State<BotaoInicio> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return widget.data["titulo"] != "" // Verifica se o título é diferente de vazio.
        ? Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
            height: 180,
            width: 140,
            child: ElevatedButton(
              onPressed: () => widget.desbloqueado
                  ? Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MainAtividadesPage( //Se estiver desbloqueado, ao clicar, o usuário é redirecionado para a página do tópico.
                            // titulo: widget.texto,
                            data: widget.data),
                      ),
                    )
                  : alertaApp(
                      context, "Seu professor não liberou essa atividade"),
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.desbloqueado ? const Color.fromARGB(255, 122, 13, 122) : prata, // Cinza para bloqueado e roxo para desbloqueado.
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                shadowColor: Colors.black, // Cor da sombra
                elevation: 10,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(height: 10), // Espaço no topo
                  Image.asset('src/images/livro.png', width: 80, height: 80),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 18),
                    child: Text(
                      widget.data["titulo"]!,
                      textAlign: TextAlign.center, 
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ))
        : const SizedBox(
            height: 180,
            width: 140,
          );
  }
}
