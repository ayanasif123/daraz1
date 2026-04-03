import 'package:flutter/material.dart';
import 'package:grid/daraz.dart';

class Reg extends StatefulWidget{
  const Reg({super.key});

  @override
  State<Reg> createState()=>_RegState();
}

class _RegState extends State<Reg>{

  bool obscure = true;

  final userController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();

  bool isValidEmail(String email){
    return RegExp(
        r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"
    ).hasMatch(email);
  }

  void register(){

    if(userController.text.isEmpty ||
        emailController.text.isEmpty ||
        passController.text.isEmpty){
      return;
    }

    if(!isValidEmail(emailController.text)){
      return;
    }

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const DarazHome())
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(

      // ⭐ Gradient Background
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 23, 26, 230),
                  Color.fromARGB(255, 255, 255, 255)
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
                "Register",
                style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                ),
              ),

              const SizedBox(height:40),

              // ⭐ Username
              TextField(
                controller: userController,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Username",
                    prefixIcon: const Icon(Icons.person, color: Colors.black),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)
                    )
                ),
              ),

              const SizedBox(height:20),

              // ⭐ Email
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Email",
                    prefixIcon: const Icon(Icons.email, color: Colors.black),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)
                    )
                ),
              ),

              const SizedBox(height:20),

              // ⭐ Password
              TextField(
                controller: passController,
                obscureText: obscure,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Password",
                    prefixIcon: const Icon(Icons.lock, color: Colors.black),
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

              const SizedBox(height:40),

              // ⭐ Register Button
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)
                        )
                    ),
                    onPressed: register,
                    child: const Text(
                        "Register",
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