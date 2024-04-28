import 'dart:io';

import 'package:contact_app/services/hive_service.dart';
import 'package:contact_app/services/language_extension_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../functions/text_fields.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  List<String> textList=[];
  File? file;
  late Directory directory;
  bool isImageSelected = false;
  bool isLoading = false;
  bool isCamera = false;
  bool isObscure = false;
  String? path;
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController passwordController;
  late TextEditingController confirmController;

  @override
  void initState() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    passwordController = TextEditingController();
    confirmController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  bool validateInputs() {
    return nameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        phoneController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        confirmController.text.isNotEmpty;
  }

  Future<void> getImage() async {
    isImageSelected = false;
    final ImagePicker picker = ImagePicker();
    XFile? xFile = await picker.pickImage(
        source: isCamera ? ImageSource.camera : ImageSource.gallery);
    if (xFile != null) {
      file = File(xFile.path);
      final directory = await getApplicationDocumentsDirectory();
      await file!.copy("${directory.path}/image.png");
      path = file!.path;
      isImageSelected = true;
      setState(() {});
    }
  }

  Future<void> read() async {
    final directory = await getApplicationDocumentsDirectory();
    await for (var event in directory.list()) {
      if (event.path.contains('image.png')) {
        isImageSelected = true;
      }
    }
    if (isImageSelected) {
      file = File("${directory.path}/image.png");
      path = file!.path;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          SizedBox(
            height: 310,
            width: 450,
            child: Image.asset(
              "assets/images/background.png",
              fit: BoxFit.fitWidth,
              alignment: Alignment.center,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 290),
            height: 600,
            width: 450,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20))),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 250, top: 70),
                    child: Text(
                      "username".translate,
                      style: GoogleFonts.quicksand(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                  ),
                  textFieldFunction(
                      textController: nameController,
                      hintText: "hintName".translate
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, right: 300),
                    child: Text(
                      "email".translate,
                      style: GoogleFonts.quicksand(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                  ),
                  textFieldFunction(
                      textController: emailController,
                      hintText: "hintEmail".translate
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, right: 190),
                    child: Text(
                      "phoneNumber".translate,
                      style: GoogleFonts.quicksand(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                  ),
                  textFieldFunction(
                      textController: phoneController,
                      hintText: "phoneEmail".translate
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, right: 255),
                    child: Text(
                      "password".translate,
                      style: GoogleFonts.quicksand(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22),
                    child: TextField(
                      controller: passwordController,
                      cursorColor: Colors.black,
                      style: GoogleFonts.quicksand(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                      decoration: InputDecoration(
                        border: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        hintText: "hintPassword".translate,
                        hintStyle: GoogleFonts.quicksand(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, right: 150),
                    child: Text(
                      "confirmPassword".translate,
                      style: GoogleFonts.quicksand(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22),
                    child: TextField(
                      controller: confirmController,
                      cursorColor: Colors.black,
                      style: GoogleFonts.quicksand(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                      decoration: InputDecoration(
                        border: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        hintText: "hintConfirm".translate,
                        hintStyle: GoogleFonts.quicksand(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  GestureDetector(
                    onTap: ()async{
                      if (validateInputs()){
                        await HiveService.saveData(
                            username: nameController.text,
                            password: passwordController.text,
                            phoneNumber: phoneController.text,
                            email: emailController.text,
                            path: file!.path
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                            Text("errorField".translate),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    child: Container(
                      height: 50,
                      width: 340,
                      decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(20)),
                      alignment: Alignment.center,
                      child: Text(
                        "register".translate,
                        style: GoogleFonts.quicksand(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  const SizedBox(height: 300),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Container(
                    height: 180,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                        color: Colors.white),
                    child: Column(
                      children: [
                        const SizedBox(height: 40),

                        MaterialButton(
                            minWidth: double.infinity,
                            onPressed: () async {
                              isCamera = true;
                              await getImage();
                            },
                            child: Container(
                              height: 50,
                              width: 340,
                              decoration: BoxDecoration(
                                  color: Colors.amber,
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                "camera".translate,
                                style: GoogleFonts.quicksand(
                                    fontSize: 18,
                                    color: Colors.white
                                ),
                              ),
                            )
                        ),

                        const SizedBox(height: 10),

                        MaterialButton(
                            minWidth: double.infinity,
                            onPressed: () async {
                              isCamera = false;
                              await getImage();
                            },
                            child: Container(
                              height: 50,
                              width: 340,
                              decoration: BoxDecoration(
                                  color: Colors.amber,
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                "gallery".translate,
                                style: GoogleFonts.quicksand(
                                    fontSize: 18,
                                    color: Colors.white
                                ),
                              ),
                            )
                        )
                      ],
                    ),
                  );
                },
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 150, top: 250),
              child: CircleAvatar(
                  radius: 45,
                  backgroundColor:
                  file != null ? Colors.transparent : Colors.grey.shade400,
                  child: file != null
                      ? ClipOval(
                      child: Image.file(
                        file!,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ))
                      : const Icon(Icons.camera_alt,
                      size: 40, color: Colors.black)),
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(left: 20, top: 120),
              child: Text("register".translate,
                  style: GoogleFonts.quicksand(
                      fontSize: 48,
                      fontWeight: FontWeight.w700,
                      color: Colors.white)))
        ],
      ),
    );
  }
}

ImageProvider<Object>? profileImage({File? file}) {
  return file != null
      ? Image.file(file).image
      : const AssetImage("assets/images/camera.png");
}
