import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'estudos.dart';
import 'noticias.dart';
import 'audios.dart';
import 'contribua.dart';
import 'contato.dart';
import 'notificacao.dart';
import 'inicio.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    FirebaseDatabase database = FirebaseDatabase.instance;
    database.setPersistenceEnabled(true);
    database.setPersistenceCacheSizeBytes(10000000);
    FirebaseMessaging messaging = new FirebaseMessaging();
    messaging.subscribeToTopic("todos");
    return MaterialApp(
      title: 'Batista Menorah',
      theme: ThemeData(
        primaryColor: Color(0xff0B5FBD),
        accentColor: Color(0xffFD7B09),
        primaryColorDark: Color(0xff0A56A4),
        primaryColorLight: Color.fromRGBO(0, 103, 182, 100),
        
      ),
      home: MyHomePage(title: 'Batista Menorah'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>{

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  
  
  @override
  void initState() {
    super.initState();
    firebaseNotitificationListener();
  }

  

  void firebaseNotitificationListener(){
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>new Notificacao(message)));
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");

        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>new Notificacao(message)));
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>new Notificacao(message)));
      },
    );
    _firebaseMessaging.getToken().then((String token) {});
  }
  @override
  Widget build(BuildContext context) {
    List<Widget> tabs =  [
      Inicio(),
      Noticias(),
      Estudos(),
      Audios(),
    ];

    return DefaultTabController(
      length: 4,
      child: Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the Drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Image.asset("image/menorah.png"),
            ),
            ListTile(
              title: Text("Contato"),
              trailing: Icon(Icons.contacts),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>new Contato()));
              },
            ),
            // ListTile(
            //   title: Text("Sua Conta"),
            //   trailing: Icon(Icons.account_circle),
            //   onTap: () {
            //     Navigator.of(context).pop();
            //   },
            // ),
            ListTile(
              title: Text("Contribuição"),
              trailing: Icon(Icons.credit_card),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>new Contribua()));
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: new Material(
        color: Color(0xff0B5FBD),
        child: new TabBar(
          tabs: <Widget>[
            new Tab(
            icon: new Icon(Icons.home),
            text: 'Inicio',
          ),
          new Tab(
            icon: new Icon(Icons.subtitles),
            text: 'Noticias',
          ),
          new Tab(
            icon: Icon(Icons.assignment),
            text: 'Estudos',
          ),
          new Tab(
            icon: Icon(Icons.audiotrack),
            text: 'Audios',
          )
          ],
        ),
      ),
      body:
        new TabBarView(
          children: tabs,
        ),
      ),
    );
  }
}