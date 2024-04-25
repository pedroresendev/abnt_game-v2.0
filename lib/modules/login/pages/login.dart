import 'package:abntplaybic/modules/home/pages/indexProf.dart';
import 'package:abntplaybic/modules/login/controllers/loginController.dart';
import 'package:abntplaybic/modules/perfil/controller/perfilProvider.dart';
import 'package:abntplaybic/modules/perfil/screens/tipoPerfilPage.dart';
import 'package:abntplaybic/shared/components/dialogs/alerta.dart';
import 'package:abntplaybic/modules/login/pages/cadastro.dart';
import 'package:abntplaybic/modules/home/pages/index.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:abntplaybic/shared/colors.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginController controller = LoginController();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  bool escondeSenha = true;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
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
                    child: Center(
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 500),
                        child: Column(children: [
                          Hero(
                            tag: "email",
                            child: Material(
                              child: TextFormField(
                                  cursorColor: primary,
                                  controller: controller.email,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Digite um email válido";
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
                                        borderRadius: BorderRadius.circular(12),
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
                          Hero(
                            tag: "senha",
                            child: Material(
                              child: TextFormField(
                                  cursorColor: primary,
                                  controller: controller.senha,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Informe sua senha";
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
                                        borderRadius: BorderRadius.circular(12),
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
                            ),
                          ),
                          const SizedBox(height: 40),
                          Hero(
                            tag: "botao",
                            child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: primary,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(13)),
                                fixedSize: Size(size.width * 0.65, 62),
                              ),
                              child: const Text(
                                "Login",
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
                                    await controller.login();
                                    if (!mounted) return;
                                    PerfilTipo? userType = await context
                                        .read<PerfilProvider>()
                                        .getUser();
                                    if (!mounted) return;
                                    if (userType != null) {
                                      if (userType.index == 1) {
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const HomePage()),
                                            (route) => false);
                                      } else {
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const HomePageProf()),
                                            (route) => false);
                                      }
                                    } else {
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const TipoPerfilPage()),
                                          (route) => false);
                                    }

                                    //await Future.delayed(const Duration(seconds: 2));
                                    cancel();
                                    //FirebaseAuth.instance.signOut();
                                  }
                                } on FirebaseAuthException catch (e) {
                                  if (e.message!.contains("user-not-found") ||
                                      e.code.contains("user-not-found")) {
                                    alertaApp(
                                        context, "E-mail não encontrado!");
                                  } else if (e.message!
                                          .contains("wrong-password") ||
                                      e.code.contains("wrong-password")) {
                                    alertaApp(context, "Senha Inválida!");
                                  } else if (e.message!
                                          .contains("invalid-email") ||
                                      e.code.contains("invalid-email")) {
                                    alertaApp(context, "E-mail Inválido!");
                                  }
                                  if (cancel != null) {
                                    cancel();
                                  }
                                  debugPrint(e.message);
                                  debugPrint(e.code);
                                }
                              },
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextButton(
                            style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(13),
                                  side: const BorderSide(color: primary)),
                              fixedSize: Size(size.width * 0.65, 62),
                            ),
                            child: const Text(
                              "Cadastre-se",
                              style: TextStyle(
                                  fontFamily: "PassionOne",
                                  fontSize: 32,
                                  color: primary),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const CadastroPage()));
                            },
                          )
                        ]),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 30),
                    child: size.width < 768
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                "src/images/cefet.png",
                                width: size.width * .17,
                              ),
                              Image.asset(
                                "src/images/profept.png",
                                width: size.width * .19,
                              ),
                              Image.asset(
                                "src/images/fapemig.png",
                                width: size.width * .19,
                              ),
                              Image.asset(
                                "src/images/cnpq.png",
                                width: size.width * .19,
                              ),
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Image.asset(
                                  "src/images/cefet.png",
                                  width: 100,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Image.asset(
                                  "src/images/profept.png",
                                  width: 130,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Image.asset(
                                  "src/images/fapemig.png",
                                  width: 125,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Image.asset(
                                  "src/images/cnpq.png",
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
    );
  }
}
