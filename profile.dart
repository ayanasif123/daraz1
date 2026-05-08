import 'package:flutter/foundation.dart' show Uint8List, kIsWeb;
import 'package:flutter/material.dart';
import 'package:grid/profile/splash.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:shared_preferences/shared_preferences.dart';

// ================== COLORS ==================
const Color kPrimary = Color(0xFF1A1A1A);
const Color kPink = Color(0xFF9E9E9E);
const Color kPinkLight = Color(0xFFF5F5F5);
const Color kPurpleLight = Color(0xFFEEEEEE);

const LinearGradient kPinkPurpleGradient = LinearGradient(
  colors: [Color(0xFF1A1A1A), Color(0xFF424242)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

const LinearGradient kBodyGradient = LinearGradient(
  colors: [Color(0xFFF5F5F5), Color(0xFFEEEEEE), Colors.white],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _profileImage;
  Uint8List? _webImage;
  final ImagePicker _picker = ImagePicker();

  String userName = "Ayan Developer";

  @override
  void initState() {
    super.initState();
    _loadProfileImage();
    _loadName();
  }

  // ================= LOAD NAME =================
  Future<void> _loadName() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString("user_name") ?? "Ayan Developer";
    });
  }

  // ================= LOAD IMAGE =================
  Future<void> _loadProfileImage() async {
    final prefs = await SharedPreferences.getInstance();
    final savedPath = prefs.getString('profile_image_path');

    if (!kIsWeb && savedPath != null && File(savedPath).existsSync()) {
      setState(() {
        _profileImage = File(savedPath);
      });
    }

    if (kIsWeb) {
      final webBytes = prefs.getString('web_image_bytes');
      if (webBytes != null) {
        setState(() {
          _webImage = Uint8List.fromList(webBytes.codeUnits);
        });
      }
    }
  }

  // ================= PICK IMAGE =================
  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;

    if (kIsWeb) {
      final bytes = await pickedFile.readAsBytes();
      setState(() => _webImage = bytes);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('web_image_bytes', String.fromCharCodes(bytes));
    } else {
      final dir = await getApplicationDocumentsDirectory();
      final fileName = path.basename(pickedFile.path);
      final savedFile =
          await File(pickedFile.path).copy('${dir.path}/$fileName');

      setState(() => _profileImage = savedFile);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('profile_image_path', savedFile.path);
    }
  }

  // ================= EDIT NAME =================
  void _editName() {
    TextEditingController controller =
        TextEditingController(text: userName);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text(
            "Edit Name",
            style: TextStyle(
                color: kPrimary, fontWeight: FontWeight.bold),
          ),
          content: TextField(
            controller: controller,
            cursorColor: kPrimary,
            decoration: InputDecoration(
              hintText: "Enter your name",
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: kPrimary, width: 2),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel",
                  style: TextStyle(color: Colors.grey)),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: kPinkPurpleGradient,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ElevatedButton(
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  setState(() {
                    userName = controller.text;
                  });
                  await prefs.setString("user_name", userName);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text("Save"),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ImageProvider? imageProvider;

    if (kIsWeb && _webImage != null) {
      imageProvider = MemoryImage(_webImage!);
    } else if (!kIsWeb && _profileImage != null) {
      imageProvider = FileImage(_profileImage!);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile Page",style: TextStyle(color: Colors.white),),
        flexibleSpace: Container(
          decoration: const BoxDecoration(gradient: kPinkPurpleGradient),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SplashScreen()),
              );
            },
            icon: const Icon(Icons.arrow_back),
          )
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(gradient: kBodyGradient),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),

                // ================= AVATAR WITH GREY RING =================
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: kPinkPurpleGradient,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      )
                    ],
                  ),
                  child: CircleAvatar(
                    radius: 70,
                    backgroundColor: kPurpleLight,
                    backgroundImage: imageProvider,
                    child: imageProvider == null
                        ? const Icon(Icons.person,
                            size: 70, color: kPrimary)
                        : null,
                  ),
                ),

                const SizedBox(height: 20),

                // ================= CHANGE PHOTO BUTTON =================
                Container(
                  decoration: BoxDecoration(
                    gradient: kPinkPurpleGradient,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ElevatedButton.icon(
                    onPressed: _pickImage,
                    icon: const Icon(Icons.photo_library),
                    label: const Text("Change Photo"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // ================= NAME =================
                Text(
                  userName,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: kPrimary,
                  ),
                ),

                const SizedBox(height: 6),

                // ================= ROLE BADGE =================
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  decoration: BoxDecoration(
                    color: kPinkLight,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.grey.shade400),
                  ),
                  child: const Text(
                    "Flutter Developer",
                    style: TextStyle(
                        fontSize: 14,
                        color: kPink,
                        fontWeight: FontWeight.w600),
                  ),
                ),

                const SizedBox(height: 15),

                // ================= EDIT NAME BUTTON =================
                Container(
                  decoration: BoxDecoration(
                    gradient: kPinkPurpleGradient,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ElevatedButton.icon(
                    onPressed: _editName,
                    icon: const Icon(Icons.edit),
                    label: const Text("Edit Name"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // ================= INFO CARD =================
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    elevation: 8,
                    shadowColor: Colors.black.withOpacity(0.12),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            color: Colors.grey.shade200, width: 1),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            _infoRow(Icons.email, "ayan@gmail.com"),
                            Divider(color: Colors.grey.shade100, thickness: 1.5),
                            _infoRow(Icons.phone, "+92 3000000000"),
                            Divider(color: Colors.grey.shade100, thickness: 1.5),
                            _infoRow(Icons.location_on, "Karachi, Pakistan"),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ================= INFO ROW HELPER =================
  Widget _infoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: kPinkLight,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: kPink, size: 20),
          ),
          const SizedBox(width: 15),
          Text(
            text,
            style: const TextStyle(fontSize: 15, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}