import 'package:abntplaybic/modules/atividades/controller/atividadeController.dart';
import 'package:abntplaybic/modules/atividades/pages/carregaAtividadesPage.dart';
import 'package:abntplaybic/modules/atividades/pages/subtopicos_tela.dart';
import 'package:abntplaybic/modules/home/controllers/topicosController.dart';
import 'package:abntplaybic/modules/perfil/controller/perfilProvider.dart';
import 'package:abntplaybic/modules/perfil/models/perfil.dart';
import 'package:abntplaybic/modules/perfil/models/perfilAluno.dart';
import 'package:abntplaybic/modules/perfil/models/perfilProfessor.dart';
import 'package:abntplaybic/shared/colors.dart';
import 'package:abntplaybic/shared/components/dialogs/alerta.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainAtividadesPage extends StatefulWidget {
  final Map<String, String> data;

  const MainAtividadesPage({super.key, required this.data});

  @override
  State<MainAtividadesPage> createState() => _MainAtividadesPageState();
}

class _MainAtividadesPageState extends State<MainAtividadesPage> {
  final TopicosController _topicosController = TopicosController();
  bool loading = false;
  List<Map> listaSubTopicos = [];

  @override
  void initState() {
    super.initState();
    getTopicos();
  }

  getTopicos() async {
    setState(() {
      loading = true;
    });

    listaSubTopicos =
        await _topicosController.getSubTopicos(widget.data["id"]!);

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Perfil perfil = Provider.of<PerfilProvider>(context).perfilAtual!;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          color: roxo,
          icon: const Icon(
            Icons.arrow_back,
            size: 32,
          ),
        ),
        title: AutoSizeText(
          widget.data["titulo"]!, // Título do tópico.
          style: const TextStyle(
            color: roxo,
            fontFamily: "PassionOne",
            fontSize: 20,
          ),
          maxLines: 1,
        ),
        titleSpacing: 0,
      ),
      body: SizedBox(
        height: size.height,
        child: !loading && listaSubTopicos.isNotEmpty // Se não estiver carregando e a lista de subtópicos não estiver vazia.
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Expanded(
                  //   child: Container(
                  //     width: size.width,
                  //     height: size.height * 0.19,
                  //     decoration: const BoxDecoration(
                  //       color: lilas,
                  //     ),
                  //     /*child: Image.asset( ),*/
                  //   ),
                  // ),
                  Expanded(
                    flex: 5,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 10),
                      child: ListView.builder(
                        itemCount: listaSubTopicos.length, // Quantidade de subtópicos.
                        itemBuilder: (context, index) { // Criação de cada subtópico.
                          return InkWell(
                            onTap: () {
                              bool feitoAula = false;
                              bool feitoTarefa = false;
                              if (perfil is PerfilAluno) { // Se o perfil for de aluno.
                                if (perfil.turma != null) { // Se o aluno estiver em uma turma.
                                  if (!perfil.turma?.topicosAtivos[ 
                                      widget.data["id"]!]![index]) { // Se o tópico não estiver ativo.
                                    alertaApp(context,
                                        "Essa tarefa não está disponível");
                                    return;
                                  }
                                }
                                feitoAula = perfil.feitos?[ // Verifica se a aula foi feita.
                                                listaSubTopicos[index]
                                                    ["idTopico"]]
                                            ?[listaSubTopicos[index]["id"]]
                                        ?["aula"] ??
                                    false; // Se não foi feita, retorna false.
                                feitoTarefa = perfil.feitos?[ // Verifica se a tarefa foi feita.
                                                listaSubTopicos[index]
                                                    ["idTopico"]]
                                            ?[listaSubTopicos[index]["id"]]
                                        ?["tarefa"] ??
                                    false; // Se não foi feita, retorna false.
                              }

                              showModalBottomSheet( // Mostra um modal com as opções de continuar a tarefa ou aula.
                                  constraints:
                                      const BoxConstraints(maxWidth: 700),
                                  shape: const RoundedRectangleBorder( // Borda do modal.
                                    borderRadius: BorderRadius.vertical( // Borda arredondada.
                                      top: Radius.circular(25),
                                    ),
                                  ),
                                  context: context,
                                  builder: (context) { // Conteúdo do modal.
                                    return SizedBox(
                                      // height: size.height * 0.35,
                                      child: SingleChildScrollView(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      10, 20, 10, 0),
                                              child: AutoSizeText(
                                                "Tarefa ${listaSubTopicos.elementAt(index)['nomeTema']} em ${widget.data["titulo"]!}", // Título da tarefa.
                                                maxLines: 1,
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: "PassionOne",
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            const Padding(
                                              padding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 20),
                                            ),
                                            feitoAula ||
                                                    perfil is PerfilProfessor // Verifica se a aula foi feita ou se o perfil é de professor.
                                                ? Padding( // Se for, mostra o botão de continuar a tarefa.
                                                  padding: const EdgeInsets.symmetric(
                                                    horizontal: 30
                                                  ),
                                                  child: TextButton(
                                                      style: TextButton.styleFrom(
                                                        backgroundColor: primary,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(13),
                                                        ),
                                                        fixedSize: Size(
                                                            size.width * 0.9, 50),
                                                      ),
                                                      child: Text(
                                                        context
                                                                        .read<
                                                                            AtividadeController>()
                                                                        .idSubTopico ==
                                                                    listaSubTopicos[
                                                                            index]
                                                                        ["id"] && // Verifica se o id do subtópico é o mesmo que o id do subtópico atual.
                                                                context
                                                                        .read<
                                                                            AtividadeController>()
                                                                        .idTopico ==
                                                                    widget.data[
                                                                        "id"] && !feitoTarefa // Verifica se o id do tópico é o mesmo que o id do tópico atual e se a tarefa não foi feita.
                                                            ? "Continuar Tarefa"
                                                            : feitoTarefa // verifica se a tarefa foi feita.
                                                                ? "Refazer tarefa"
                                                                : "Iniciar Tarefa",
                                                        style: const TextStyle(
                                                            fontFamily:
                                                                "PassionOne",
                                                            fontSize: 32,
                                                            color: Colors.white),
                                                      ),
                                                      onPressed: () async {
                                                        Navigator.pop(context);
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) => CarregaAtividadesPage(
                                                                    listaSubTopicos[
                                                                            index]
                                                                        [
                                                                        "idTopico"],
                                                                    listaSubTopicos[
                                                                            index]
                                                                        ["id"])));
                                                      },
                                                    ),
                                                )
                                                : Container(),
                                            const SizedBox(height: 10),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(
                                                    horizontal: 30
                                                  ),
                                              child: TextButton(
                                                style: feitoAula
                                                    ? TextButton.styleFrom(
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(13),
                                                            side:
                                                                const BorderSide(
                                                                    color:
                                                                        primary)),
                                                        fixedSize: Size(
                                                            size.width * 0.9, 50),
                                                      )
                                                    : TextButton.styleFrom(
                                                        backgroundColor: primary,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(13),
                                                        ),
                                                        fixedSize: Size(
                                                            size.width * 0.9, 50),
                                                      ),
                                                child: Text(
                                                  feitoAula
                                                      ? "Refazer aula"
                                                      : "Iniciar aula",
                                                  style: TextStyle(
                                                      fontFamily: "PassionOne",
                                                      fontSize: 32,
                                                      color: feitoAula
                                                          ? primary
                                                          : Colors.white),
                                                ),
                                                onPressed: () async {
                                                  Navigator.pop(context);
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              SubTopicosPage( // Página das aulas
                                                                topicoAtual:
                                                                    listaSubTopicos[
                                                                        index],
                                                              )));
                                                },
                                              ),
                                            ),
                                            const SizedBox(height: 20)
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            },
                            child: ListTile(
                              title: Text(
                                listaSubTopicos.elementAt(index)["nomeTema"],
                                style: TextStyle(
                                  fontFamily: "PassionOne",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: perfil is PerfilAluno
                                      ? perfil.turma?.topicosAtivos[
                                                  widget.data["id"]!]![index] ??
                                              true
                                          ? Colors.black
                                          : prata
                                      : Colors.black,
                                ),
                              ),
                              trailing: Icon(
                                Icons.arrow_forward_ios,
                                color: perfil is PerfilAluno
                                    ? perfil.turma?.topicosAtivos[
                                                widget.data["id"]!]![index] ??
                                            true
                                        ? Colors.black
                                        : prata
                                    : Colors.black,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              )
            : listaSubTopicos.isEmpty && !loading
                ? Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 20, vertical: size.height * 0.4),
                    child: const AutoSizeText(
                      "Não há subtópicos cadastrados com este nome!",
                      maxLines: 1,
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: "PassionOne",
                          fontSize: 36,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                : Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: const LinearProgressIndicator(
                        color: primary,
                        backgroundColor: lilas,
                      ),
                    ),
                  ),
      ),
    );
  }
}
