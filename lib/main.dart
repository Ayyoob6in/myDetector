import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'text_detector.dart';

List<CameraDescription> cameras = [];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String text = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue, // Customize background color
        title: const Text(
          'My Detector', // Customize title text
          style: TextStyle(
            fontSize: 20.0, // Customize title font size
            fontWeight: FontWeight.w400, // Customize title font weight
            letterSpacing: 1.2, // Customize letter spacing
          ),
        ),
        centerTitle: true, // Center the title
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                TextField(
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w500),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(width: 1.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Colors.blue, width: 1.0),
                    ),
                    contentPadding: EdgeInsets.all(10.0),
                    hintText: 'Enter the text',
                    hintStyle: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.w400),
                    prefixIcon: Icon(Icons.search, color: Colors.blue),
                  ),
                  onChanged: (val) {
                    setState(() {
                      text = val;
                    });
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(150, 40),
                      padding: const EdgeInsets.symmetric(horizontal: 22),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      elevation: 1),
                  onPressed: text.isEmpty
                      ? null
                      : () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      TextRecognizerView(text: text)));
                        },
                  child: const Text('Find'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
