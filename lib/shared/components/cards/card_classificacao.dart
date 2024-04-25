import 'package:abntplaybic/shared/colors.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class CardClassificacao extends StatefulWidget {
  final int classificacao;
  final String nome;
  final String pontuacao;
  final String userAvatarUrl;
  bool? isUser;

  CardClassificacao(
      {super.key,
      required this.classificacao,
      required this.nome,
      this.isUser = false,
      required this.pontuacao, 
      required this.userAvatarUrl});

  @override
  State<CardClassificacao> createState() => _CardClassificacaoState();
}

class _CardClassificacaoState extends State<CardClassificacao> {
  Future<String> _getDownloadUrl(String url) async {
    final ref = FirebaseStorage.instance.refFromURL(url);
    final downloadUrl = await ref.getDownloadURL();
    
    return downloadUrl;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Card(
      elevation: 0,
      color: widget.isUser == true ? lilas : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        radius: 200,
        onTap: () {},
        borderRadius: BorderRadius.circular(8),
        highlightColor: const Color.fromARGB(255, 243, 207, 243),
        splashColor: lilas.withAlpha(50),
        child: ListTile(
          leading: SizedBox(
            // width: size.width * 0.46,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Text(
                    widget.classificacao.toString(),
                    style: TextStyle(
                        fontFamily: "BebasNeue",
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                        color: widget.classificacao == 1
                            ? ouro
                            : widget.classificacao == 2
                                ? prata
                                : widget.classificacao == 3
                                    ? bronze
                                    : roxoClassificacao),
                  ),
                ),
                CircleAvatar(
                  radius: 22,
                  backgroundColor: widget.classificacao == 1
                            ? ouro
                            : widget.classificacao == 2
                                ? prata
                                : widget.classificacao == 3
                                    ? bronze
                                    : roxoClassificacao,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: lilas,
                    child: FutureBuilder<String>(
                      future: _getDownloadUrl(widget.userAvatarUrl ?? ""),
                      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting){
                            return const LinearProgressIndicator(
                              color: primary,
                              backgroundColor: lilas,
                            );
                        }
                          
                        if (snapshot.hasError)
                          return Icon(Icons.error); // Error indicator

                        return CircleAvatar(
                          backgroundImage: NetworkImage(snapshot.data ?? ""),
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: AutoSizeText(
                    widget.nome,
                    maxLines: 1,
                    style: const TextStyle(
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w900,
                        fontSize: 20),
                  ),
                )
              ],
            ),
          ),
          trailing: AutoSizeText(
            "${widget.pontuacao} XP",
            maxLines: 1,
            style: const TextStyle(
                fontFamily: "Montserrat",
                fontWeight: FontWeight.w900,
                fontSize: 20),
          ),
        ),
      ),
    );
  }
}
