import 'package:contact_app/my_app/setup.dart';
import 'package:contact_app/pages/confirmation_page.dart';
import 'package:contact_app/pages/register_page.dart';
import 'package:contact_app/services/language_extension_service.dart';
import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../functions/text_fields.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  EmailOTP myAuth = EmailOTP();
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
                child: Text("login".translate,
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
                        topLeft: Radius.circular(20)
                    )
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 300, top: 60),
                      child: Text(
                        "email".translate,
                        style: GoogleFonts.quicksand(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
                      ),
                    ),
                    textFieldFunction(textController: emailController, hintText: "hintEmail".translate),

                    const SizedBox(height: 40),

                    GestureDetector(
                      onTap: ()async{
                        for (var i = 0; i < userList.length; ++i) {
                          if(userList[i].email==emailController.text){
                            doesMatched=true;
                            break;
                          }
                        }

                        if(doesMatched) {
                          myAuth.setConfig(
                              appEmail: "00018426@wiut.uz",
                              appName: "Email OTP",
                              userEmail: emailController.text,
                              otpLength: 4,
                              otpType: OTPType.digitsOnly
                          );

                          if(await myAuth.sendOTP()){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (
                                        context) => ConfirmationPage(myAuth: myAuth,)
                                )
                            );
                          }


                          }
                      },
                      child: Container(
                        height: 50,
                        width: 360,
                        decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(15)
                        ),
                        alignment: Alignment.center,
                        child: Text("login".translate,
                            style: GoogleFonts.quicksand(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: Colors.white)),
                      ),
                    ),

                    Row(
                      children: [
                        Container(

                        )
                      ],
                    ),

                    const SizedBox(height: 40),
                    
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context)=>const RegisterPage()
                            )
                        );
                      },
                      child: RichText(
                        text: TextSpan(
                          text: "noAcc".translate,
                          style: GoogleFonts.quicksand(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.w400
                          ),
                          children: [
                            TextSpan(
                              text: "here".translate,
                              style: GoogleFonts.quicksand(
                                fontSize: 15,
                                color: Colors.amber,
                                fontWeight: FontWeight.w400
                              )
                            )
                          ]
                        ),
                      ),
                    ),


                    const SizedBox(height: 40),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          height: 2,
                          width: 80,
                          color: Colors.grey.shade500,
                        ),

                        Text(
                          "or".translate,
                          style: GoogleFonts.quicksand(
                            fontSize: 16,
                            color: Colors.grey.shade500,
                            fontWeight: FontWeight.w400
                          ),
                        ),

                        Container(
                          height: 2,
                          width: 80,
                          color: Colors.grey,
                        )
                      ],
                    ),

                    const SizedBox(height: 40),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle
                          ),
                          child: Image.asset("assets/images/gmail.png"),
                        ),

                        const SizedBox(width: 30),

                        Container(
                          height: 50,
                          width: 50,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle
                          ),
                          child: Image.asset("assets/images/facebook.png"),
                        ),
                      ],
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
