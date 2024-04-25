import 'dart:io';

import 'package:abntplaybic/modules/home/controllers/editController.dart';
import 'package:abntplaybic/modules/perfil/controller/perfilProvider.dart';
import 'package:abntplaybic/modules/perfil/models/perfilAluno.dart';
import 'package:abntplaybic/shared/colors.dart';
import 'package:abntplaybic/shared/components/botoes/botao_perfil.dart';
import 'package:abntplaybic/shared/validacoes.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditarPerfilPage extends StatefulWidget {
  const EditarPerfilPage({super.key});

  @override
  State<EditarPerfilPage> createState() => _EditarPerfilPageState();
}

class _EditarPerfilPageState extends State<EditarPerfilPage> {
  final EditController _controllerEdit = EditController();
  FocusNode emailNode = FocusNode();
  FocusNode nomeNode = FocusNode();
  XFile? newImage;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _controllerEdit.email.text = FirebaseAuth.instance.currentUser!.email ?? "";
    _controllerEdit.nome.text =
        FirebaseAuth.instance.currentUser!.displayName ?? "";
  }

  Future<String?> getImage() async {
    return await FirebaseStorage.instance
        .ref("/users/img-default.jpg")
        .getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
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
          title: const Text(
            "Editar Perfil",
            style: TextStyle(
              color: roxo,
              fontFamily: "PassionOne",
              fontSize: 32,
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              height: size.height,
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 160,
                      height: 160,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: primary, width: 2)),
                      child: GestureDetector(
                        onTap: () async {
                          var picker = ImagePicker();
                          await showDialog(
                              context: context,
                              builder: (context) => Dialog(
                                    backgroundColor: branco,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(13),
                                        side: const BorderSide(
                                            color: primary, width: 3)),
                                    child: Container(
                                      // width: size.width * 0.9,
                                      // height: size.width * 0.6,
                                      // constraints: BoxConstraints(
                                      //   minWidth: size.width * 0.9,
                                      //   minHeight: size.width * 0.6,
                                      // ),
                                      padding: const EdgeInsets.only(
                                          top: 10,
                                          left: 10,
                                          right: 10,
                                          bottom: 10),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          const Text("Adicionar foto",
                                              style: TextStyle(
                                                  fontFamily: "PassionOne",
                                                  fontSize: 32,
                                                  color: Colors.black)),
                                          const SizedBox(height: 10),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Column(
                                                children: [
                                                  Ink(
                                                    decoration: ShapeDecoration(
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12)),
                                                        color: primary),
                                                    child: IconButton(
                                                      iconSize: 50,
                                                      icon: const Icon(
                                                          Icons.camera),
                                                      color: branco,
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 20,
                                                          vertical: 20),
                                                      onPressed: () async {
                                                        var file = await picker
                                                            .pickImage(
                                                                source:
                                                                    ImageSource
                                                                        .camera);
                                                        newImage = file;
                                                        Navigator.pop(context);
                                                      },
                                                    ),
                                                  ),
                                                  const Text(
                                                    "Câmera",
                                                    style: TextStyle(
                                                        fontSize: 25,
                                                        fontFamily:
                                                            "PassionOne"),
                                                  )
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Ink(
                                                    decoration: ShapeDecoration(
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12)),
                                                        color: primary),
                                                    child: IconButton(
                                                      iconSize: 50,
                                                      icon: const Icon(
                                                          Icons.photo),
                                                      color: branco,
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 20,
                                                          vertical: 20),
                                                      onPressed: () async {
                                                        var file = await picker
                                                            .pickImage(
                                                                source:
                                                                    ImageSource
                                                                        .gallery);
                                                        newImage = file;
                                                        Navigator.pop(context);
                                                      },
                                                    ),
                                                  ),
                                                  const Text("Arquivos",
                                                      style: TextStyle(
                                                          fontSize: 25,
                                                          fontFamily:
                                                              "PassionOne"))
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ));
                          if (newImage != null) {
                            print(newImage!.name);
                          }
                          setState(() {});
                        },
                        child: Stack(
                          children: [
                            newImage != null
                                ? Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      width: 160,
                                      height: 160,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        color: lilas,
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(6),
                                        child: kIsWeb
                                            ? Image.network(
                                                newImage!.path,
                                                fit: BoxFit.cover,
                                              )
                                            : Image.file(
                                                File(
                                                  newImage!.path,
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                      ),
                                    ),
                                  )
                                : Container(
                                    width: 160,
                                    height: 160,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: lilas,
                                    ),
                                    child: context
                                                .read<PerfilProvider>()
                                                .perfilAtual
                                                ?.fotoPerfil ==
                                            null
                                        ? ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        6),
                                                child: Image.asset("src/images/img-default.jpg"),
                                              )
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            child: Image.network(
                                              context
                                                  .read<PerfilProvider>()
                                                  .perfilAtual!
                                                  .fotoPerfil!,
                                              fit: BoxFit.cover,
                                            )),
                                  ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Padding(
                                padding: const EdgeInsets.all(4),
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      border:
                                          Border.all(color: roxo, width: 2)),
                                  child: const Icon(
                                    Icons.edit,
                                    color: roxo,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    AutoSizeText(
                      _controllerEdit.nome.text.isNotEmpty
                          ? _controllerEdit.nome.text
                          : FirebaseAuth.instance.currentUser!.displayName ??
                              "Nome",
                      style: const TextStyle(
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.bold,
                        fontSize: 33,
                      ),
                      maxLines: 1,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 25),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.fromLTRB(10, 0, 0, 8),
                              child: Text(
                                "ALTERAR DADOS",
                                style: TextStyle(
                                  color: prata,
                                  fontFamily: "BebasNeue",
                                  fontSize: 20,
                                ),
                              ),
                            ),
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
                                    controller: _controllerEdit.email,
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
                              height: 20,
                            ),
                            TextFormField(
                              cursorColor: primary,
                                focusNode: nomeNode,
                                controller: _controllerEdit.nome,
                                keyboardType: TextInputType.name,
                                textInputAction: TextInputAction.go,
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
                          ],
                        ),
                      ),
                    ),
                    BotaoPerfil(
                      funcaoBotao: () async {
                        if (_formKey.currentState!.validate()) {
                          var cancel = BotToast.showLoading();
                          var perfil =
                              context.read<PerfilProvider>().perfilAtual!;
                          if (_controllerEdit.email.text != perfil.email) {
                            await FirebaseAuth.instance.currentUser!
                                .updateEmail(_controllerEdit.email.text);
                          }
                          if (_controllerEdit.nome.text != perfil.nome) {
                            await FirebaseAuth.instance.currentUser!
                                .updateDisplayName(_controllerEdit.nome.text);
                            await (context.read<PerfilProvider>().perfilAtual)?.updateName(_controllerEdit.nome.text);
                          }
                          if (newImage != null) {
                            var url = "/users/${perfil.id}${newImage!.path.split(".").last}";
                            var ref = await FirebaseStorage.instance
                                .ref(
                                    url)
                                .putData((await newImage!.readAsBytes()))
                                .then((p0) => p0.ref);
                            print(ref);

                            if (perfil is PerfilAluno) {
                              await (context.read<PerfilProvider>().perfilAtual as PerfilAluno).updateImage("gs://abnt-play.appspot.com" + url);
                            }

                            await FirebaseAuth.instance.currentUser!
                                .updatePhotoURL((await ref.getDownloadURL()));
                          }
                          await context.read<PerfilProvider>().getUser();
                          cancel();
                          Navigator.pop(context);
                        }
                      },
                      icone: Icons.edit,
                      text: "CONFIRMAR",
                      bgcolor: amarelo,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
