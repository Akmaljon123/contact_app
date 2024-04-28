import 'package:contact_app/functions/contact_builder.dart';
import 'package:contact_app/my_app/setup.dart';
import 'package:contact_app/pages/contact_edit_page.dart';
import 'package:contact_app/pages/login_page.dart';
import 'package:contact_app/pages/new_contact_page.dart';
import 'package:contact_app/services/language_extension_service.dart';
import 'package:contact_app/services/path_provider_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
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

            Padding(
                padding: const EdgeInsets.only(left: 20, top: 120),
                child: TextButton(
                  onPressed: (){
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context)=>const LoginPage()
                        ),
                            (route) => false);
                  },
                  child: Text("contacts".translate,
                      style: GoogleFonts.quicksand(
                          fontSize: 48,
                          fontWeight: FontWeight.w700,
                          color: Colors.white
                      )
                  ),
                )
            ),

            Padding(
              padding: const EdgeInsets.only(top: 300),
              child: Container(
                height: 600,
                width: 450,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20)
                    )
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 10),

                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, i)=>contactBuilder(context, contactList[i].name, contactList[i].path, contactList[i], i),
                        itemCount: contactList.length,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: (){
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context)=>NewContactPage()
              )
          );
        },
        child: Container(
          height: 60,
          width: 60,
          decoration: const BoxDecoration(
              color: Colors.amber,
              shape: BoxShape.circle
          ),
          alignment: Alignment.center,
          child: Text(
            "+",
            style: GoogleFonts.poppins(
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.w500
            ),
          ),
        ),
      )
    );
  }
}
