import 'dart:io';
import 'package:contact_app/my_app/setup.dart';
import 'package:contact_app/pages/contact_page.dart';
import 'package:contact_app/services/language_extension_service.dart';
import 'package:contact_app/services/path_provider_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../functions/text_fields.dart';
import '../models/contact_model.dart';

class NewContactPage extends StatefulWidget {
  NewContactPage({super.key});

  @override
  State<NewContactPage> createState() => _NewContactPageState();
}

class _NewContactPageState extends State<NewContactPage> {
  List<String> textList = [];
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 40, right: 300),
                    child: Text(
                      "name".translate,
                      style: GoogleFonts.quicksand(
                          fontSize: 22,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  textFieldFunction(
                      textController: nameController,
                      hintText: "hintContact".translate),
                  Padding(
                    padding: const EdgeInsets.only(top: 40, right: 200),
                    child: Text(
                      "phoneNumber".translate,
                      style: GoogleFonts.quicksand(
                          fontSize: 22,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  textFieldFunction(
                      textController: phoneController,
                      hintText: "hintPhone".translate),
                  Padding(
                    padding: const EdgeInsets.only(top: 40, right: 200),
                    child: Text(
                      "address".translate,
                      style: GoogleFonts.quicksand(
                          fontSize: 22,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  textFieldFunction(
                      textController: emailController,
                      hintText: "addressHint".translate),
                  const SizedBox(height: 30),
                  GestureDetector(
                    onTap: () async {
                      await PathProviderService.saveContact(
                          contact: ContactModel(
                              email: emailController.text,
                              name: nameController.text,
                              number: phoneController.text,
                              path: file!.path));

                      contactList = await PathProviderService.getContact();

                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ContactPage()),
                          (route) => false);
                    },
                    child: Container(
                      width: 370,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(15)),
                      alignment: Alignment.center,
                      child: Text(
                        "create".translate,
                        style: GoogleFonts.quicksand(
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),

                  const SizedBox(height: 250)
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
                                  borderRadius: BorderRadius.circular(15)),
                              alignment: Alignment.center,
                              child: Text(
                                "camera".translate,
                                style: GoogleFonts.quicksand(
                                    fontSize: 18, color: Colors.white),
                              ),
                            )),
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
                                  borderRadius: BorderRadius.circular(15)),
                              alignment: Alignment.center,
                              child: Text(
                                "gallery".translate,
                                style: GoogleFonts.quicksand(
                                    fontSize: 18, color: Colors.white),
                              ),
                            ))
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
              child: Text("yourContact".translate,
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
