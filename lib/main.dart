import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: FutureBuilder<DatabaseReference>(
            future: Future.value(FirebaseDatabase.instance.ref()),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              if (snapshot.hasError) {
                return Text('Error: \\${snapshot.error}');
              }
              // Example: Write and read a value
              final ref = snapshot.data;
              ref?.set({'hello': 'world'});
              return const Text('Connected to Firebase Realtime Database!');
            },
          ),
        ),
      ),
    );
  }
}
