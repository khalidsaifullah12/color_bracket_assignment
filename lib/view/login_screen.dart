import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool ontap = false;
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  void login( String email) async {
    try {
      http.Response response = await http.post(
        Uri.parse("https://retoolapi.dev/B13laa/getusers?user_id="),
        body: {
          "user_id":email
        }
      );
      if (response.statusCode == 200) {
        print("login sucessful");

      } else {
        print(" unsucessful");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Image(
                  width: 350,
                  fit: BoxFit.cover,
                  image: AssetImage(
                    "assets/login.png",
                  )),
              const SizedBox(
                height: 30,
              ),
              "Welcome Back "
                  .text
                  .bold
                  .xl2
                  .make()
                  .shimmer(primaryColor: Colors.deepOrangeAccent),
              const SizedBox(
                height: 30,
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: VxTextField(
                      controller: emailController,
                      validator: (v) {
                        if (v!.isEmpty) {
                          return "user id cannot be empty ";
                        } else if (!v.contains("@")) {
                          return "please enter a valid email";
                        }
                      },
                      contentPaddingLeft: 9,
                      labelText: "Enter Email Address",
                      hint: "khalid@gmail.com",
                    ).card.make(),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: VxTextField(
                      controller: passwordController,
                      validator: (v) {
                        if (v!.isEmpty) {
                          return "password cannot be empty ";
                        } else if (v.length < 6) {
                          return "password should be 6 chracter";
                        }
                      },
                      contentPaddingLeft: 9,
                      isPassword: true,
                      labelText: "Enter Password",
                      hint: "******",
                    ).card.make(),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: "Forget Password?"
                          .text
                          .bold
                          .color(Colors.deepOrangeAccent)
                          .make()),
                  const SizedBox(
                    height: 15,
                  ),
                  InkWell(
                    onTap: () async {
                      if (formKey.currentState!.validate()) {

                        setState(() {
                          ontap = true;
                        });
                        await Future.delayed(const Duration(seconds: 1));
                        login(emailController.text);
                         Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (_) {
                              return HomeScreen();
                            }));

                      } else {
                        print("fail");
                      }
                    },
                    child: AnimatedContainer(
                      alignment: Alignment.center,
                      height: 50,
                      width: ontap ? 50 : 150,
                      decoration: BoxDecoration(
                          color: Colors.deepOrangeAccent,
                          borderRadius: BorderRadius.circular(ontap ? 50 : 20)),
                      duration: const Duration(seconds: 1),
                      child:
                          ontap ? const CupertinoActivityIndicator() : const Text("Login"),
                    ).card.roundedLg.make(),
                  ),
                ],
              )
            ],
          ).p20(),
        ),
      ),
    );
  }
}
