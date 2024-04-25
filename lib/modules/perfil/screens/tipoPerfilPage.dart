import 'package:abntplaybic/core/redirectPage.dart';
import 'package:abntplaybic/modules/perfil/controller/perfilProvider.dart';
import 'package:abntplaybic/modules/perfil/controller/tipoPerfilController.dart';
import 'package:abntplaybic/modules/perfil/screens/codigoTurma.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:provider/provider.dart';
import 'package:abntplaybic/shared/colors.dart';
import 'package:flutter/material.dart';

import '../../home/pages/telas/tutorial_professor.dart';

class TipoPerfilPage extends StatefulWidget {
  const TipoPerfilPage({super.key});

  @override
  State<TipoPerfilPage> createState() => _TipoPerfilPageState();
}

class _TipoPerfilPageState extends State<TipoPerfilPage> {
  PerfilProvider provider = PerfilProvider();
  var mensagem = {
    PerfilTipo.profesor:
        "Como professor, você pode criar turmas para seus alunos utilizarem da plataforma, verificar erros e acertos de cada aluno, e liberar as atividades quando desejar",
    PerfilTipo.aluno:
        "Como aluno, você pode utilizar da plataforma de estudos e se quiser, ingressar numa turma e competir com seus amigos semanalmente no ranking da turma."
  };

  check(BuildContext context) async {
    PerfilTipo? value = await context.read<PerfilProvider>().getUser();
    print(value);
  }

  @override
  void initState() {
    super.initState();
  }

  PerfilTipo tipoSelected = PerfilTipo.aluno;
  TipoPerfilController controller = TipoPerfilController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 40),
          child: SingleChildScrollView(
            child: size.width < 768
                ? Column(
                    children: [
                      const Text(
                        "Que tipo de conta deseja utilizar?",
                        style:
                            TextStyle(fontFamily: "PassionOne", fontSize: 24),
                      ),
                      Container(
                          constraints: const BoxConstraints(maxWidth: 100),
                          margin: const EdgeInsets.symmetric(vertical: 20),
                          width: size.width * 0.65,
                          height: size.width * 0.65,
                          child: Image.asset(tipoSelected.index == 0
                              ? "src/images/quadro.png"
                              : "src/images/mesa.png")),
                      Opacity(
                        opacity: tipoSelected.index == 0 ? 1 : 0.15,
                        child: ListTile(
                          onTap: () {
                            setState(() {
                              tipoSelected = PerfilTipo.profesor;
                            });
                          },
                          title: const Text(
                            "Professor",
                            style: TextStyle(
                              fontFamily: "PassionOne",
                              fontSize: 32,
                              color: Colors.black,
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13),
                            side:
                                const BorderSide(color: Colors.black, width: 2),
                          ),
                          // tileColor: tipoSelected.index == 0
                          //     ? branco
                          //     : Colors.black.withOpacity(0.),
                          trailing: Radio<PerfilTipo>(
                            value: PerfilTipo.profesor,
                            groupValue: tipoSelected,
                            fillColor: MaterialStateProperty.all(primary),
                            onChanged: (val) {
                              if (val != null) {
                                setState(() {
                                  tipoSelected = val;
                                });
                              }
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Opacity(
                        opacity: tipoSelected.index == 1 ? 1 : 0.15,
                        child: ListTile(
                          onTap: () {
                            setState(() {
                              tipoSelected = PerfilTipo.aluno;
                            });
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13),
                            side:
                                const BorderSide(color: Colors.black, width: 2),
                          ),
                          title: const Text(
                            "Aluno",
                            style: TextStyle(
                              fontFamily: "PassionOne",
                              fontSize: 32,
                              color: Colors.black,
                            ),
                          ),
                          trailing: Radio<PerfilTipo>(
                            value: PerfilTipo.aluno,
                            groupValue: tipoSelected,
                            fillColor: MaterialStateProperty.all(primary),
                            onChanged: (val) {
                              if (val != null) {
                                setState(() {
                                  tipoSelected = val;
                                });
                              }
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Container(
                        height: (size.width - 20) * 0.55,
                        padding: const EdgeInsets.all(15),
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          border: Border.all(width: 2),
                          borderRadius: BorderRadius.circular(13),
                        ),
                        child: Text(
                          mensagem[tipoSelected]!,
                          style: const TextStyle(
                              fontFamily: "Montserrat",
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: primary,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(13)),
                          fixedSize: Size(size.width * 0.65, 62),
                        ),
                        child: const Text(
                          "Continuar",
                          style: TextStyle(
                              fontFamily: "PassionOne",
                              fontSize: 32,
                              color: Colors.white),
                        ),
                        onPressed: () async {
                          if (tipoSelected.index == 1) {
                            //Se for aluno
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const CodigoTurmaScreen()));
                          } else {
                            //Se for professor
                            var cancel = BotToast.showLoading();
                            await controller.setProfessor();
                            if (!mounted) return;
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const TutorialProfessorPage()),
                                (route) => true);
                            cancel();
                          }
                        },
                      )
                    ],
                  )
                : Column(
                    children: [
                      const Text(
                        "Que tipo de conta deseja utilizar?",
                        style:
                            TextStyle(fontFamily: "PassionOne", fontSize: 24),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              constraints: const BoxConstraints(maxWidth: 500),
                              width: size.width * 0.65,
                              child: Image.asset(tipoSelected.index == 0
                                  ? "src/images/quadro.png"
                                  : "src/images/mesa.png")),
                          const SizedBox(width: 20),
                          Column(
                            children: [
                              Opacity(
                                opacity: tipoSelected.index == 0 ? 1 : 0.15,
                                child: Container(
                                  constraints:
                                      const BoxConstraints(maxWidth: 500),
                                  width: size.width,
                                  child: ListTile(
                                    onTap: () {
                                      setState(() {
                                        tipoSelected = PerfilTipo.profesor;
                                      });
                                    },
                                    title: const Text(
                                      "Professor",
                                      style: TextStyle(
                                        fontFamily: "PassionOne",
                                        fontSize: 32,
                                        color: Colors.black,
                                      ),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(13),
                                      side: const BorderSide(
                                          color: Colors.black, width: 2),
                                    ),
                                    // tileColor: tipoSelected.index == 0
                                    //     ? branco
                                    //     : Colors.black.withOpacity(0.),
                                    trailing: Radio<PerfilTipo>(
                                      value: PerfilTipo.profesor,
                                      groupValue: tipoSelected,
                                      fillColor:
                                          MaterialStateProperty.all(primary),
                                      onChanged: (val) {
                                        if (val != null) {
                                          setState(() {
                                            tipoSelected = val;
                                          });
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Opacity(
                                opacity: tipoSelected.index == 1 ? 1 : 0.15,
                                child: Container(
                                  constraints:
                                      const BoxConstraints(maxWidth: 500),
                                  width: size.width,
                                  child: ListTile(
                                    onTap: () {
                                      setState(() {
                                        tipoSelected = PerfilTipo.aluno;
                                      });
                                    },
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(13),
                                      side: const BorderSide(
                                          color: Colors.black, width: 2),
                                    ),
                                    title: const Text(
                                      "Aluno",
                                      style: TextStyle(
                                        fontFamily: "PassionOne",
                                        fontSize: 32,
                                        color: Colors.black,
                                      ),
                                    ),
                                    trailing: Radio<PerfilTipo>(
                                      value: PerfilTipo.aluno,
                                      groupValue: tipoSelected,
                                      fillColor:
                                          MaterialStateProperty.all(primary),
                                      onChanged: (val) {
                                        if (val != null) {
                                          setState(() {
                                            tipoSelected = val;
                                          });
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 30),
                              Container(
                                constraints: BoxConstraints(
                                    maxWidth: 500, maxHeight: size.width * 0.5),
                                height: (size.height - 20) * 0.55,
                                padding: const EdgeInsets.all(15),
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                decoration: BoxDecoration(
                                  border: Border.all(width: 2),
                                  borderRadius: BorderRadius.circular(13),
                                ),
                                child: Text(
                                  mensagem[tipoSelected]!,
                                  style: const TextStyle(
                                      fontFamily: "Montserrat",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              const SizedBox(height: 20),
                              TextButton(
                                style: TextButton.styleFrom(
                                    backgroundColor: primary,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(13)),
                                    fixedSize: Size(size.width * 0.5, 62),
                                    maximumSize: const Size(500, 62)),
                                child: const Text(
                                  "Continuar",
                                  style: TextStyle(
                                      fontFamily: "PassionOne",
                                      fontSize: 32,
                                      color: Colors.white),
                                ),
                                onPressed: () async {
                                  if (tipoSelected.index == 1) {
                                    //Se for aluno
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const CodigoTurmaScreen()));
                                  } else {
                                    //Se for professor
                                    var cancel = BotToast.showLoading();
                                    await controller.setProfessor();
                                    if (!mounted) return;
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const TutorialProfessorPage()),
                                        (route) => true);
                                    cancel();
                                  }
                                },
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
