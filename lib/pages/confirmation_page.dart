import 'package:contact_app/pages/contact_page.dart';
import 'package:contact_app/services/language_extension_service.dart';
import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ConfirmationPage extends StatefulWidget {
  late EmailOTP myAuth;
  ConfirmationPage({super.key, required this.myAuth});

  @override
  State<ConfirmationPage> createState() => _ConfirmationPageState();
}

class _ConfirmationPageState extends State<ConfirmationPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  bool doesMatched = false;

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
                child: Text("confirmation".translate,
                    style: GoogleFonts.quicksand(
                        fontSize: 48,
                        fontWeight: FontWeight.w700,
                        color: Colors.white))),
            Padding(
              padding: const EdgeInsets.only(top: 300),
              child: Container(
                height: 600,
                width: 450,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20))),
                child: Column(
                  children: [
                    const SizedBox(height: 30),

                    PinCodeTextField(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      keyboardType: TextInputType.number,
                      appContext: context,
                      controller: pinCodeController,
                      length: 4,
                      pinTheme: PinTheme(
                        inactiveColor: Colors.amber,
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 50,
                        fieldWidth: 40,
                        activeFillColor: Colors.black,
                      ),
                    ),

                    const SizedBox(height:10),

                    Text(
                      "4code".translate,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.quicksand(
                        fontSize: 22,
                        color: Colors.black,
                        fontWeight: FontWeight.w500
                      ),
                    ),

                    const SizedBox(height:10),

                    GestureDetector(
                      onTap: ()async{
                        if(await widget.myAuth.verifyOTP(
                          otp: pinCodeController.text
                        )){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context)=>const ContactPage()
                              )
                          );
                        }
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
                            "confirm".translate,
                          style: GoogleFonts.poppins(
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
