import 'package:abntplaybic/modules/atividades/pages/finalLicao.dart';
import 'package:abntplaybic/modules/atividades/pages/ganhaXP.dart';
import 'package:abntplaybic/modules/home/controllers/topicosController.dart';
import 'package:abntplaybic/modules/home/models/model_tema.dart';
import 'package:abntplaybic/modules/perfil/models/perfilAluno.dart';
import 'package:abntplaybic/shared/colors.dart';
import 'package:abntplaybic/shared/components/normas/back_button.dart';
import 'package:abntplaybic/shared/components/normas/subtopicos.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../perfil/controller/perfilProvider.dart';

class SubTopicosPage extends StatefulWidget {
  final String? topico;
  final String? subTopico;
  final Map topicoAtual;

  const SubTopicosPage(
      {super.key, required this.topicoAtual, this.topico, this.subTopico});

  @override
  State<SubTopicosPage> createState() => _SubTopicosPageState();
}

class _SubTopicosPageState extends State<SubTopicosPage>
    with TickerProviderStateMixin {
  final PageController _pageController = PageController(initialPage: 0);
  final TopicosController _topicosController = TopicosController();
  final TickerProvider provider = TickerProviderImpl();
  late TabController? _tabController;
  int selectedIndex = 0;
  bool loading = true;
  List<Widget> lista = [];
  List<Tema> listaTemas = [];
  List<Future<String>?> images = [];
  double indicatorSize = 16;
  double chevronSize = 32;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 1, vsync: this);
    getTopicos();
  }

  @override
  void dispose() {
    _topicosController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  getTopicos() async {
    listaTemas = await _topicosController.getAllAulasSubTopicos(
        widget.topicoAtual["idTopico"], widget.topicoAtual["id"]);
    for (var item in listaTemas) {
      if (item.conteudo.toString().startsWith("gs:")) {
        getImage(item.conteudo);
      } else {
        images.add(null);
      }
    }
    _tabController = TabController(
        length: listaTemas.isNotEmpty ? listaTemas.length : 1, vsync: this);

    if (listaTemas.length >= 10) {
      indicatorSize = 10;
      chevronSize = 28;
    }

    if (listaTemas.length >= 12) {
      indicatorSize = 6;
      chevronSize = 28;
    }

    if (mounted) {
      setState(() {
        loading = false;
      });
    }
  }

  Future<void> getImage(String url) async {
    images.add(FirebaseStorage.instance.refFromURL(url).getDownloadURL());
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(
      children: [
        !loading && listaTemas.isNotEmpty
            ? Column(
                children: [
                  Expanded(
                    flex: 8,
                    child: PageView.builder( // PageView para passar entre os conteúdos
                        controller: _pageController,
                        onPageChanged: (int page) { // Quando a página muda, muda o índice do TabController
                          setState(() {
                            selectedIndex = page;
                            _tabController!.index = page;
                          });
                        },
                        itemCount: listaTemas.length, // O número de conteúdos deve ser igual ao número de temas
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              AppBar(
                                toolbarHeight: 50,
                                centerTitle: true,
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                                leading: null,
                                title: Text(
                                  listaTemas
                                      .elementAt(index)
                                      .titulo
                                      .toUpperCase(), // Título do tema
                                  style: const TextStyle(
                                      fontFamily: "PassionOne",
                                      fontSize: 36,
                                      color: preto),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Expanded(
                                child: TelaSubtopicos(
                                  corpo: listaTemas
                                          .elementAt(index)
                                          .conteudo
                                          .toString()
                                          .startsWith("gs:") // "gs" é o iníco do caminho da imagem no Firebase Storage
                                      ? FutureBuilder<String>(
                                          future: images[index],
                                          builder: (context, snap) {
                                            if (snap.hasData) {
                                              return Container(
                                                  constraints:
                                                      const BoxConstraints(
                                                          maxWidth: 550),
                                                  width: size.width * 0.75,
                                                  child: Image.network(
                                                      snap.data!));
                                            } else {
                                              return Center(
                                                child: SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.5,
                                                  child:
                                                      const LinearProgressIndicator(
                                                    color: primary,
                                                    backgroundColor: lilas,
                                                  ),
                                                ),
                                              );
                                            }
                                          })
                                      : Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                listaTemas
                                                    .elementAt(index)
                                                    .conteudo
                                                    .replaceAll("\\n", "\n"), // Conteúdo do tema
                                                style: const TextStyle(
                                                    fontFamily: "PassionOne",
                                                    fontSize: 5),
                                              ),
                                            ],
                                          ),
                                        ),
                                  descricao: listaTemas
                                      .elementAt(index)
                                      .descricao
                                      .replaceAll("\\n", "\n"), // Descrição do tema
                                ),
                              ),
                            ],
                          );
                        }),
                  ),
                ],
              )
            : listaTemas.isEmpty && !loading
                ? Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 20, vertical: size.height * 0.36),
                    child: const AutoSizeText(
                      "Não há tema cadastrado com este nome!",
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
        Positioned(top: 10, child: BackButtonNormas()),
        _tabController != null
            ? Positioned(
                bottom: 3,
                left: 3,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(40, 10, 40, 0),
                  child: SizedBox(
                    width: size.width,
                    height: size.height * 0.06,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: IconButton(
                            onPressed: () {
                              if (selectedIndex + 1 > 1) {
                                _pageController.animateToPage(selectedIndex - 1,
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.ease);
                                setState(() {
                                  _tabController!.index = selectedIndex;
                                });
                              }
                            },
                            icon: Icon(
                              Icons.chevron_left,
                              size: chevronSize,
                              color: selectedIndex + 1 > 1
                                  ? primary
                                  : Colors.transparent,
                            ),
                            splashColor: selectedIndex + 1 > 1
                                ? null
                                : Colors.transparent,
                            highlightColor: selectedIndex + 1 > 1
                                ? null
                                : Colors.transparent,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Center(
                            child: TabPageSelector(
                              controller: _tabController,
                              color: lilas,
                              selectedColor: roxo,
                              borderStyle: BorderStyle.none,
                              indicatorSize: indicatorSize,
                            ),
                          ),
                        ),
                        Expanded(
                        flex: 1,
                        child: IconButton(
                          onPressed: selectedIndex + 1 < _tabController!.length
                              ? () {
                                  _pageController.animateToPage(selectedIndex + 1,
                                      duration: const Duration(milliseconds: 500),
                                      curve: Curves.ease);
                                  setState(() {
                                    _tabController!.index = selectedIndex;
                                  });
                                }
                              : () {
                                  // Redireciona para a página de atividades
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => FinalLicaoPage(
                                              widget.topicoAtual["idTopico"],
                                              widget.topicoAtual["id"]))
                                  );
                                },
                          icon: Icon(
                            selectedIndex + 1 < _tabController!.length
                                ? Icons.chevron_right
                                : Icons.assignment, // Ícone para a página de atividades
                            size: chevronSize,
                            color: primary,
                          ),
                          splashColor: null,
                          highlightColor: null,
                        ),
                      ),
                      ],
                    ),
                  ),
                ),
              )
            : Container(),
      ],
    ));
  }
}
