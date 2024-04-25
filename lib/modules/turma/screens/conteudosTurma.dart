import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:abntplaybic/shared/colors.dart';
import 'package:flutter/material.dart';

class ConteudoTurma extends StatefulWidget {
  ConteudoTurma({super.key, this.conteudos});
  Map<String, List<bool>>? conteudos;

  @override
  State<ConteudoTurma> createState() => ConteudoTurmaState();
}

class ConteudoTurmaState extends State<ConteudoTurma> {
  late Future<List<QueryDocumentSnapshot<Map>>> getTopicos;
  Map<String, List<bool>> checkeds = {};
  Map<String, Future<List<QueryDocumentSnapshot<Map>>>> subFuture = {};

  Future<List<QueryDocumentSnapshot<Map>>> _getTopicos() async {
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs =
        await FirebaseFirestore.instance
            .collection("topicos")
            .get()
            .then((value) => value.docs);

    checkeds = widget.conteudos ?? {for (var value in docs) value.id: []};
    if (widget.conteudos != null) {
      for (var value in docs) {
        checkeds[value.id] = widget.conteudos![value.id] ?? [];
      }
    } else {
      checkeds = {for (var value in docs) value.id: []};
    }
    print(checkeds);
    getSubTopicos(docs);
    return docs;
  }

  Future<List<QueryDocumentSnapshot<Map>>> getSubTopicos(
      List<QueryDocumentSnapshot<Map>> docs) async {
    subFuture = {};
    for (var i = 0; i < docs.length; i++) {
      subFuture[docs[i].id] = (FirebaseFirestore.instance
          .collection("topicos")
          .doc(docs[i].id)
          .collection("subTopicos")
          .orderBy("indice")
          .get()
          .then((value) {
        if (widget.conteudos == null) {
          checkeds[docs[i].id] =
              List.generate(value.docs.length, (index) => true);
        }
        setState(() {});
        return value.docs;
      }));
    }

    // checkeds = List.generate(docs.length, (index) => []);
    return docs;
  }

  @override
  void initState() {
    super.initState();

    getTopicos = _getTopicos();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(12),
      ),
      child: FutureBuilder<List<QueryDocumentSnapshot<Map>>>(
          future: getTopicos,
          builder: (context, snap) {
            return snap.hasData
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        ...(snap.data!.map((element) {
                          return Theme(
                            data: ThemeData(
                                colorScheme: const ColorScheme(
                                    brightness: Brightness.light,
                                    primary: primary,
                                    onPrimary: primary,
                                    secondary: lilas,
                                    onSecondary: lilas,
                                    error: vermelho,
                                    onError: vermelho,
                                    background: preto,
                                    onBackground: preto,
                                    surface: preto,
                                    onSurface: preto)),
                            child: ExpansionTile(
                              onExpansionChanged: (val) {
                                print(element.data());
                                // print(checkeds[element.id]!
                                //     .every((element) => element == true));
                              },
                              title: Container(
                                  child: Row(
                                children: [
                                  Checkbox(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4)),
                                      activeColor: lilas,
                                      tristate: true,
                                      value: checkeds[element.id]?.isEmpty ??
                                              true
                                          ? false
                                          : checkeds[element.id]!.every(
                                                  (element) => element == true)
                                              ? true
                                              : checkeds[element.id]!.every(
                                                      (element) =>
                                                          element == false)
                                                  ? false
                                                  : null,
                                      onChanged: (val) {
                                        setState(() {
                                          if (checkeds[element.id] == null) {}
                                          checkeds[element.id] =
                                              checkeds[element.id]!
                                                  .map((e) => val ?? false)
                                                  .toList();
                                        });
                                      }),
                                  AutoSizeText(
                                    element["titulo"]
                                                .toString()
                                                .split(" ")
                                                .length <=
                                            2
                                        ? element["titulo"]
                                        : element["titulo"]
                                            .toString()
                                            .substring(element["titulo"]
                                                .toString()
                                                .indexOf(
                                                    ' ',
                                                    element["titulo"]
                                                            .toString()
                                                            .indexOf(' ') +
                                                        1)),
                                    maxLines: 1,
                                  )
                                ],
                              )),
                              children: [
                                FutureBuilder<List<QueryDocumentSnapshot<Map>>>(
                                  future: subFuture[element.id],
                                  builder: (context, snapSub) => Container(
                                    // child: Text(snapSub.data.toString())
                                    margin: const EdgeInsets.only(left: 50),
                                    child: snapSub.hasData
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: snapSub.data!
                                                .map((e) => Row(
                                                      children: [
                                                        Checkbox(
                                                            value: checkeds[
                                                                        element
                                                                            .id]!
                                                                    .isEmpty
                                                                ? false
                                                                : checkeds[element
                                                                        .id]![
                                                                    snapSub
                                                                        .data!
                                                                        .indexOf(
                                                                            e)],
                                                            // value: true,
                                                            onChanged: (val) {
                                                              setState(() {
                                                                checkeds[element
                                                                        .id]![
                                                                    snapSub
                                                                        .data!
                                                                        .indexOf(
                                                                            e)] = val ??
                                                                    false;
                                                              });
                                                            }),
                                                        Text(e
                                                            .data()["nomeTema"])
                                                      ],
                                                    ))
                                                .toList())
                                        : Center(
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
                                          ),
                                  ),
                                )
                              ],
                            ),
                          );
                        }))
                      ])
                : Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: const LinearProgressIndicator(
                        color: primary,
                        backgroundColor: lilas,
                      ),
                    ),
                  );
          }),
    );
  }
}

class TopicoTile extends StatefulWidget {
  const TopicoTile(this.titulo, this.reference, {super.key});
  final String titulo;
  final QueryDocumentSnapshot reference;

  @override
  State<TopicoTile> createState() => _TopicoTileState();
}

class _TopicoTileState extends State<TopicoTile> {
  Future<List<QueryDocumentSnapshot<Map>>> getSubTopicos(String id) async {
    var docs = await FirebaseFirestore.instance
        .collection("topicos")
        .doc(id)
        .collection("subTopicos")
        .get()
        .then((value) => value.docs);
    return docs;
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
