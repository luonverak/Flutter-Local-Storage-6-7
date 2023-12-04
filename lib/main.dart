import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _counter = 0;
  static const mykey = 'mykey';
  setCounter() async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setInt(mykey, _counter += 1);
    getCounter();
  }

  getCounter() async {
    var prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = prefs.getInt(mykey) ?? 0;
    });
  }

  @override
  void initState() {
    getCounter();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Local Storage'),
      ),
      body: Center(
        child: Text(
          '$_counter',
          style: const TextStyle(fontSize: 30),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          setCounter();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
