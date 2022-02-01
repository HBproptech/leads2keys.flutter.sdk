import 'package:flutter/material.dart';
import 'package:leads2keys_api/LKAccount.dart';
import 'package:leads2keys_api/Leads2Keys.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test API',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Test API L2K'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  LKAccount? account;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
            child: Column(
          children: [
            const Text("Test de l'API de Leads2Keys"),
            ElevatedButton(
                onPressed: () => createClient(),
                child: const Text("Créer un client")),
            ElevatedButton(
                onPressed: () async {
                  account =
                      await LK().signIn({'login': 'test', 'password': 'test'});
                },
                child: const Text("Se connecter")),
            ElevatedButton(
                onPressed: () => account!.getMandates("status=available"),
                child: const Text("Récupérer les mandats"))
          ],
        )));
  }
}
