import 'package:abntplaybic/modules/perfil/controller/perfilProvider.dart';
import 'package:abntplaybic/modules/perfil/models/perfilProfessor.dart';
import 'package:abntplaybic/modules/turma/controller/criarTurmaController.dart';
import 'package:abntplaybic/modules/turma/models/alfabeto.dart';
import 'package:abntplaybic/modules/turma/screens/conteudosTurma.dart';
import 'package:abntplaybic/shared/colors.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CriarTurmaScreen extends StatefulWidget {
  const CriarTurmaScreen({super.key});

  @override
  State<CriarTurmaScreen> createState() => _CriarTurmaScreenState();
}

class _CriarTurmaScreenState extends State<CriarTurmaScreen> {
  CriarTurmaController controller = CriarTurmaController();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  LabeledGlobalKey<ConteudoTurmaState> keyConteudo =
      LabeledGlobalKey<ConteudoTurmaState>("topicos");
  String code = "";
  bool? validID;
  gerarID() {
    for (int i = 0; i < 6; i++) {
      var alf = alfabeto();
      alf.shuffle();
      code = code + (alf.first);
    }

    controller.codigo.text = code;
    checkID();
  }

  Future<bool> checkID([update = false]) async {
    validID = null;
    setState(() {});

    validID = !(await FirebaseFirestore.instance
        .collection("turma")
        .doc(code)
        .get()
        .then((value) {
      return value.exists;
    }));

    setState(() {});
    if (!validID! && update) {
      gerarID();
      validID = await checkID();
    }
    return validID!;
  }

  @override
  void initState() {
    super.initState();
    gerarID();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        elevation: 2,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: primary,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Criar Turma",
          style: TextStyle(fontFamily: "Righteous", color: roxo, fontSize: 30),
        ),
      ),
      body: Form(
        key: _form,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10),
              //Código field
              SizedBox(
                height: 70,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 5),
                      width: size.width * 0.15,
                      child: const Text(
                        "Código:",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: "BebasNeue",
                            fontSize: 20,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.7,
                      child: TextFormField(
                        style: const TextStyle(
                                        fontFamily: "PassionOne",
                                        fontSize: 20, 
                                        color: primary),
                        cursorColor: primary,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (val) {
                          if (val!.length < 6 || val.length > 6) {
                            return "O código precisa conter 6 dígitos";
                          } else if (validID == false) {
                            return "Esse código já está em uso";
                          }

                          return null;
                        },
                        maxLength: 6,
                        onChanged: (val) {
                          if (val.length < 6) {
                            setState(() {
                              validID = false;
                            });
                          } else {
                            code = val;
                            checkID(false);
                          }
                          controller.codigo.text = val.toUpperCase();
                          controller.codigo.selection = TextSelection.collapsed(
                              offset: controller.codigo.text.length);
                        },
                        textCapitalization: TextCapitalization.sentences,
                        controller: controller.codigo,
                        enabled: validID == null ? false : true,
                        decoration: InputDecoration(
                          counterText: "",
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: primary),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                const BorderSide(color: primary, width: 2),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                        height: size.width * 0.05,
                        width: size.width * 0.05,
                        child: validID == null
                            ? const CircularProgressIndicator(
                                color: primary,
                              )
                            : Icon(validID! ? Icons.check : Icons.close)),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              //Nome Field
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 5),
                    width: size.width * 0.15,
                    child: const Text(
                      "Nome:",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: "BebasNeue",
                          fontSize: 20,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.7,
                    child: TextFormField(
                      style: const TextStyle(
                                        fontFamily: "PassionOne",
                                        fontSize: 20, 
                                        color: primary),
                      cursorColor: primary,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return "Digite um nome";
                        }
                        return null;
                      },
                      maxLength: 10,
                      textCapitalization: TextCapitalization.words,
                      controller: controller.nome,
                      decoration: InputDecoration(
                        counterText: "",
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: primary),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              const BorderSide(color: primary, width: 2),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.width * 0.05,
                    width: size.width * 0.05,
                  )
                ],
              ),
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(15, 0, 0, 8),
                      child: Text(
                        "Tarefas Disponíveis",
                        style: TextStyle(
                          color: preto,
                          fontFamily: "BebasNeue",
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              ConteudoTurma(key: keyConteudo),
              const SizedBox(height: 10),
              //Botao
              TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: primary,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13)),
                    fixedSize: Size(size.width * 0.65, 62),
                  ),
                  child: const Text(
                    "Criar",
                    style: TextStyle(
                        fontFamily: "PassionOne",
                        fontSize: 32,
                        color: Colors.white),
                  ),
                  onPressed: () async {
                    if (!mounted) return;
                    if (_form.currentState!.validate()) {
                      var cancel = BotToast.showLoading();
                      await controller
                          .criarTurma(keyConteudo.currentState!.checkeds);
                      await (context.read<PerfilProvider>().perfilAtual
                              as PerfilProfessor)
                          .getTurmas();
                      cancel();
                      if (!mounted) return;

                      Navigator.pop(context);
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
