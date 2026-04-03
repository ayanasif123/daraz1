import 'package:flutter/material.dart';
import 'dart:math';

class Sub extends StatefulWidget {
  const Sub({super.key});

  @override
  State<Sub> createState() => _SubState();
}

class _SubState extends State<Sub> {
  

  String input = "";
  void changenumber (String value) {
    setState(() {
      input +=value;
    });
  }
   void clearnumber () {
    setState(() {
      input ='';
    });
  }

  void add() {
  if (input.contains('+')) {
        List<String> parts = input.split('+');

    if (parts.length > 1) {
      double num1 = double.tryParse(parts[0]) ?? 0.0;
      double num2 = double.tryParse(parts[1]) ?? 0.0;

      double sum = num1 + num2;

      if (parts.length > 2) {
        double num3 = double.tryParse(parts[2]) ?? 0.0;
        sum += num3;
      }

      setState(() {
        input = sum.toString(); // Set the sum as the new input to display
      });
    }
  }
}
 void sub() {
  if (input.contains('-')) {
        List<String> parts = input.split('-');

    if (parts.length > 1) {
      double num1 = double.tryParse(parts[0]) ?? 0.0;
      double num2 = double.tryParse(parts[1]) ?? 0.0;

      double sum = num1 - num2;

      if (parts.length > 2) {
        double num3 = double.tryParse(parts[2]) ?? 0.0;
        Sub == num3;
      }

      setState(() {
        input = sum.toString(); // Set the sum as the new input to display
      });
    }
  }
}
void mul() {
  if (input.contains('×')) {
        List<String> parts = input.split('×');

    if (parts.length > 1) {
      double num1 = double.tryParse(parts[0]) ?? 0.0;
      double num2 = double.tryParse(parts[1]) ?? 0.0;

      double sum = num1 * num2;

      if (parts.length > 2) {
        double num3 = double.tryParse(parts[2]) ?? 0.0;
        mul == num3;
      }

      setState(() {
        input = sum.toString(); // Set the sum as the new input to display
      });
    }
  }
}
void div() {
  if (input.contains('÷')) {
        List<String> parts = input.split('÷');

    if (parts.length > 1) {
      double num1 = double.tryParse(parts[0]) ?? 0.0;
      double num2 = double.tryParse(parts[1]) ?? 0.0;

      double sum = num1 / num2;

      if (parts.length > 2) {
        double num3 = double.tryParse(parts[2]) ?? 0.0;
        div == num3;
      }

      setState(() {
        input = sum.toString(); // Set the sum as the new input to display
      });
    }
  }
}
 void per() {
  if (input.contains('%')) {
        List<String> parts = input.split('%');

    if (parts.length > 1) {
      double num1 = double.tryParse(parts[0]) ?? 0.0;
      double num2 = double.tryParse(parts[1]) ?? 0.0;

      double sum = num1 % num2;

      if (parts.length > 2) {
        double num3 = double.tryParse(parts[2]) ?? 0.0;
        per == num3;
      }

      setState(() {
        input = sum.toString(); // Set the sum as the new input to display
      });
    }
  }
}
void Sin() {
    if (input.contains('Sin')) {
      List<String> parts = input.split('Sin'); //3+4
      if (parts.length == 2) {
        double num1 = double.tryParse(parts[1]) ?? 0.0;
       
        double sum = sin(num1);

        setState(() {
          input = sum.toString();
        });
      }
    }
  }
  void Cos() {
    if (input.contains('Cos')) {
      List<String> parts = input.split('Cos'); //3+4
      if (parts.length == 2) {
        double num1 = double.tryParse(parts[1]) ?? 0.0;
       
        double sum = cos(num1);

        setState(() {
          input = sum.toString();
        });
      }
    }
  }
   void Rad() {
    if (input.contains('Rad')) {
      List<String> parts = input.split('Rad'); //3+4
      if (parts.length == 2) {
        double num1 = double.tryParse(parts[1]) ?? 0.0;
       
        double sum = num1*pi/180;

        setState(() {
          input = sum.toString();
        });
      }
    }
  }
   void Deg() {
    if (input.contains('Deg')) {
      List<String> parts = input.split('Deg'); //3+4
      if (parts.length == 2) {
        double num1 = double.tryParse(parts[1]) ?? 0.0;
       
        double sum = num1*180/pi;

        setState(() {
          input = sum.toString();
        });
      }
    }
  }
   void TT() {
    if (input.contains('TT')) {
      List<String> parts = input.split('TT'); //3+4
      if (parts.length == 2) {
        double num1 = double.tryParse(parts[1]) ?? 0.0;
       
        double sum = num1*pi;

        setState(() {
          input = sum.toString();
        });
      }
    }
  }
  void log() {
    if (input.contains('Log')) {
      List<String> parts = input.split('Log'); //3+4
      if (parts.length == 2) {
        double num1 = double.tryParse(parts[1]) ?? 0.0;
       
        double sum = num1*pi;

        setState(() {
          input = sum.toString();
        });
      }
    }
  }
   void In() {
    if (input.contains('In')) {
      List<String> parts = input.split('In'); //3+4
      if (parts.length == 2) {
        double num1 = double.tryParse(parts[1]) ?? 0.0;
       
        double sum = num1*pi;

        setState(() {
          input = sum.toString();
        });
      }
    }
  }   
    void EXP() {
    if (input.contains('EXP')) {
      List<String> parts = input.split('EXP'); //3+4
      if (parts.length == 2) {
        double num1 = double.tryParse(parts[1]) ?? 0.0;
       
        double sum = num1*pi;

        setState(() {
          input = sum.toString();
        });
      }
    }
  }  
    
    void e() {
    if (input.contains('e')) {
      List<String> parts = input.split('e'); //3+4
      if (parts.length == 2) {
        double num1 = double.tryParse(parts[1]) ?? 0.0;
       
        double sum = num1*pi;

        setState(() {
          input = sum.toString();
        });
      }
    }
  }  
   void tan() {
    if (input.contains('tan')) {
      List<String> parts = input.split('tan'); //3+4
      if (parts.length == 2) {
        double num1 = double.tryParse(parts[1]) ?? 0.0;
       
        double sum = num1*pi;

        setState(() {
          input = sum.toString();
        });  
      }
    }
  }  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [

         
          SizedBox(height: 100,),

          Center(
            child: Container(
              height: 500,
              width: 700,
              decoration: BoxDecoration(color: Colors.black,borderRadius: BorderRadius.circular(15)),
              child: Column(
                children: [

                  SizedBox(height: 60,),
                   Padding(
                     padding: const EdgeInsets.only(left: 420,bottom: 15),
                     child: Text(input,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
                   ),

                 
                  SizedBox(height: 20,),
     Row(
      children: [
          SizedBox(width: 20,),
         InkWell(onTap: (){
          changenumber("Rad");
         },
           child: Container(
                          height: 40,
                          width: 80,
                          decoration: BoxDecoration(color: Colors.grey.shade300,borderRadius: BorderRadius.circular(30)),
                          child: Center(child: Text("Rad",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),)),
                                     
                                    
                        ),
         ),  
         InkWell(onTap: (){
          changenumber("Deg");
         },
           child: Container(
                          height: 40,
                          width: 80,
                          decoration: BoxDecoration(color: Colors.grey.shade300,borderRadius: BorderRadius.circular(30)),
                          child: Center(child: Text("Deg",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),)),
                                     
                                    
                        ),
         ),  SizedBox(width: 20,),
         InkWell(onTap: (){
          changenumber("X!");
         },
           child: Container(
                          height: 40,
                          width: 80,
                          decoration: BoxDecoration(color: Colors.grey.shade300,borderRadius: BorderRadius.circular(30)),
                          child: Center(child: Text("X!",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),)),
                                     
                                    
                        ),
         ),
          
        SizedBox(width: 20,),
         InkWell(onTap: (){
          changenumber("(");
         },
           child: Container(
                          height: 40,
                          width: 80,
                          decoration: BoxDecoration(color: Colors.grey.shade300,borderRadius: BorderRadius.circular(30)),
                          child: Center(child: Text("(",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),)),
                                     
                                    
                        ),
         ),
                      
                    SizedBox(width: 15,),
                      InkWell(onTap: (){
                        changenumber(")");
                      },
                        child: Container(
                          height: 40,
                          width: 80,
                          decoration: BoxDecoration(color: Colors.grey.shade300,borderRadius: BorderRadius.circular(30)),
                          child: Center(child: Text(")",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),)),
                                     
                                    
                        ),
                      ), SizedBox(width:15,),
                      InkWell(onTap: (){
                        changenumber("%");
                      },
                        child: Container(
                          height: 40,
                          width: 80,
                          decoration: BoxDecoration(color: Colors.grey.shade300,borderRadius: BorderRadius.circular(30)),
                          child: Center(child: Text("%",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),)),
                                     
                                    
                        ),
                      ),
 SizedBox(width: 15,),
                      InkWell(onTap: (){
                        clearnumber();
                      },
                        child: Container(
                          height: 40,
                          width: 80,
                          decoration: BoxDecoration(color: Colors.orange,borderRadius: BorderRadius.circular(30)),
                          child: Center(child: Text("AC",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),)),
                                     
                                    
                        ),
                      ),

                      
                  
                 
          ]  ),
          SizedBox(height: 30,),
                      Row(
      children: [
         SizedBox(width: 15,),
                      InkWell(onTap: (){
                        changenumber("Inv");
                      },
                        child: Container(
                          height: 40,
                          width: 80,
                          decoration: BoxDecoration(color: Colors.orange,borderRadius: BorderRadius.circular(30)),
                          child: Center(child: Text("Inv",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),)),
                                     
                                    
                        ),
                      ), SizedBox(width: 15,),
                      InkWell(onTap: (){
                        changenumber("Sin");
                      },
                        child: Container(
                          height: 40,
                          width: 80,
                          decoration: BoxDecoration(color: Colors.orange,borderRadius: BorderRadius.circular(30)),
                          child: Center(child: Text("Sin",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),)),
                                     
                                    
                        ),
                      ), SizedBox(width: 15,),
                      InkWell(onTap: (){
                        changenumber("In");
                      },
                        child: Container(
                          height: 40,
                          width: 80,
                          decoration: BoxDecoration(color: Colors.orange,borderRadius: BorderRadius.circular(30)),
                          child: Center(child: Text("In",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),)),
                                     
                                    
                        ),
                      ),

        SizedBox(width: 20,),
         InkWell(
          onTap: (){
            changenumber("7");
          },
           child: Container(
                          height: 40,
                          width: 80,
                          decoration: BoxDecoration(color: Colors.blueAccent,borderRadius: BorderRadius.circular(30)),
                          child: Center(child: Text("7",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),)),
                                     
                                    
                        ),
         ),
                      
                    SizedBox(width: 15,),
                       InkWell(
          onTap: (){
            changenumber("8");
          },
           child:
                      Container(
                          height: 40,
                          width: 80,
                          decoration: BoxDecoration(color: Colors.blueAccent,borderRadius: BorderRadius.circular(30)),
                          child: Center(child: Text("8",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),)),
                                     
                                    
                        ),
                      ), SizedBox(width:15,),
                      InkWell(
          onTap: (){
            changenumber("9");
          },
                        child: Container(
                          height: 40,
                          width: 80,
                          decoration: BoxDecoration(color: Colors.blueAccent,borderRadius: BorderRadius.circular(30)),
                          child: Center(child: Text("9",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),)),
                                     
                                    
                        ),
                      ),
 SizedBox(width: 15,),
                      InkWell(onTap: (){
                        changenumber('÷');
                      },
                        child: Container(
                          height: 40,
                          width: 80,
                          decoration: BoxDecoration(color: Colors.orange,borderRadius: BorderRadius.circular(30)),
                          child: Center(child: Text("÷",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),)),
                                     
                                    
                        ),
                      ),


      ],
     ),
     SizedBox(height: 30,),
                      Row(
      children: [ 
         SizedBox(width: 15,),
        InkWell(onTap: (){
          changenumber("TT");
        },
          child: Container(
                          height: 40,
                          width: 80,
                          decoration: BoxDecoration(color: Colors.orange,borderRadius: BorderRadius.circular(30)),
                          child: Center(child: Text("TT",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),)),
                                     
                                    
                        ),
        ),
                       SizedBox(width: 15,),
                      InkWell(onTap: (){
                        changenumber("Cos");
                      },
                        child: Container(
                          height: 40,
                          width: 80,
                          decoration: BoxDecoration(color: Colors.orange,borderRadius: BorderRadius.circular(30)),
                          child: Center(child: Text("Cos",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),)),
                                     
                                    
                        ),
                      ), 
                       SizedBox(width: 15,),
                      InkWell(onTap: (){
                        changenumber("Log");
                      },
                        child: Container(
                          height: 40,
                          width: 80,
                          decoration: BoxDecoration(color: Colors.orange,borderRadius: BorderRadius.circular(30)),
                          child: Center(child: Text("Log",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),)),
                                     
                                    
                        ),
                      ),

        SizedBox(width: 20,),
         InkWell(
          onTap: (){
            changenumber("4");
          },
           child: Container(
                          height: 40,
                          width: 80,
                          decoration: BoxDecoration(color: Colors.blueAccent,borderRadius: BorderRadius.circular(30)),
                          child: Center(child: Text("4",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),)),
                                     
                                    
                        ),
         ),
                      
                    SizedBox(width: 15,),
                      InkWell(
          onTap: (){
            changenumber("5");
          },
                        child: Container(
                          height: 40,
                          width: 80,
                          decoration: BoxDecoration(color: Colors.blueAccent,borderRadius: BorderRadius.circular(30)),
                          child: Center(child: Text("5",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),)),
                                     
                                    
                        ),
                      ), SizedBox(width:15,),
                      InkWell(
          onTap: (){
            changenumber("6");
          },
                        child: Container(
                          height: 40,
                          width: 80,
                          decoration: BoxDecoration(color: Colors.blueAccent,borderRadius: BorderRadius.circular(30)),
                          child: Center(child: Text("6",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),)),
                                     
                                    
                        ),
                      ),
 SizedBox(width: 15,),
                      InkWell(onTap: (){
                        changenumber("×");
                      },
                        
                        child: Container(
                          height: 40,
                          width: 80,
                          decoration: BoxDecoration(color: Colors.orange,borderRadius: BorderRadius.circular(30)),
                          child: Center(child: Text("×",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),)),
                                     
                                    
                        ),
                      ),


      ],
     ),
     SizedBox(height: 30,),
                      Row(
      children: [
        SizedBox(width: 15,),
                      InkWell(onTap: (){
                        changenumber("e");
                      },
                        child: Container(
                          height: 40,
                          width: 80,
                          decoration: BoxDecoration(color: Colors.orange,borderRadius: BorderRadius.circular(30)),
                          child: Center(child: Text("e",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),)),
                                     
                                    
                        ),
                      ),SizedBox(width: 15,),
                      InkWell(onTap: (){
                        changenumber("tan");
                      },
                        child: Container(
                          height: 40,
                          width: 80,
                          decoration: BoxDecoration(color: Colors.orange,borderRadius: BorderRadius.circular(30)),
                          child: Center(child: Text("tan",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),)),
                                     
                                    
                        ),
                      ),
                      SizedBox(width: 15,),
                      InkWell(onTap:(){
                        changenumber("√");
                      } ,
                        child: Container(
                          height: 40,
                          width: 80,
                          decoration: BoxDecoration(color: Colors.orange,borderRadius: BorderRadius.circular(30)),
                          child: Center(child: Text("√",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),)),
                                     
                                    
                        ),
                      ),

        SizedBox(width: 20,),
         InkWell(
          onTap: (){
            changenumber("1");
          },
           child: Container(
                          height: 40,
                          width: 80,
                          decoration: BoxDecoration(color: Colors.blueAccent,borderRadius: BorderRadius.circular(30)),
                          child: Center(child: Text("1",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),)),
                                     
                                    
                        ),
         ),
                      
                    SizedBox(width: 15,),
                      InkWell(
          onTap: (){
            changenumber("2");
          },
                        child: Container(
                          height: 40,
                          width: 80,
                          decoration: BoxDecoration(color: Colors.blueAccent,borderRadius: BorderRadius.circular(30)),
                          child: Center(child: Text("2",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),)),
                                     
                                    
                        ),
                      ), SizedBox(width:15,),
                      InkWell(
          onTap: (){
            changenumber("3");
          },
                        child: Container(
                          height: 40,
                          width: 80,
                          decoration: BoxDecoration(color: Colors.blueAccent,borderRadius: BorderRadius.circular(30)),
                          child: Center(child: Text("3",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),)),
                                     
                                    
                        ),
                      ),
 SizedBox(width: 15,),
                      InkWell(onTap: (){
                        changenumber("-");
                      },
                        child: Container(
                          height: 40,
                          width: 80,
                          
                          decoration: BoxDecoration(color: Colors.orange,borderRadius: BorderRadius.circular(30)),
                          child: Center(child: Text("-",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),)),
                                     
                                    
                        ),
                      ),


      ],
     ),
     SizedBox(height: 30,),
                      Row(
      children: [
         SizedBox(width: 15,),
                      InkWell(onTap:(){
                        changenumber("Ans");
                      } ,
                        child: Container(
                          height: 40,
                          width: 80,
                          decoration: BoxDecoration(color: Colors.orange,borderRadius: BorderRadius.circular(30)),
                          child: Center(child: Text("Ans",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),)),
                                     
                                    
                        ),
                      ),
 SizedBox(width: 15,),
                      InkWell(onTap: (){
                        changenumber("EXP");
                      },
                        child: Container(
                          height: 40,
                          width: 80,
                          decoration: BoxDecoration(color: Colors.orange,borderRadius: BorderRadius.circular(30)),
                          child: Center(child: Text("EXP",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),)),
                                     
                                    
                        ),
                      ),
 SizedBox(width: 15,),
                      InkWell( onTap: (){
                        changenumber("x/y");
                      },
          
                        child: Container(
                          height: 40,
                          width: 80,
                          decoration: BoxDecoration(color: Colors.orange,borderRadius: BorderRadius.circular(30)),
                          child: Center(child: Text("x/y",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),)),
                                     
                                    
                        ),
                      ),


        SizedBox(width: 20,),
        
                      
                    SizedBox(width: 15,),
                      InkWell(
          onTap: (){
            changenumber("0");
          },
                        child: Container(
                          height: 40,
                          width: 165,
                          decoration: BoxDecoration(color: Colors.blueAccent,borderRadius: BorderRadius.circular(30)),
                          child: Center(child: Text("0",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),)),
                                     
                                    
                                    
                        ),
                      ), SizedBox(width:15,),
                      InkWell(onTap: (){
                        changenumber("+");
                      },
                        child: Container(
                          height: 40,
                          width: 80,
                          decoration: BoxDecoration(color: Colors.blueAccent,borderRadius: BorderRadius.circular(30)),
                          child: Center(child: Text("+",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),)),
                                     
                                    
                        ),
                      ),
 SizedBox(width: 15,),
                      
                         InkWell(
                          onTap: () {
                            add();
                            sub();
                            mul();
                            div();
                            per();
                            Sin();
                            Cos();
                            Rad();
                            Deg();
                            TT();
                            log();
                            In();
                            EXP();
                            e();
                            tan();

                          },
                           child: Container(
                            height: 40,
                            width: 80,
                                                  decoration: BoxDecoration(color: Colors.blueAccent,borderRadius: BorderRadius.circular(30)),
                            child: Center(child: Text("=",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),)),
                                       
                                      
                                                   
                                      
                                                   ),
                         ),
                    


      ],
     )
          ])))]  ),

    );
  }
}