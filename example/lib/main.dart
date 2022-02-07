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
  String clientId = "flutter";
  String clientSecret = "b076542a-13dd-4d7d-aed6-b4a741f6de8f";

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
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                            child: WebviewLogin(
                                'https://api.l2k.io/auth/authorization?client_id=$clientId',
                                clientId,
                                clientSecret));
                      });
                },
                child: const Text("Se connecter")),
            ElevatedButton(
                onPressed: () =>
                    account!.agency.getMandates("status=available"),
                child: const Text("Récupérer les mandats"))
          ],
        )));
  }
}

class WebviewLogin extends StatelessWidget {
  final String? url;
  final String clientId;
  final String clientSecret;

  const WebviewLogin(this.url, this.clientId, this.clientSecret, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WebView(
        initialUrl: url,
        navigationDelegate: (navigation) async {
          if (navigation.url.startsWith('l2k://')) {
            L2K().signIn(navigation.url, clientId, clientSecret);
            NavigationDecision.prevent;
            Navigator.pop(context);
            return NavigationDecision.prevent;
          } else {
            return NavigationDecision.navigate;
          }
        });
  }
}
