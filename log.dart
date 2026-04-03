import 'package:flutter/material.dart';
import 'package:grid/daraz.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final emailController = TextEditingController();
  final passController = TextEditingController();

  bool obscure = true;

  void login(){

    if(emailController.text.isEmpty ||
        passController.text.isEmpty){
      return;
    }

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const DarazHome()),
            (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // ⭐ Gradient Background
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 31, 61, 196),
                  Colors.white
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter
            )
        ),

        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              const Text(
                "Login",
                style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                ),
              ),

              const SizedBox(height: 40),

              // ⭐ Email Field
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Email",
                    prefixIcon: const Icon(Icons.email, color: Color.fromARGB(255, 22, 19, 14)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)
                    )
                ),
              ),

              const SizedBox(height: 20),

              // ⭐ Password Field
              TextField(
                controller: passController,
                obscureText: obscure,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Password",
                    prefixIcon: const Icon(Icons.lock, color: Color.fromARGB(255, 12, 10, 7)),
                    suffixIcon: IconButton(
                        icon: Icon(
                            obscure ? Icons.visibility_off : Icons.visibility
                        ),
                        onPressed: (){
                          setState(() {
                            obscure = !obscure;
                          });
                        }),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)
                    )
                ),
              ),

              const SizedBox(height: 40),

              // ⭐ Login Button
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color.fromARGB(255, 75, 86, 192),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)
                        )
                    ),
                    onPressed: login,
                    child: const Text(
                        "Login",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                        )
                    )
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}