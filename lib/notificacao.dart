import 'package:flutter/material.dart';

class Notificacao extends StatefulWidget{

  final message;

  Notificacao(this.message);

  @override
  _NotificacaoState createState()=>_NotificacaoState();

}

class _NotificacaoState extends State<Notificacao>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifição"),
      ),
      body: Container(
        child: Card(
          elevation: 6,
          child: Container(
            padding: EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(widget.message["data"]["title"].toString(), style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),),
                Divider(height: 8.0,),
                Text(widget.message["data"]["body"].toString(), style: TextStyle(fontSize: 18.0),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}