import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:grid/registration/log.dart';
import 'package:grid/profile/profile.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

String userName = "Ayan";

// ================== COLORS ==================
const Color kPrimary    = Color(0xFF212121);
const Color kAccent     = Color(0xFFFF6F00);
const Color kBg         = Color(0xFFF8F8F8);
const Color kCard       = Colors.white;
const Color kSubtext    = Color(0xFF757575);
const Color kDivider    = Color(0xFFE0E0E0);
const Color kRed        = Color(0xFFE53935);

const LinearGradient kAppBarGradient = LinearGradient(
  colors: [Color(0xFF37474F), Color(0xFF212121)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

const LinearGradient kButtonGradient = LinearGradient(
  colors: [Color(0xFFFF8F00), Color(0xFFFF6F00)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

// ================== GLOBAL NOTIFICATION LIST ==================
final List<Map<String, dynamic>> globalNotifications = [
  {
    "icon": Icons.local_offer,
    "title": "Flash Sale!",
    "body": "50% off on all accessories today only",
    "time": "2 min ago",
    "color": kAccent,
  },
  {
    "icon": Icons.local_shipping,
    "title": "Order Shipped",
    "body": "Your order is on the way. Expected delivery in 3-5 days.",
    "time": "1 hour ago",
    "color": Color(0xFF1976D2),
  },
  {
    "icon": Icons.star,
    "title": "New Arrivals",
    "body": "Check out the latest phones and laptops in store",
    "time": "3 hours ago",
    "color": Color(0xFF388E3C),
  },
  {
    "icon": Icons.card_giftcard,
    "title": "Special Offer",
    "body": "Use code DARAZ20 to get 20% off on your next order",
    "time": "Yesterday",
    "color": Color(0xFF7B1FA2),
  },
];

// ================== FAVOURITE DATABASE ==================
class FavouriteList {
  FavouriteList._();
  static final FavouriteList instance = FavouriteList._();
  final List<Map<String, String>> _products = [];
  List<Map<String, String>> get products => _products;

  bool isFavourite(String name) => _products.any((p) => p["name"] == name);

  void toggleFavourite(String name, String price, String image) {
    if (isFavourite(name)) {
      _products.removeWhere((p) => p["name"] == name);
    } else {
      _products.add({"name": name, "price": price, "image": image});
    }
  }
}

// ================== CART DATABASE ==================
class TodoList {
  TodoList._();
  static final TodoList instance = TodoList._();
  final List<Map<String, String>> _products = [];
  List<Map<String, String>> get products => _products;
  void addProduct(String name, String price, String image) =>
      _products.add({"name": name, "price": price, "image": image});
}

// ================== MAIN APP ==================
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Daraz Store",
      // ✅ KEY FIX: brightness: Brightness.light — device ka dark mode override ho jata hai
      theme: ThemeData(
        brightness: Brightness.light,
        useMaterial3: true,
        scaffoldBackgroundColor: kBg,
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF37474F),
          secondary: kAccent,
          background: kBg,
          surface: kCard,
          onBackground: kPrimary,
          onSurface: kPrimary,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF37474F),
          elevation: 4,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        cardTheme: CardTheme(
          color: kCard,
          elevation: 3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          shadowColor: Colors.black26,
        ),
        drawerTheme: const DrawerThemeData(
          backgroundColor: kCard,
        ),
        textTheme: const TextTheme(
          bodyLarge:   TextStyle(color: kPrimary, fontSize: 16),
          bodyMedium:  TextStyle(color: kSubtext,  fontSize: 14),
          titleMedium: TextStyle(color: kPrimary,  fontWeight: FontWeight.w600),
        ),
      ),
      home: const DarazHome(),
    );
  }
}

// ================== SEARCH ==================
class ProductSearchDelegate extends SearchDelegate {
  final List<Map<String, String>> products;
  ProductSearchDelegate(this.products);

  @override
  ThemeData appBarTheme(BuildContext context) => ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 1,
          iconTheme: IconThemeData(color: kPrimary),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: InputBorder.none,
          hintStyle: TextStyle(color: kSubtext),
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(color: kPrimary, fontSize: 18),
        ),
      );

  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(icon: const Icon(Icons.clear, color: kPrimary), onPressed: () => query = "")
      ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        icon: const Icon(Icons.arrow_back, color: kPrimary),
        onPressed: () => close(context, null),
      );

  @override
  Widget buildResults(BuildContext context) => _buildList();

  @override
  Widget buildSuggestions(BuildContext context) => _buildList(onTap: true);

  Widget _buildList({bool onTap = false}) {
    final filtered = products
        .where((p) => p["name"]!.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return Container(
      color: Colors.white,
      child: ListView.builder(
        itemCount: filtered.length,
        itemBuilder: (context, i) {
          final p = filtered[i];
          return ListTile(
            tileColor: Colors.white,
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(p["image"]!, width: 50, height: 50, fit: BoxFit.cover),
            ),
            title: Text(p["name"]!, style: const TextStyle(color: kPrimary, fontWeight: FontWeight.w600)),
            subtitle: Text(p["price"]!, style: const TextStyle(color: kAccent, fontWeight: FontWeight.bold)),
            onTap: onTap ? () { query = p["name"]!; showResults(context); } : null,
          );
        },
      ),
    );
  }
}

// ================== HOME SCREEN ==================
class DarazHome extends StatefulWidget {
  const DarazHome({super.key});
  @override
  State<DarazHome> createState() => _DarazHomeState();
}

class _DarazHomeState extends State<DarazHome> {
  File? _profileImage;
  Uint8List? _webImage;
  String _displayName = "Ayan";
  String _selectedCategory = "All";

  final List<String> _categories = ["All", "Phones", "Laptops", "Accessories", "Fashion"];

  final List<Map<String, String>> products = [
    {"image": "lib/images/1.png", "name": "iPhone 17",   "price": "Rs. 180,000", "desc": "Latest flagship smartphone by Apple.",       "category": "Phones"},
    {"image": "lib/images/2.png", "name": "Dell Laptop", "price": "Rs. 120,000", "desc": "High performance laptop for work & gaming.", "category": "Laptops"},
    {"image": "lib/images/3.png", "name": "Smart Watch", "price": "Rs. 8,999",   "desc": "Fitness tracking smart watch.",               "category": "Accessories"},
    {"image": "lib/images/4.jpg", "name": "Headphones",  "price": "Rs. 3,499",   "desc": "High quality sound headphones.",              "category": "Accessories"},
    {"image": "lib/images/5.jpg", "name": "Bag",         "price": "Rs. 2,999",   "desc": "Stylish daily use bag.",                      "category": "Fashion"},
    {"image": "lib/images/6.jpg", "name": "Shoes",       "price": "Rs. 4,999",   "desc": "Comfortable trendy shoes.",                   "category": "Fashion"},
  ];

  @override
  void initState() {
    super.initState();
    _loadProfileImage();
    _loadName();
  }

  Future<void> _loadName() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _displayName = prefs.getString("user_name") ?? "Ayan";
      userName = _displayName;
    });
  }

  Future<void> _loadProfileImage() async {
    final prefs = await SharedPreferences.getInstance();
    final savedPath = prefs.getString('profile_image_path');
    if (!kIsWeb && savedPath != null && File(savedPath).existsSync()) {
      setState(() => _profileImage = File(savedPath));
    }
    if (kIsWeb) {
      final webBytes = prefs.getString('web_image_bytes');
      if (webBytes != null) setState(() => _webImage = Uint8List.fromList(webBytes.codeUnits));
    }
  }

  Future<void> _refreshAfterProfile() async {
    await _loadProfileImage();
    await _loadName();
  }

  // ---- Notification Sheet ----
  Widget _buildNotificationSheet(BuildContext ctx) {
    return StatefulBuilder(builder: (context, setSheet) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40, height: 4,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(color: kDivider, borderRadius: BorderRadius.circular(10)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Notifications (${globalNotifications.length})",
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kPrimary),
                ),
                TextButton(
                  onPressed: () {
                    setSheet(() => globalNotifications.clear());
                    setState(() {});
                    Navigator.pop(ctx);
                  },
                  child: const Text("Clear All", style: TextStyle(color: kRed)),
                ),
              ],
            ),
            const Divider(color: kDivider),
            if (globalNotifications.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Column(children: [
                  Icon(Icons.notifications_off_outlined, size: 48, color: Colors.grey.shade300),
                  const SizedBox(height: 10),
                  const Text("No notifications", style: TextStyle(color: kSubtext, fontSize: 14)),
                ]),
              )
            else
              ...globalNotifications.asMap().entries.map((entry) {
                final i = entry.key;
                final n = entry.value;
                return Dismissible(
                  key: ValueKey("${n["title"]}$i"),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 16),
                    margin: const EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(color: Colors.red.shade50, borderRadius: BorderRadius.circular(12)),
                    child: const Icon(Icons.delete, color: kRed),
                  ),
                  onDismissed: (_) {
                    setSheet(() => globalNotifications.removeAt(i));
                    setState(() {});
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      color: kBg,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: kDivider),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: (n["color"] as Color).withOpacity(0.12),
                        child: Icon(n["icon"] as IconData, color: n["color"] as Color, size: 20),
                      ),
                      title: Text(n["title"], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: kPrimary)),
                      subtitle: Text(n["body"], style: const TextStyle(fontSize: 12, color: kSubtext)),
                      trailing: Text(n["time"], style: const TextStyle(fontSize: 11, color: kSubtext)),
                    ),
                  ),
                );
              }),
            const SizedBox(height: 12),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _selectedCategory == "All"
        ? products
        : products.where((p) => p["category"] == _selectedCategory).toList();

    final int favCount   = FavouriteList.instance.products.length;
    final int notifCount = globalNotifications.length;

    return Scaffold(
      backgroundColor: kBg,
      appBar: AppBar(
        flexibleSpace: Container(decoration: const BoxDecoration(gradient: kAppBarGradient)),
        title: const Text("Daraz Store"),
        actions: [
          // Favourite button
          Stack(children: [
            Container(
              margin: const EdgeInsets.only(top: 8, bottom: 8, left: 4),
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.15), borderRadius: BorderRadius.circular(10)),
              child: IconButton(
                icon: const Icon(Icons.favorite, color: Colors.white),
                onPressed: () async {
                  await Navigator.push(context, MaterialPageRoute(builder: (_) => const FavouritesScreen()));
                  setState(() {});
                },
              ),
            ),
            if (favCount > 0)
              Positioned(
                right: 4, top: 4,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(color: kRed, shape: BoxShape.circle),
                  child: Text("$favCount", style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                ),
              ),
          ]),
          // Notification button
          Stack(children: [
            Container(
              margin: const EdgeInsets.only(top: 8, bottom: 8, left: 4),
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.15), borderRadius: BorderRadius.circular(10)),
              child: IconButton(
                icon: const Icon(Icons.notifications, color: Colors.white),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (ctx) => _buildNotificationSheet(ctx),
                  ).then((_) => setState(() {}));
                },
              ),
            ),
            if (notifCount > 0)
              Positioned(
                right: 4, top: 4,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(color: kAccent, shape: BoxShape.circle),
                  child: Text("$notifCount", style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                ),
              ),
          ]),
          // Search button
          Container(
            margin: const EdgeInsets.only(right: 10, top: 8, bottom: 8, left: 4),
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.15), borderRadius: BorderRadius.circular(10)),
            child: IconButton(
              icon: const Icon(Icons.search, color: Colors.white),
              onPressed: () => showSearch(context: context, delegate: ProductSearchDelegate(products)),
            ),
          ),
        ],
      ),

      // ================== DRAWER ==================
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: Column(
          children: [
            // Header
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(gradient: kAppBarGradient),
              accountName: Text(_displayName,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
              accountEmail: const Text("ayan@gmail.com", style: TextStyle(color: Colors.white70)),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: kIsWeb
                    ? (_webImage != null ? MemoryImage(_webImage!) : null)
                    : (_profileImage != null ? FileImage(_profileImage!) : null) as ImageProvider?,
                child: (_profileImage == null && _webImage == null)
                    ? const Icon(Icons.person, size: 40, color: kPrimary)
                    : null,
              ),
            ),
            // Tiles
            Expanded(
              child: Container(
                color: Colors.white,
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    _drawerTile(
                      icon: Icons.person_outline,
                      iconColor: const Color(0xFF1976D2),
                      label: "Profile",
                      onTap: () async {
                        Navigator.pop(context);
                        await Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfileScreen()));
                        _refreshAfterProfile();
                      },
                    ),
                    const Divider(color: kDivider, height: 1, indent: 16, endIndent: 16),
                    _drawerTile(
                      icon: Icons.favorite_outline,
                      iconColor: kRed,
                      label: "Favourites",
                      badge: favCount,
                      badgeColor: kRed,
                      onTap: () async {
                        Navigator.pop(context);
                        await Navigator.push(context, MaterialPageRoute(builder: (_) => const FavouritesScreen()));
                        setState(() {});
                      },
                    ),
                    const Divider(color: kDivider, height: 1, indent: 16, endIndent: 16),
                    _drawerTile(
                      icon: Icons.shopping_cart_outlined,
                      iconColor: const Color(0xFF388E3C),
                      label: "Cart",
                      badge: TodoList.instance.products.length,
                      badgeColor: const Color(0xFF388E3C),
                      onTap: () async {
                        Navigator.pop(context);
                        await Navigator.push(context, MaterialPageRoute(builder: (_) => const TodoScreen()));
                        setState(() {});
                      },
                    ),
                    const Divider(color: kDivider, height: 1, indent: 16, endIndent: 16),
                    _drawerTile(
                      icon: Icons.logout,
                      iconColor: kRed,
                      label: "Logout",
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
          ],
        ),
      ),

      // ================== BODY ==================
      body: Column(
        children: [
          // Category bar
          Container(
            color: Colors.white,
            height: 54,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              itemCount: _categories.length,
              itemBuilder: (context, i) {
                final cat = _categories[i];
                final selected = cat == _selectedCategory;
                return GestureDetector(
                  onTap: () => setState(() => _selectedCategory = cat),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    decoration: BoxDecoration(
                      color: selected ? const Color(0xFF37474F) : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: selected ? const Color(0xFF37474F) : kDivider),
                    ),
                    child: Text(
                      cat,
                      style: TextStyle(
                        color: selected ? Colors.white : kPrimary,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const Divider(color: kDivider, height: 1),
          // Product grid
          Expanded(
            child: filtered.isEmpty
                ? const Center(
                    child: Text("No products in this category",
                        style: TextStyle(fontSize: 15, color: kSubtext, fontWeight: FontWeight.w500)),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: filtered.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.72,
                    ),
                    itemBuilder: (context, i) {
                      final p = filtered[i];
                      return ProductItem(
                        image: p["image"]!,
                        name: p["name"]!,
                        price: p["price"]!,
                        description: p["desc"]!,
                        onFavouriteToggled: () => setState(() {}),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _drawerTile({
    required IconData icon,
    required Color iconColor,
    required String label,
    required VoidCallback onTap,
    int badge = 0,
    Color badgeColor = kAccent,
  }) {
    return Material(
      color: Colors.white,
      child: ListTile(
        tileColor: Colors.white,
        leading: Container(
          width: 38, height: 38,
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: iconColor, size: 20),
        ),
        title: Text(label, style: const TextStyle(color: kPrimary, fontWeight: FontWeight.w600, fontSize: 15)),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (badge > 0)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(color: badgeColor, borderRadius: BorderRadius.circular(10)),
                child: Text("$badge", style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
              ),
            const SizedBox(width: 6),
            Icon(Icons.chevron_right, color: Colors.grey.shade400, size: 20),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}

// ================== PRODUCT ITEM ==================
class ProductItem extends StatefulWidget {
  final String image, name, price, description;
  final VoidCallback? onFavouriteToggled;

  const ProductItem({
    super.key,
    required this.image,
    required this.name,
    required this.price,
    required this.description,
    this.onFavouriteToggled,
  });

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  bool get _isFav => FavouriteList.instance.isFavourite(widget.name);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: kCard,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductDetailScreen(
              image: widget.image,
              name: widget.name,
              price: widget.price,
              description: widget.description,
            ),
          ),
        ).then((_) => setState(() {})),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                    child: Image.asset(widget.image, fit: BoxFit.cover),
                  ),
                  Positioned(
                    top: 8, right: 8,
                    child: GestureDetector(
                      onTap: () {
                        FavouriteList.instance.toggleFavourite(widget.name, widget.price, widget.image);
                        setState(() {});
                        widget.onFavouriteToggled?.call();
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(_isFav
                              ? "${widget.name} favourites mein add hua!"
                              : "${widget.name} favourites se hata diya."),
                          backgroundColor: kPrimary,
                          duration: const Duration(seconds: 1),
                        ));
                      },
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)],
                        ),
                        child: Icon(
                          _isFav ? Icons.favorite : Icons.favorite_border,
                          color: _isFav ? kRed : kSubtext,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 2),
              child: Text(widget.name,
                  style: const TextStyle(color: kPrimary, fontWeight: FontWeight.bold, fontSize: 14),
                  maxLines: 1, overflow: TextOverflow.ellipsis),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: Text(widget.price,
                  style: const TextStyle(color: kAccent, fontWeight: FontWeight.bold, fontSize: 13)),
            ),
          ],
        ),
      ),
    );
  }
}

// ================== PRODUCT DETAIL SCREEN ==================
class ProductDetailScreen extends StatefulWidget {
  final String image, name, price, description;
  const ProductDetailScreen({
    super.key,
    required this.image, required this.name,
    required this.price, required this.description,
  });
  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  bool get _isFav => FavouriteList.instance.isFavourite(widget.name);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      appBar: AppBar(
        flexibleSpace: Container(decoration: const BoxDecoration(gradient: kAppBarGradient)),
        title: Text(widget.name),
        actions: [
          IconButton(
            icon: Icon(_isFav ? Icons.favorite : Icons.favorite_border,
                color: _isFav ? kRed : Colors.white),
            onPressed: () => setState(() =>
                FavouriteList.instance.toggleFavourite(widget.name, widget.price, widget.image)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: kCard,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 12, offset: const Offset(0, 4))],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(widget.image, height: 280, width: double.infinity, fit: BoxFit.cover),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: kCard,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 10)],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(widget.name,
                            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: kPrimary)),
                      ),
                      GestureDetector(
                        onTap: () => setState(() =>
                            FavouriteList.instance.toggleFavourite(widget.name, widget.price, widget.image)),
                        child: Icon(_isFav ? Icons.favorite : Icons.favorite_border,
                            color: _isFav ? kRed : kSubtext, size: 26),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(widget.price,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: kAccent)),
                  const SizedBox(height: 12),
                  const Divider(color: kDivider),
                  const SizedBox(height: 8),
                  Text(widget.description,
                      style: const TextStyle(fontSize: 15, color: kSubtext, height: 1.6)),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: Container(
                      decoration: BoxDecoration(gradient: kButtonGradient, borderRadius: BorderRadius.circular(14)),
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.shopping_cart_outlined, color: Colors.white),
                        label: const Text("Buy Now",
                            style: TextStyle(fontSize: 17, color: Colors.white, fontWeight: FontWeight.bold)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        ),
                        onPressed: () {
                          TodoList.instance.addProduct(widget.name, widget.price, widget.image);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("${widget.name} cart mein add hua!"),
                            backgroundColor: kPrimary,
                          ));
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const TodoScreen()));
                        },
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
    );
  }
}

// ================== FAVOURITES SCREEN ==================
class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({super.key});
  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  @override
  Widget build(BuildContext context) {
    final products = FavouriteList.instance.products;
    return Scaffold(
      backgroundColor: kBg,
      appBar: AppBar(
        flexibleSpace: Container(decoration: const BoxDecoration(gradient: kAppBarGradient)),
        title: const Text("My Favourites"),
      ),
      body: products.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite_border, size: 72, color: Colors.grey.shade300),
                  const SizedBox(height: 16),
                  const Text("Koi favourite nahi hai abhi",
                      style: TextStyle(fontSize: 16, color: kPrimary, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  const Text("Products pe dil button dabao!", style: TextStyle(fontSize: 13, color: kSubtext)),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: products.length,
              itemBuilder: (context, i) {
                final p = products[i];
                return Dismissible(
                  key: ValueKey(p["name"]),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    margin: const EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: Colors.red.shade100),
                    ),
                    child: const Icon(Icons.delete, color: kRed),
                  ),
                  onDismissed: (_) {
                    setState(() => FavouriteList.instance.products.removeAt(i));
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("${p["name"]} favourites se hata diya"),
                      backgroundColor: kPrimary,
                      duration: const Duration(seconds: 1),
                    ));
                  },
                  child: Card(
                    color: kCard,
                    margin: const EdgeInsets.only(bottom: 8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(p["image"]!, width: 56, height: 56, fit: BoxFit.cover),
                      ),
                      title: Text(p["name"]!,
                          style: const TextStyle(color: kPrimary, fontWeight: FontWeight.bold, fontSize: 14)),
                      subtitle: Text(p["price"]!,
                          style: const TextStyle(color: kAccent, fontWeight: FontWeight.bold, fontSize: 13)),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.shopping_cart_outlined, color: Color(0xFF388E3C)),
                            onPressed: () {
                              TodoList.instance.addProduct(p["name"]!, p["price"]!, p["image"]!);
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("${p["name"]} cart mein add hua!"),
                                backgroundColor: kPrimary,
                                duration: const Duration(seconds: 1),
                              ));
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.favorite, color: kRed),
                            onPressed: () => setState(() => FavouriteList.instance.products.removeAt(i)),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}

// ================== CART SCREEN ==================
class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});
  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  void _placeOrder() {
    final products = TodoList.instance.products;
    if (products.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Cart is empty! Add products first."),
        backgroundColor: kPrimary,
      ));
      return;
    }
    globalNotifications.insert(0, {
      "icon": Icons.check_circle,
      "title": "Order Placed! 🎉",
      "body": "Aapka ${products.length} item(s) ka order place ho gaya. Delivery: 3-5 din.",
      "time": "Abhi abhi",
      "color": const Color(0xFF388E3C),
    });
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        backgroundColor: kCard,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 10),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(18),
              decoration: const BoxDecoration(color: Color(0xFFE8F5E9), shape: BoxShape.circle),
              child: const Icon(Icons.check_circle_rounded, color: Color(0xFF388E3C), size: 60),
            ),
            const SizedBox(height: 16),
            const Text("Order Confirmed!",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: kPrimary)),
            const SizedBox(height: 10),
            Text(
              "Shukriya $userName! 🎉\nAapka order successfully place ho gaya hai.",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, color: kSubtext, height: 1.5),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(color: kBg, borderRadius: BorderRadius.circular(12)),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.local_shipping_outlined, color: kPrimary, size: 18),
                  SizedBox(width: 8),
                  Text("Delivery: 3-5 business days",
                      style: TextStyle(color: kPrimary, fontWeight: FontWeight.w600, fontSize: 13)),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: Container(
                decoration: BoxDecoration(gradient: kButtonGradient, borderRadius: BorderRadius.circular(14)),
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.shopping_bag_outlined, color: Colors.white),
                  label: const Text("Continue Shopping",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    padding: const EdgeInsets.symmetric(vertical: 13),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  onPressed: () {
                    setState(() => TodoList.instance.products.clear());
                    Navigator.pop(ctx);
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final products = TodoList.instance.products;
    return Scaffold(
      backgroundColor: kBg,
      appBar: AppBar(
        flexibleSpace: Container(decoration: const BoxDecoration(gradient: kAppBarGradient)),
        title: const Text("Cart"),
      ),
      body: products.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart_outlined, size: 72, color: Colors.grey.shade300),
                  const SizedBox(height: 16),
                  const Text("Cart is empty",
                      style: TextStyle(fontSize: 16, color: kPrimary, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  const Text("Koi product add karein!", style: TextStyle(fontSize: 13, color: kSubtext)),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: products.length,
                    itemBuilder: (context, i) {
                      final p = products[i];
                      return Card(
                        color: kCard,
                        margin: const EdgeInsets.only(bottom: 8),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(p["image"]!, width: 56, height: 56, fit: BoxFit.cover),
                          ),
                          title: Text(p["name"]!,
                              style: const TextStyle(color: kPrimary, fontWeight: FontWeight.bold, fontSize: 14)),
                          subtitle: Text(p["price"]!,
                              style: const TextStyle(color: kAccent, fontWeight: FontWeight.bold, fontSize: 13)),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete_outline, color: kRed),
                            onPressed: () {
                              final removed = products[i];
                              setState(() => products.removeAt(i));
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("${removed["name"]} deleted"),
                                backgroundColor: kPrimary,
                                action: SnackBarAction(
                                  label: "UNDO",
                                  textColor: Colors.white,
                                  onPressed: () => setState(() => products.insert(i, removed)),
                                ),
                              ));
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 14, 16, 24),
                  decoration: BoxDecoration(
                    color: kCard,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.07), blurRadius: 10, offset: const Offset(0, -3))],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("${products.length} item(s) in cart",
                              style: const TextStyle(fontSize: 13, color: kSubtext)),
                          const Icon(Icons.shopping_cart_outlined, color: kSubtext, size: 18),
                        ],
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: Container(
                          decoration: BoxDecoration(gradient: kButtonGradient, borderRadius: BorderRadius.circular(14)),
                          child: ElevatedButton.icon(
                            icon: const Icon(Icons.check_circle_outline, color: Colors.white),
                            label: const Text("Place Order",
                                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                            ),
                            onPressed: _placeOrder,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}