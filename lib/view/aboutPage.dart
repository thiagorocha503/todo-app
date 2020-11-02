import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lista_de_tarefas/presenter/aboutPresenter.dart';
import 'package:lista_de_tarefas/presenter/presenter.dart';
import 'package:lista_de_tarefas/view/view.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:lista_de_tarefas/constants.dart' as constants;

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> implements IAboutPage {
  IAboutPresenter presenter;

  @override
  void initState() {
    super.initState();
    this.presenter = new AboutPresenter();
    this.presenter.setView(this);
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
                  title: Text("Avalie ou comente"),
                  onTap: (){
                    this.onShop();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.share),
                  title: Text("Compartilhe com seus amigos"),
                  onTap:(){
                    this.onShare();
                  }
                ),
                ListTile(
                  leading: Icon(Icons.feedback),
                  title: Text("Feedback"),
                  onTap: () {
                    this.onFeedBack();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.info),
                  title: Text("Versão"),
                  subtitle: Text("${constants.version}"),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }

  @override
  void onFeedBack() {
    this.presenter.sendFeedBack();
  }

  @override
  void onShare() {
    this.presenter.share();
  }

  @override
  void onShop() {
    this.presenter.shop();
  }

  @override
  void openShop() async {
    
  }

  @override
  void sendEmail(String email) async {
    String url = 'mailto:$email';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void shareApp(String link) {
    Share.share("$link");
  }
}
