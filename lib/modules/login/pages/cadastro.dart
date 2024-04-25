import 'package:abntplaybic/modules/login/controllers/cadastroController.dart';
import 'package:abntplaybic/modules/perfil/screens/tipoPerfilPage.dart';
import 'package:abntplaybic/shared/colors.dart';
import 'package:abntplaybic/shared/components/dialogs/alerta.dart';
import 'package:abntplaybic/shared/validacoes.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  CadastroController controller = CadastroController();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  bool escondeSenha = true;
  FocusNode emailNode = FocusNode();
  FocusNode nomeNode = FocusNode();
  FocusNode senhaNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: _form,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      constraints: const BoxConstraints(maxWidth: 200),
                      width: size.width * 0.5,
                      child: Image.asset(
                        "src/images/coruja_login.png",
                      ),
                    ),
                    const Text(
                      "ABNT Play",
                      style: TextStyle(
                          fontFamily: "Righteous", color: roxo, fontSize: 40),
                    ),
                    const SizedBox(height: 50),
                    Center(
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 500),
                        child: Column(
                          children: [
                            Hero(
                              tag: "email",
                              child: Material(
                                child: TextFormField(
                                    cursorColor: primary,
                                    onFieldSubmitted: ((value) {
                                      nomeNode.requestFocus();
                                    }),
                                    focusNode: emailNode,
                                    textInputAction: TextInputAction.go,
                                    controller: controller.email,
                                    onChanged: ((value) {}),
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Digite um email válido";
                                      }

                                      if (!emailExp.hasMatch(value)) {
                                        return "Email inválido";
                                      }
                                      return null;
                                    },
                                    style: const TextStyle(
                                        fontFamily: "PassionOne",
                                        fontSize: 20, 
                                        color: primary),
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: const BorderSide(
                                              color: lilas, width: 3)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: const BorderSide(
                                              color: lilas, width: 3)),
                                      label: const Text("Email"),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                      hintText: "email@example.com",
                                    )),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                                cursorColor: primary,
                                focusNode: nomeNode,
                                controller: controller.nome,
                                keyboardType: TextInputType.name,
                                textInputAction: TextInputAction.go,
                                onFieldSubmitted: (value) {
                                  senhaNode.requestFocus();
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Digite um nome";
                                  }
                                  return null;
                                },
                                style: const TextStyle(
                                    fontFamily: "PassionOne", 
                                    fontSize: 20,
                                    color: primary),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: const BorderSide(
                                          color: lilas, width: 3)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: const BorderSide(
                                          color: lilas, width: 3)),
                                  label: const Text("Nome"),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                )),
                            const SizedBox(
                              height: 30,
                            ),
                            Hero(
                                tag: "senha",
                                child: Material(
                                  child: TextFormField(
                                      cursorColor: primary,
                                      focusNode: senhaNode,
                                      onFieldSubmitted: (value) {
                                        senhaNode.unfocus();
                                      },
                                      textInputAction: TextInputAction.done,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      controller: controller.senha,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Digite uma senha";
                                        }
                                        return null;
                                      },
                                      style: const TextStyle(
                                          fontFamily: "PassionOne",
                                          fontSize: 20, 
                                          color: primary),
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            borderSide: const BorderSide(
                                                color: lilas, width: 3)),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            borderSide: const BorderSide(
                                                color: lilas, width: 3)),
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              escondeSenha = !escondeSenha;
                                            });
                                          },
                                          icon: Icon(
                                            escondeSenha
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                            color: roxo,
                                          ),
                                        ),
                                        label: const Text("Senha"),
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.never,
                                      ),
                                      obscureText: escondeSenha),
                                )),
                            const SizedBox(height: 40),
                            Hero(
                                tag: "botao",
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                      backgroundColor: primary,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(13)),
                                      fixedSize: Size(size.width * 0.65, 62),
                                      maximumSize: Size(size.width * 0.65, 62)),
                                  child: const Text(
                                    "Cadastrar",
                                    style: TextStyle(
                                        fontFamily: "PassionOne",
                                        fontSize: 32,
                                        color: Colors.white),
                                  ),
                                  onPressed: () async {
                                    CancelFunc? cancel;
                                    try {
                                      if (_form.currentState!.validate()) {
                                        cancel = BotToast.showLoading();
                                        await controller.criarConta();

                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const TipoPerfilPage()),
                                            (route) => false);

                                        cancel();
                                      }
                                    } on FirebaseAuthException catch (e) {
                                      if (cancel != null) {
                                        cancel();
                                      }
                                      switch (e.code) {
                                        case "weak-password":
                                          alertaApp(context,
                                              "A senha precisa ter ao menos 6 caracteres");
                                          break;
                                        case "email-already-in-use":
                                          alertaApp(context,
                                              "Esse email já está em uso!");
                                          break;
                                        default:
                                          alertaApp(context, "Ocorreu um erro");
                                      }
                                      debugPrint(e.code);
                                    }
                                  },
                                )),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Já possui conta?",
                                  style: TextStyle(
                                    fontFamily: "PassionOne",
                                    fontSize: 20,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(
                                      context,
                                    );
                                  },
                                  child: const Text(
                                    "Login",
                                    style: TextStyle(
                                        fontFamily: "PassionOne",
                                        fontSize: 20,
                                        color: primary),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                    child: size.width < 768 ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset("src/images/cefet.png", 
                          width: size.width * .17,
                        ),
                        Image.asset("src/images/profept.png", 
                          width: size.width * .19,
                        ),
                        Image.asset("src/images/fapemig.png", 
                          width: size.width * .19,
                        ),
                        Image.asset("src/images/cnpq.png", 
                          width: size.width * .19,
                        ),
                      ],
                    ) : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Image.asset("src/images/cefet.png", 
                            width: 100,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Image.asset("src/images/profept.png", 
                            width: 130,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Image.asset("src/images/fapemig.png", 
                            width: 125,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Image.asset("src/images/cnpq.png", 
                            width: 100,
                          ),
                        ),
                      ],
                    ), 
                  ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
