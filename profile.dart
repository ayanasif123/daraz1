import 'package:flutter/foundation.dart' show Uint8List, kIsWeb;
import 'package:flutter/material.dart';
import 'package:grid/splash.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path; // Alias to avoid conflict

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _profileImage; // Mobile
  Uint8List? _webImage; // Web
  final ImagePicker _picker = ImagePicker();

  // Pick image
  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      if (kIsWeb) {
        final bytes = await pickedFile.readAsBytes();
        setState(() {
          _webImage = bytes;
        });
      } else {
        setState(() {
          _profileImage = File(pickedFile.path);
        });
      }
    }
  }

  // Save image (mobile)
  Future<void> _saveImage() async {
    if (_profileImage == null && _webImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No image selected to save!")),
      );
      return;
    }

    if (kIsWeb) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
                "Web: Saving images requires browser download logic.")),
      );
      return;
    }

    if (_profileImage != null) {
      final dir = await getApplicationDocumentsDirectory();
      final fileName = path.basename(_profileImage!.path);
      final savedFile = await _profileImage!.copy('${dir.path}/$fileName');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Image saved at: ${savedFile.path}")),
      );
    }
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
        title: const Text("Profile Page"),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple, Colors.purpleAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Navigate to SplashScreen or previous screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SplashScreen()),
              );
            },
            icon: const Icon(Icons.arrow_back),
          )
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purpleAccent, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 70,
                  backgroundColor: Colors.deepPurple.shade200,
                  backgroundImage: imageProvider,
                  child: imageProvider == null
                      ? const Icon(Icons.person, size: 70, color: Colors.white)
                      : null,
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: _pickImage,
                  icon: const Icon(Icons.photo_library),
                  label: const Text("Change Photo"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    textStyle: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                  onPressed: _saveImage,
                  icon: const Icon(Icons.save),
                  label: const Text("Save Photo"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purpleAccent,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    textStyle: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Ayan Developer",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Flutter Developer",
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: const [
                          Row(
                            children: [
                              Icon(Icons.email, color: Colors.deepPurple),
                              SizedBox(width: 15),
                              Text("ayan@gmail.com"),
                            ],
                          ),
                          Divider(),
                          Row(
                            children: [
                              Icon(Icons.phone, color: Colors.deepPurple),
                              SizedBox(width: 15),
                              Text("+92 3000000000"),
                            ],
                          ),
                          Divider(),
                          Row(
                            children: [
                              Icon(Icons.location_on, color: Colors.deepPurple),
                              SizedBox(width: 15),
                              Text("Karachi, Pakistan"),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}