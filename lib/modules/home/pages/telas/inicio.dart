import 'package:abntplaybic/modules/home/controllers/topicosController.dart';
import 'package:abntplaybic/modules/perfil/controller/perfilProvider.dart';
import 'package:abntplaybic/modules/perfil/models/perfilAluno.dart';
import 'package:abntplaybic/shared/colors.dart';
import 'package:abntplaybic/shared/components/botoes/botao_inicio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'informacao.dart';

class InicioPage extends StatefulWidget {
  const InicioPage({super.key});

  @override
  State<InicioPage> createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> {
  final TopicosController _topicosController = TopicosController();
  bool loading = false; 
  List<Map<String, String>> listaTopicos = []; // Declara uma lista dos tópicos.

  @override
  void initState() {
    super.initState(); // chama o método initState da classe pai.
    getTopicos(); //Chama o método getTopicos.
  }

  getTopicos() async {
    if (mounted) { // Verifica se o widget está montado.
      setState(() { 
        loading = true; // Define loading como true. Indica que os dados estão sendo carregados.
      });
    }
    listaTopicos = await _topicosController.getTopicos(); // chama o método getTopicos do _topicosController e aguarda a resposta. O resultado é então atribuído à variável listaTopicos.

    if (context.read<PerfilProvider>().perfilAtual.runtimeType == PerfilAluno) { // Verifica se o perfil atual é de um aluno.
      var aluno = (context.read<PerfilProvider>().perfilAtual as PerfilAluno); // Atribui o perfil atual a uma variável aluno.
      if (aluno.turma != null) {
        listaTopicos.sort((a, b) {
          aluno.turma!.topicosAtivos;
          if (aluno.turma!.topicosAtivos[b["id"]]?.contains(true) ?? true) { // Verifica se o tópico b está ativo.
            return 1;
          } else {
            return -1;
          }
        });
      }
    }
    setState(() { // Atualiza o estado do widget.
      loading = false;
    });
  }

  @override
  void dispose() { // Método chamado quando o widget é removido da árvore de widgets.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute( 
                      builder: (context) => const InformacaoPage())); // Navega para a página de informações.
            }, 
            icon: Icon(Icons.info_outline, color: primary, size: 35,)
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Align(
                alignment: Alignment.bottomLeft,
                child:
                    Consumer<PerfilProvider>(builder: (context, value, child) { // Cria um Consumer que escuta mudanças no perfil do usuário.
                  return value.perfilAtual.runtimeType == PerfilAluno // Verifica se o perfil atual é de um aluno.
                      ? Text.rich(
                          TextSpan(
                            text:
                                "${(value.perfilAtual as PerfilAluno).xpAtual} ", // Define o texto do span. O texto é a quantidade de xp atual do aluno.
                            style: const TextStyle(
                                fontFamily: "BebasNeue",
                                color: verde,
                                fontSize: 25),
                            children: const [
                              TextSpan(
                                  text: "XP",
                                  style: TextStyle(
                                      fontFamily: "BebasNeue",
                                      color: verde,
                                      fontSize: 15))
                            ],
                          ),
                        )
                      : Container();
                }),
              ),
            )
          ],
          shadowColor: Colors.transparent,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            "ABNT Play",
            style:
                TextStyle(fontFamily: "Righteous", color: roxo, fontSize: 40),
          ),
        ),
        body: !loading && listaTopicos.isNotEmpty // Verifica se os dados estão carregados e se a lista de tópicos não está vazia.
            ? Column( // Caso a condição seja verdadeira, exibe uma coluna.
                children: [
                  // const Padding(
                  //   padding: EdgeInsets.symmetric(horizontal: 20),
                  //   child: CardNotificacao(),
                  // ),

                  Expanded(
                    flex: 9,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: GridView.builder(
                        itemCount: listaTopicos.length, // Define a quantidade de itens.
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount( // Define o layout.
                            childAspectRatio: 1 / 1.28, // Define a proporção do item.
                            crossAxisCount:
                                (MediaQuery.of(context).size.width / 200) 
                                            .round() < 2
                                    ? 2
                                    : (MediaQuery.of(context).size.width / 200)
                                        .round(),
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20),
                        /*itemCount: listaTopicos.length % 2 == 0
                            ? listaTopicos.length ~/ 2
                            : listaTopicos.length ~/ 2 + 1,*/
                        itemBuilder: ((context, index) { // Constroi cada item
                          return BotaoInicio( // BotãoInicio é cada item da lista. Ou seja, cada aula é um "BotãoInicio"
                            data: listaTopicos.elementAt(index),
                            desbloqueado: context
                                    .read<PerfilProvider>() // Obtém o perfil atual do usuário.
                                    .perfilAtual is PerfilAluno 
                                ? (context.read<PerfilProvider>().perfilAtual 
                                                as PerfilAluno)
                                            .turma !=
                                        null // Se for aluno, verifica se o aluno tem turma (turma != null).
                                    ? (context 
                                                .read<PerfilProvider>()
                                                .perfilAtual as PerfilAluno)
                                            .turma! // Confirma que o aluno tem turma.
                                            .topicosAtivos[listaTopicos[index] // Acessa os tópicos ativos da turma e encontra os tópicos com o id correspondente ao id do tópico atual.
                                                ["id"]]
                                            ?.contains(true) ??
                                        true
                                    : true
                                : true,
                          );
                          /*index > 0 && index + j < listaTopicos.length
                              ? index = index + j
                              : null;
                          j++;
                          listaTopicos.length > index + 1 && (index + 1) % 2 != 0
                              ? j
                              : j = 0;
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                BotaoInicio(
                                  data: listaTopicos.length > index &&
                                          index % 2 == 0
                                      ? listaTopicos.elementAt(index)
                                      : <String, String>{"titulo": ""},
                                  desbloqueado: (context
                                              .read<PerfilProvider>()
                                              .perfilAtual as PerfilAluno)
                                          .turma
                                          ?.topicosAtivos[listaTopicos[index]
                                              ["id"]]!
                                          .contains(true) ??
                                      true,
                                ),
                                BotaoInicio(
                                  data: listaTopicos.length > index + 1 &&
                                          (index + 1) % 2 != 0
                                      ? listaTopicos.elementAt(index + 1)
                                      : <String, String>{"titulo": ""},
                                  desbloqueado: listaTopicos.length > index + 1 &&
                                          (index + 1) % 2 != 0
                                      ? (context
                                                  .read<PerfilProvider>()
                                                  .perfilAtual as PerfilAluno)
                                              .turma
                                              ?.topicosAtivos[
                                                  listaTopicos[index + 1]["id"]]!
                                              .contains(true) ??
                                          true
                                      : true,
                                ),
                              ],
                            ),
                          );*/
                        }),
                      ),
                    ),
                  ),
                ],
              )
            : Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: const LinearProgressIndicator(
                    color: primary,
                    backgroundColor: lilas,
                  ),
                ),
              ));
  }
}
