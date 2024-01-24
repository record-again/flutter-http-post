import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController nameInput = TextEditingController();
  TextEditingController jobInput = TextEditingController();

  Future<String> postData(String url) async {
    var response = await http.post(Uri.parse(url),
        body: {"name": nameInput.text, "job": jobInput.text});
    if (response.statusCode == 201) {
      Map<String, dynamic> data =
          jsonDecode(response.body) as Map<String, dynamic>;
      print(data);
    } else {
      throw Exception('Failed to post');
    }
    return response.body;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Textfield'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            controller: nameInput,
            autocorrect: false,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                labelText: "Name",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
                prefixIcon: const Icon(Icons.people)),
          ),
          const SizedBox(
            height: 30,
          ),
          TextField(
            controller: jobInput,
            autocorrect: false,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              labelText: "Job",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
              prefixIcon: const Icon(Icons.badge),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          ElevatedButton(
            onPressed: () {
              postData('https://reqres.in/api/users');
            },
            style:
                ElevatedButton.styleFrom(backgroundColor: Colors.purple[200]),
            child: const Text("POST"),
          )
        ],
      ),
    );
  }
}
