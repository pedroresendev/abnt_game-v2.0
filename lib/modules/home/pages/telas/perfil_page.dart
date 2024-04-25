import 'package:abntplaybic/modules/home/controllers/editController.dart';
import 'package:abntplaybic/modules/home/pages/telas/editar_perfil.dart';
import 'package:abntplaybic/modules/login/pages/login.dart';
import 'package:abntplaybic/modules/perfil/controller/perfilProvider.dart';

import 'package:abntplaybic/modules/perfil/models/perfilAluno.dart';
import 'package:abntplaybic/modules/perfil/screens/codigoTurma.dart';
import 'package:abntplaybic/shared/colors.dart';
import 'package:abntplaybic/shared/components/botoes/botao_perfil.dart';
import 'package:abntplaybic/shared/components/cards/card_perfil.dart';
import 'package:abntplaybic/shared/components/dialogs/alerta_confirm.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  EditController controller = EditController();

  Future<String?> getImage() async {
    return await FirebaseStorage.instance
        .ref("/users/img-default.jpg")
        .getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            //height: size.height,
            child: Center(
              child: size.width < 768
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Container(
                                width: 160,
                                height: 160,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: primary, width: 2),
                                ),
                                child: context
                                            .watch<PerfilProvider>()
                                            .perfilAtual
                                            ?.fotoPerfil ==
                                        null
                                    ? FutureBuilder<String?>(
                                        future: getImage(),
                                        builder: (context, snap) {
                                          return snap.hasData
                                              ? ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                  child: Image.network(
                                                      fit: BoxFit.cover,
                                                      context
                                                              .read<
                                                                  PerfilProvider>()
                                                              .perfilAtual
                                                              ?.fotoPerfil ??
                                                          snap.data!),
                                                )
                                              : Center(
                                                  child: SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.25,
                                                    child:
                                                        const LinearProgressIndicator(
                                                      color: primary,
                                                      backgroundColor: lilas,
                                                    ),
                                                  ),
                                                );
                                        })
                                    : ClipRRect(
                                        borderRadius: BorderRadius.circular(6),
                                        child: Image.network(
                                            fit: BoxFit.cover,
                                            context
                                                .read<PerfilProvider>()
                                                .perfilAtual!
                                                .fotoPerfil!,
                                            frameBuilder: (context, child,
                                                frame, wasSynchronouslyLoaded) {
                                          return child;
                                        }, loadingBuilder: (context, child,
                                                loadingProgress) {
                                          if (loadingProgress == null) {
                                            return child;
                                          } else {
                                            int? expTam;
                                            int? dowTam;
                                            expTam = loadingProgress
                                                .expectedTotalBytes;
                                            dowTam = loadingProgress
                                                .cumulativeBytesLoaded;
                                            if (expTam != null) {
                                              var porcentagem =
                                                  (dowTam / expTam).toDouble() *
                                                      100;
                                              var porcString = porcentagem
                                                  .toStringAsFixed(1);

                                              return Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.25,
                                                    child:
                                                        LinearProgressIndicator(
                                                      value: porcentagem / 100,
                                                      color: primary,
                                                      backgroundColor: lilas,
                                                    ),
                                                  ),
                                                  Text(
                                                    "$porcString%",
                                                    style: const TextStyle(
                                                      color: primary,
                                                      fontFamily: "PassionOne",
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              );
                                            } else {
                                              return child;
                                            }
                                          }
                                        }),
                                      )),
                            AutoSizeText(
                              context.watch<PerfilProvider>().perfilAtual!.nome,
                              style: const TextStyle(
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.bold,
                                fontSize: 33,
                              ),
                              maxLines: 1,
                            ),
                            Consumer<PerfilProvider>(
                                builder: (context, value, child) {
                              return value.perfilAtual.runtimeType ==
                                      PerfilAluno
                                  ? Text.rich(
                                      TextSpan(
                                        text:
                                            "${(value.perfilAtual as PerfilAluno).xpAtual} ",
                                        style: const TextStyle(
                                          fontFamily: "BebasNeue",
                                          color: verde,
                                          fontSize: 25,
                                        ),
                                        children: [
                                          const TextSpan(
                                            text: "XP",
                                            style: TextStyle(
                                              fontFamily: "BebasNeue",
                                              color: verde,
                                              fontSize: 15,
                                            ),
                                          ),
                                          const TextSpan(
                                            text: "  -  ",
                                            style: TextStyle(
                                              fontFamily: "BebasNeue",
                                              color: Colors.black,
                                              fontSize: 16,
                                            ),
                                          ),
                                          TextSpan(
                                            text: value.perfilAtual
                                                        .runtimeType ==
                                                    PerfilAluno
                                                ? (value.perfilAtual
                                                                as PerfilAluno)
                                                            .rankingAtual !=
                                                        0
                                                    ? "${(value.perfilAtual as PerfilAluno).rankingAtual} º"
                                                    : "  º"
                                                : " - º",
                                            style: TextStyle(
                                              fontFamily: "BebasNeue",
                                              color: value.perfilAtual
                                                          .runtimeType ==
                                                      PerfilAluno
                                                  ? (value.perfilAtual
                                                                  as PerfilAluno)
                                                              .rankingAtual ==
                                                          1
                                                      ? amarelo
                                                      : (value.perfilAtual
                                                                      as PerfilAluno)
                                                                  .rankingAtual ==
                                                              2
                                                          ? prata
                                                          : (value.perfilAtual
                                                                          as PerfilAluno)
                                                                      .rankingAtual ==
                                                                  3
                                                              ? bronze
                                                              : roxoClassificacao
                                                  : prata,
                                              fontSize: 16,
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  : Container();
                            }),
                          ],
                        ),
                        //const SizedBox(height: 40),

                        // const SizedBox(height: 40),
                        Consumer<PerfilProvider>(
                            builder: (context, value, child) {
                          return value.perfilAtual.runtimeType == PerfilAluno
                              ? Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 40),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(15, 0, 0, 8),
                                        child: Text(
                                          "ESTATÍSTICAS",
                                          style: TextStyle(
                                            color: prata,
                                            fontFamily: "BebasNeue",
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          CardPerfil(
                                            title: "MELHOR\nRANKING",
                                            text: (value.perfilAtual
                                                            as PerfilAluno)
                                                        .melhorRanking ==
                                                    0
                                                ? "-"
                                                : "${(value.perfilAtual as PerfilAluno).melhorRanking} º",
                                            bgcolor: laranja,
                                          ),
                                          CardPerfil(
                                            title: "XP\nCOLETADO",
                                            text:
                                                "${(value.perfilAtual as PerfilAluno).xpTotal} ",
                                            bgcolor: azul,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              : Container();
                        }),
                        Consumer<PerfilProvider>(builder: (context, perfil, _) {
                          if (perfil.perfilAtual is PerfilAluno) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.fromLTRB(15, 0, 0, 8),
                                  child: Text(
                                    "Minha Turma",
                                    style: TextStyle(
                                      color: prata,
                                      fontFamily: "BebasNeue",
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    width: size.width * 0.9,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(9),
                                      color: const Color(0xffE5EA12)
                                          .withOpacity(0.6),
                                    ),
                                    child: (perfil.perfilAtual as PerfilAluno)
                                                .turma !=
                                            null
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  (perfil.perfilAtual
                                                          as PerfilAluno)
                                                      .turma!
                                                      .nome,
                                                  style: TextStyle(
                                                    fontFamily: "BebasNeue",
                                                    fontSize: 40,
                                                    color: primary
                                                        .withOpacity(0.6),
                                                  )),
                                              Text(
                                                "${(perfil.perfilAtual as PerfilAluno).turma!.quantParticipantes} participantes",
                                                style: TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 16,
                                                  color: preto.withOpacity(0.8),
                                                ),
                                              ),
                                              Text(
                                                "Professor(a) ${(perfil.perfilAtual as PerfilAluno).turma!.profNome}",
                                                style: TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 16,
                                                  color: preto.withOpacity(0.8),
                                                ),
                                              )
                                            ],
                                          )
                                        : Center(
                                            child: InkWell(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const CodigoTurmaScreen()));
                                            },
                                            child: const SizedBox(
                                                height: 100,
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Expanded(
                                                      child: FittedBox(
                                                        fit: BoxFit.contain,
                                                        child: Text(
                                                            "Ingressar em uma turma",
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  "BebasNeue",
                                                              color: lilas,
                                                            )),
                                                      ),
                                                    ),
                                                    Icon(
                                                        Icons.arrow_forward_ios,
                                                        color: lilas,
                                                        size: 35)
                                                  ],
                                                )),
                                          )))
                              ],
                            );
                          }
                          return Container();
                        }),
                        const SizedBox(height: 40),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.fromLTRB(15, 0, 0, 1),
                              child: Text(
                                "MINHA CONTA",
                                style: TextStyle(
                                  color: prata,
                                  fontFamily: "BebasNeue",
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 12),
                                    child: BotaoPerfil(
                                      funcaoBotao: () {
                                        alertaConfirmaApp(context,
                                            "Você tem certeza de que deseja sair?",
                                            () async {
                                          // await FirebaseAuth.instance.signOut();
                                          context
                                              .read<PerfilProvider>()
                                              .logout();
                                          if (!mounted) return;
                                          Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                              builder: ((context) =>
                                                  const LoginPage()),
                                            ),
                                            ((route) => false),
                                          );
                                        });
                                      },
                                      icone: Icons.logout,
                                      text: "SAIR",
                                      bgcolor: vermelho,
                                    ),
                                  ),
                                  BotaoPerfil(
                                    funcaoBotao: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: ((context) =>
                                              const EditarPerfilPage()),
                                        ),
                                      );
                                    },
                                    icone: Icons.edit,
                                    text: "EDITAR PERFIL",
                                    bgcolor: amarelo,
                                  ),
                                  /*BotaoPerfil(
                              funcaoBotao: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: ((context) =>
                                        const CriarAtividade()),
                                  ),
                                );
                              },
                              icone: Icons.add,
                              text: "Criar Atividade",
                              bgcolor: verde,
                            ),*/
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  //Desktop
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                          SizedBox(
                            width: size.width * 0.35,
                            child: Column(
                              children: [
                                Container(
                                    width: 160,
                                    height: 160,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border:
                                          Border.all(color: primary, width: 2),
                                    ),
                                    child: context
                                                .watch<PerfilProvider>()
                                                .perfilAtual
                                                ?.fotoPerfil ==
                                            null
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            child: Image.asset(
                                                fit: BoxFit.cover,
                                                "src/images/img-default.jpg"),
                                          )
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            child: Image.network(
                                                fit: BoxFit.cover,
                                                context
                                                    .read<PerfilProvider>()
                                                    .perfilAtual!
                                                    .fotoPerfil!,
                                                frameBuilder: (context,
                                                    child,
                                                    frame,
                                                    wasSynchronouslyLoaded) {
                                              return child;
                                            }, loadingBuilder: (context, child,
                                                    loadingProgress) {
                                              if (loadingProgress == null) {
                                                return child;
                                              } else {
                                                int? expTam;
                                                int? dowTam;
                                                expTam = loadingProgress
                                                    .expectedTotalBytes;
                                                dowTam = loadingProgress
                                                    .cumulativeBytesLoaded;
                                                if (expTam != null) {
                                                  var porcentagem =
                                                      (dowTam / expTam)
                                                              .toDouble() *
                                                          100;
                                                  var porcString = porcentagem
                                                      .toStringAsFixed(1);

                                                  return Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.25,
                                                        child:
                                                            LinearProgressIndicator(
                                                          value:
                                                              porcentagem / 100,
                                                          color: primary,
                                                          backgroundColor:
                                                              lilas,
                                                        ),
                                                      ),
                                                      Text(
                                                        "$porcString%",
                                                        style: const TextStyle(
                                                          color: primary,
                                                          fontFamily:
                                                              "PassionOne",
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                } else {
                                                  return child;
                                                }
                                              }
                                            }),
                                          )),
                                AutoSizeText(
                                  context
                                      .watch<PerfilProvider>()
                                      .perfilAtual!
                                      .nome,
                                  style: const TextStyle(
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 33,
                                  ),
                                  maxLines: 1,
                                ),
                                Consumer<PerfilProvider>(
                                    builder: (context, value, child) {
                                  return value.perfilAtual.runtimeType ==
                                          PerfilAluno
                                      ? Text.rich(
                                          TextSpan(
                                            text:
                                                "${(value.perfilAtual as PerfilAluno).xpAtual} ",
                                            style: const TextStyle(
                                              fontFamily: "BebasNeue",
                                              color: verde,
                                              fontSize: 25,
                                            ),
                                            children: [
                                              const TextSpan(
                                                text: "XP",
                                                style: TextStyle(
                                                  fontFamily: "BebasNeue",
                                                  color: verde,
                                                  fontSize: 15,
                                                ),
                                              ),
                                              const TextSpan(
                                                text: "  -  ",
                                                style: TextStyle(
                                                  fontFamily: "BebasNeue",
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              TextSpan(
                                                text: value.perfilAtual
                                                            .runtimeType ==
                                                        PerfilAluno
                                                    ? (value.perfilAtual
                                                                    as PerfilAluno)
                                                                .rankingAtual !=
                                                            0
                                                        ? "${(value.perfilAtual as PerfilAluno).rankingAtual} º"
                                                        : "  º"
                                                    : " - º",
                                                style: TextStyle(
                                                  fontFamily: "BebasNeue",
                                                  color: value.perfilAtual
                                                              .runtimeType ==
                                                          PerfilAluno
                                                      ? (value.perfilAtual
                                                                      as PerfilAluno)
                                                                  .rankingAtual ==
                                                              1
                                                          ? amarelo
                                                          : (value.perfilAtual
                                                                          as PerfilAluno)
                                                                      .rankingAtual ==
                                                                  2
                                                              ? prata
                                                              : (value.perfilAtual
                                                                              as PerfilAluno)
                                                                          .rankingAtual ==
                                                                      3
                                                                  ? bronze
                                                                  : roxoClassificacao
                                                      : prata,
                                                  fontSize: 16,
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      : Container();
                                }),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Consumer<PerfilProvider>(
                                  builder: (context, value, child) {
                                return value.perfilAtual.runtimeType ==
                                        PerfilAluno
                                    ? SizedBox(
                                        width: size.width * 0.6,
                                        // padding: const EdgeInsets.symmetric(
                                        //     vertical: 40),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  15, 0, 0, 8),
                                              child: Text(
                                                "ESTATÍSTICAS",
                                                style: TextStyle(
                                                  color: prata,
                                                  fontFamily: "BebasNeue",
                                                  fontSize: 20,
                                                ),
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                CardPerfil(
                                                  title: "MELHOR\nRANKING",
                                                  text: (value.perfilAtual
                                                                  as PerfilAluno)
                                                              .melhorRanking ==
                                                          0
                                                      ? "-"
                                                      : "${(value.perfilAtual as PerfilAluno).melhorRanking} º",
                                                  bgcolor: laranja,
                                                ),
                                                CardPerfil(
                                                  title: "XP\nCOLETADO",
                                                  text:
                                                      "${(value.perfilAtual as PerfilAluno).xpTotal} ",
                                                  bgcolor: azul,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    : Container();
                              }),
                              const SizedBox(height: 40),
                              Consumer<PerfilProvider>(
                                  builder: (context, perfil, _) {
                                if (perfil.perfilAtual is PerfilAluno) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(15, 0, 0, 8),
                                        child: Text(
                                          "Minha Turma",
                                          style: TextStyle(
                                            color: prata,
                                            fontFamily: "BebasNeue",
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                      Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 10),
                                          width: size.width * 0.6,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(9),
                                            color: const Color(0xffE5EA12)
                                                .withOpacity(0.6),
                                          ),
                                          child: (perfil.perfilAtual
                                                          as PerfilAluno)
                                                      .turma !=
                                                  null
                                              ? Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                        (perfil.perfilAtual
                                                                as PerfilAluno)
                                                            .turma!
                                                            .nome,
                                                        style: TextStyle(
                                                          fontFamily:
                                                              "BebasNeue",
                                                          fontSize: 40,
                                                          color: primary
                                                              .withOpacity(0.6),
                                                        )),
                                                    Text(
                                                      "${(perfil.perfilAtual as PerfilAluno).turma!.quantParticipantes} participantes",
                                                      style: TextStyle(
                                                        fontFamily:
                                                            "Montserrat",
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 16,
                                                        color: preto
                                                            .withOpacity(0.8),
                                                      ),
                                                    ),
                                                    Text(
                                                      "Professor(a) ${(perfil.perfilAtual as PerfilAluno).turma!.profNome}",
                                                      style: TextStyle(
                                                        fontFamily:
                                                            "Montserrat",
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 16,
                                                        color: preto
                                                            .withOpacity(0.8),
                                                      ),
                                                    )
                                                  ],
                                                )
                                              : Center(
                                                  child: InkWell(
                                                  onTap: () {
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                const CodigoTurmaScreen()));
                                                  },
                                                  child: const SizedBox(
                                                      height: 100,
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Expanded(
                                                            child: FittedBox(
                                                              fit: BoxFit
                                                                  .contain,
                                                              child: Text(
                                                                  "Ingressar em uma turma",
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        "BebasNeue",
                                                                    color:
                                                                        lilas,
                                                                  )),
                                                            ),
                                                          ),
                                                          Icon(
                                                              Icons
                                                                  .arrow_forward_ios,
                                                              color: lilas,
                                                              size: 35)
                                                        ],
                                                      )),
                                                )))
                                    ],
                                  );
                                }
                                return Container();
                              }),
                              const SizedBox(height: 40),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.fromLTRB(15, 0, 0, 1),
                                    child: Text(
                                      "MINHA CONTA",
                                      style: TextStyle(
                                        color: prata,
                                        fontFamily: "BebasNeue",
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 12),
                                          child: BotaoPerfil(
                                            funcaoBotao: () {
                                              alertaConfirmaApp(context,
                                                  "Você tem certeza de que deseja sair?",
                                                  () async {
                                                // await FirebaseAuth.instance.signOut();
                                                context
                                                    .read<PerfilProvider>()
                                                    .logout();
                                                if (!mounted) return;
                                                Navigator.pushAndRemoveUntil(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: ((context) =>
                                                        const LoginPage()),
                                                  ),
                                                  ((route) => false),
                                                );
                                              });
                                            },
                                            icone: Icons.logout,
                                            text: "SAIR",
                                            bgcolor: vermelho,
                                          ),
                                        ),
                                        BotaoPerfil(
                                          funcaoBotao: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: ((context) =>
                                                    const EditarPerfilPage()),
                                              ),
                                            );
                                          },
                                          icone: Icons.edit,
                                          text: "EDITAR PERFIL",
                                          bgcolor: amarelo,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ]),
            ),
          ),
        ),
      ),
    );
  }
}
