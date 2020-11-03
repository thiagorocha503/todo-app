import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:launch_review/launch_review.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:lista_de_tarefas/constants.dart' as constants;
import 'package:lista_de_tarefas/view/view.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> implements IAboutPage {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sobre"),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.shop),
                    title: Text("Avalie na play store"),
                    onTap: () {
                      this.onStore();
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.share),
                    title: Text("Compartilhe com seus amigos"),
                    onTap: () {
                      this.onShare();
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.feedback),
                    title: Text("Contato"),
                    onTap: () {
                      this.onContact();
                    },
                  ),
                  AboutListTile(
                    icon: Icon(Icons.info),
                    applicationName: "Lista de tarefas",
                    applicationVersion: constants.APP_VERSION,
                    child: Text("Sobre o Lista de tarefa"),
                    applicationIcon: Image.asset(
                      'asset/todo.png',
                      height: 60,
                    ),
                    applicationLegalese: "Developed by Thiago R. Ferreira",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void onContact() async {
    String url = 'mailto:${constants.EMAIL_DEV}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void onShare() {
    Share.share("${constants.ANDROID_APP_LINK}");
  }

  @override
  void onStore() async {
    LaunchReview.launch();
  }
}
