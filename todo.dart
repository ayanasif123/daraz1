import 'package:flutter/material.dart';

class TodoList{
  TodoList._();
  static final instance = TodoList._();

  List<String> products = [];

  void addProduct(String p){
    products.add(p);
  }
}

class TodoScreen extends StatefulWidget{
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState()=>_TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen>{

  @override
  Widget build(BuildContext context){

    final list = TodoList.instance.products;

    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text("Cart List"),
      ),

      body: list.isEmpty
          ? const Center(
        child: Text("Cart Empty"),
      )
          : ListView.builder(
        itemCount: list.length,
        itemBuilder: (_,i){

          return Card(
            child: ListTile(
              title: Text(list[i]),
              trailing: IconButton(
                  icon: const Icon(Icons.delete,color: Colors.red),
                  onPressed: (){
                    setState(() {
                      list.removeAt(i);
                    });
                  }),
            ),
          );
        },
      ),
    );
  }
}