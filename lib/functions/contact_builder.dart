import 'dart:io';

import 'package:contact_app/models/contact_model.dart';
import 'package:contact_app/pages/contact_page.dart';
import 'package:contact_app/services/language_extension_service.dart';
import 'package:contact_app/services/path_provider_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../pages/contact_edit_page.dart';

Widget contactBuilder(BuildContext context, String name, String path, ContactModel contactModel, int i){
  File? file = File(path);
  return GestureDetector(
    onLongPress: (){
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: Colors.white,
            title: Text("delete".translate),
            titleTextStyle: GoogleFonts.poppins(
              fontSize: 24,
              color: Colors.black,
            ),
            content: Text(
                "recover".translate),
            contentTextStyle: GoogleFonts.poppins(
              fontSize: 16, color: Colors.black,
            ),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      height: 50,
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.red),
                      alignment: Alignment.center,
                      child: Text(
                        "no".translate,
                        style:
                        const TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: ()async{
                      await PathProviderService.deleteContact(i: i);
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context)=>const ContactPage()),
                              (route) => false);
                    },
                    child: Container(
                      height: 50,
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.green),
                      alignment: Alignment.center,
                      child: Text(
                        "yes".translate,
                        style:
                        const TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  )
                ],
              )
            ],
          ));
    },
    onTap: (){
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context)=> ContactEditPage(contactModel: contactModel, i: i)
          )
      );
    },
    child: Container(
      height: 50,
      width: 370,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Colors.amber,
          )
      ),
      child: Row(
        children: [
          const SizedBox(width: 10),

          CircleAvatar(
              radius: 20,
              backgroundColor: Colors.grey.shade400,
              child: file != null
                  ? ClipOval(
                  child: Image.file(
                    file!,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ))
                  : const Icon(Icons.camera_alt,
                  size: 40, color: Colors.black)
          ),

          const SizedBox(width: 10),

          Text(
            name,
            style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black
            ),
          )
        ],
      ),
    ),
  );
}