import 'package:flutter/material.dart';
import 'package:grid/log.dart'; // Login screen
import 'package:grid/profile.dart'; // Profile screen

void main() {
  runApp(const MyApp());
}

// ================== MAIN APP ==================
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Daraz Store",
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.deepPurple,
          elevation: 6,
          titleTextStyle: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            textStyle:
                const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        textTheme: const TextTheme(
          headlineLarge:
              TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.black),
          headlineMedium:
              TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.deepPurple),
          bodyLarge: TextStyle(fontSize: 18, color: Colors.black87),
          bodyMedium: TextStyle(fontSize: 16, color: Colors.black54),
        ),
        cardTheme: CardTheme(
          elevation: 6,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          shadowColor: Colors.grey.shade400,
        ),
      ),
      home: const DarazHome(),
    );
  }
}

// ================== HOME SCREEN ==================
class DarazHome extends StatelessWidget {
  const DarazHome({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> products = [
      {
        "image": "lib/images/1.png",
        "name": "iPhone 17",
        "price": "Rs. 180,000",
        "desc": "The iPhone 17 is latest flagship smartphone."
      },
      {
        "image": "lib/images/2.png",
        "name": "Dell Laptop",
        "price": "Rs. 120,000",
        "desc": "High performance laptop for work and gaming."
      },
      {
        "image": "lib/images/3.png",
        "name": "Smart Watch",
        "price": "Rs. 8,999",
        "desc": "Fitness tracking smart watch."
      },
      {
        "image": "lib/images/4.jpg",
        "name": "Headphones",
        "price": "Rs. 3,499",
        "desc": "High quality sound headphones."
      },
      {
        "image": "lib/images/5.jpg",
        "name": "Bag",
        "price": "Rs. 2,999",
        "desc": "Stylish daily use bag."
      },
      {
        "image": "lib/images/6.jpg",
        "name": "Shoes",
        "price": "Rs. 4,999",
        "desc": "Comfortable trendy shoes."
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Daraz Store"),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.deepPurple, Colors.purpleAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight)),
        ),
      ),
      drawer: Drawer(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.purpleAccent, Colors.deepPurple],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter),
          ),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.deepPurple, Colors.purpleAccent]),
                ),
                accountName: const Text("Ayan Developer"),
                accountEmail: const Text("ayan@gmail.com"),
                currentAccountPicture: const CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person,
                      size: 40, color: Colors.deepPurple),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.person, color: Colors.white),
                title: const Text("Profile", style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ProfileScreen()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.shopping_cart, color: Colors.white),
                title: const Text("Cart", style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const TodoScreen()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.white),
                title: const Text("Logout", style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const Login()),
                    (route) => false,
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purpleAccent, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: GridView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: products.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.75,
          ),
          itemBuilder: (context, index) {
            final product = products[index];
            return ProductItem(
              image: product["image"]!,
              name: product["name"]!,
              price: product["price"]!,
              description: product["desc"]!,
            );
          },
        ),
      ),
    );
  }
}

// ================== PRODUCT ITEM ==================
class ProductItem extends StatelessWidget {
  final String image;
  final String name;
  final String price;
  final String description;

  const ProductItem({
    super.key,
    required this.image,
    required this.name,
    required this.price,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ProductDetailScreen(
                image: image,
                name: name,
                price: price,
                description: description,
              ),
            ),
          );
        },
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(18)),
                child: Image.asset(image, width: double.infinity, fit: BoxFit.cover),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(name,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold, color: Colors.deepPurple)),
            ),
            Text(price,
                style: const TextStyle(
                    color: Colors.redAccent, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

// ================== PRODUCT DETAIL SCREEN ==================
class ProductDetailScreen extends StatelessWidget {
  final String image;
  final String name;
  final String price;
  final String description;

  const ProductDetailScreen({
    super.key,
    required this.image,
    required this.name,
    required this.price,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.deepPurple, Colors.purpleAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight)),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.purpleAccent, Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    )
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    image,
                    height:450,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 150),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      price,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      description,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          TodoList.instance.addProduct(name, price, image);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("$name added to cart"),
                              backgroundColor: Colors.deepPurple,
                            ),
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const TodoScreen()),
                          );
                        },

                        
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          backgroundColor: Colors.deepPurple,
                        ),
                        child: const Text(
                          "Buy Now",
                          style: TextStyle(fontSize: 18,color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

// ================== CART DATABASE ==================
class TodoList {
  TodoList._privateConstructor();
  static final TodoList instance = TodoList._privateConstructor();

  final List<Map<String, String>> _products = [];

  List<Map<String, String>> get products => _products;

  void addProduct(String name, String price, String image) {
    _products.add({"name": name, "price": price, "image": image});
  }
}

// ================== CART SCREEN ==================
class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  @override
  Widget build(BuildContext context) {
    final products = TodoList.instance.products;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.deepPurple, Colors.purpleAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight)),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.purpleAccent, Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        child: products.isEmpty
            ? const Center(
                child: Text("Cart is empty",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple)),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return Card(
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          product["image"]!,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(product["name"]!,

                          style: const TextStyle(color: Colors.deepPurple)),
                      subtitle: Text(product["price"]!,
                          style: const TextStyle(
                              color: Colors.redAccent,
                              fontWeight: FontWeight.bold)),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          final removedItem = products[index];
                          setState(() {
                            products.removeAt(index);
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("${removedItem["name"]} deleted"),
                              action: SnackBarAction(
                                label: "UNDO",
                                onPressed: () {
                                  setState(() {
                                    products.insert(index, removedItem);
                                  });
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}