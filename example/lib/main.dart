import 'dart:async';

import 'package:flutter/material.dart';
import 'package:leads2keys_api/LKAccount.dart';
import 'package:leads2keys_api/Leads2Keys.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const WebviewLogin(
                              'https://api.l2k.io/auth/authorization?client_id=flutter')));
                },
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

class WebviewLogin extends StatelessWidget {
  final String? url;
  const WebviewLogin(this.url, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WebViewController? _controller;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Connexion à L2K'),
        ),
        body: Builder(builder: (BuildContext context) {
          return WebView(
            javascriptMode: JavascriptMode.unrestricted,
            initialUrl: url,
            onWebViewCreated: (WebViewController webViewController) async {
              _controller = webViewController;
            },
            onPageStarted: (url) => {
              if (url == 'https://api.l2k.io/auth/authorization')
                {
                  getResponse(_controller, url),
                  Navigator.pop(context),
                }
            },
          );
        }));
  }

  Future<String?> getResponse(WebViewController? controller, String url) async {
    String response = await controller!
        .runJavascriptReturningResult("document.documentElement.innerHTML");
    print(response);
  }
}
