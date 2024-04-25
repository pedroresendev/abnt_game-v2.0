import 'package:abntplaybic/modules/perfil/models/perfilProfessor.dart';
import 'package:abntplaybic/modules/turma/controller/editarTurmaController.dart';
import 'package:abntplaybic/modules/turma/models/turma.dart';
import 'package:abntplaybic/modules/turma/screens/conteudosTurma.dart';
import 'package:abntplaybic/shared/colors.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../perfil/controller/perfilProvider.dart';

class EditarTurmaPage extends StatefulWidget {
  EditarTurmaPage(this.turma, {super.key});
  Turma turma;
  @override
  State<EditarTurmaPage> createState() => _EditarTurmaPageState();
}

class _EditarTurmaPageState extends State<EditarTurmaPage> {
  TextEditingController codigo = TextEditingController();
  TextEditingController nome = TextEditingController();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  GlobalKey<ConteudoTurmaState> keyConteudo = GlobalKey<ConteudoTurmaState>();
  EditarTurmaController controller = EditarTurmaController();
  @override
  void initState() {
    super.initState();
    codigo.text = widget.turma.id;
    nome.text = widget.turma.nome;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(
      //   shadowColor: Colors.transparent,
      //   elevation: 2,
      //   backgroundColor: Colors.white,
      //   leading: IconButton(
      //     icon: const Icon(Icons.arrow_back),
      //     color: primary,
      //     onPressed: () {
      //       Navigator.pop(context);
      //     },
      //   ),
      //   title: const Text(
      //     "Editar Turma",
      //     style: TextStyle(fontFamily: "Righteous", color: roxo, fontSize: 30),
      //   ),
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _form,
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
                        width: size.width * 0.8,
                        child: TextFormField(
                          style: const TextStyle(
                                        fontFamily: "PassionOne",
                                        fontSize: 20, 
                                        color: primary),
                          cursorColor: primary,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          maxLength: 6,
                          textCapitalization: TextCapitalization.sentences,
                          controller: codigo,
                          enabled: false,
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
                      width: size.width * 0.8,
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
                        controller: nome,
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
                  ],
                ),
                const SizedBox(height: 20),
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
                            color: prata,
                            fontFamily: "BebasNeue",
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    Icon(Icons.help_outlined, color: prata)
                  ],
                ),
                ConteudoTurma(
                  key: keyConteudo,
                  conteudos: widget.turma.topicosAtivos.map((key, value) =>
                      MapEntry(key, value.map((e) => e as bool).toList())),
                ),
                //Botao
                TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: primary,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13)),
                      fixedSize: Size(size.width * 0.65, 62),
                    ),
                    child: const Text(
                      "Salvar",
                      style: TextStyle(
                          fontFamily: "PassionOne",
                          fontSize: 32,
                          color: Colors.white),
                    ),
                    onPressed: () async {
                      if (!mounted) return;
                      if (_form.currentState!.validate()) {
                        var cancel = BotToast.showLoading();
                        widget.turma.mudarTopicos =
                            keyConteudo.currentState!.checkeds;
                        widget.turma.mudarNome = nome.text;
                        await controller.updateTurma(widget.turma);

                        await (context.read<PerfilProvider>().perfilAtual
                                as PerfilProfessor)
                            .getTurmas();
                        print(widget.turma.topicosAtivos);
                        print(widget.turma.nome);
                        cancel();
                        if (!mounted) return;

                        Navigator.pop(context);
                      }
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
