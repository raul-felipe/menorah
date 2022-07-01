import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Contato extends StatefulWidget{
  @override
  _ContatoState createState()=>_ContatoState(); 

}

class _ContatoState extends State<Contato>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contato"),
      ),
      body: Builder(
        builder: (context){
          return Container(
            child: Column(
              children: <Widget>[
                Card(
                  elevation: 6,
                  child: Container(
                    padding: EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Email", style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),),
                        Divider(height: 8.0,),
                        GestureDetector(
                          onTap: (){
                            Clipboard.setData(new ClipboardData(text: "secretaria@menorah.org.br"));
                            Scaffold.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Email copiado"),
                              )
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("secretaria@menorah.org.br"),
                              Icon(Icons.email),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(height: 16.0,),
                Card(
                  elevation: 6,
                  child: Container(
                    padding: EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Telefone", style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),),
                        Divider(height: 8.0,),
                        GestureDetector(
                          onTap: (){
                            Clipboard.setData(new ClipboardData(text: "38054559"));
                            Scaffold.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Telefone copiado"),
                                duration: Duration(seconds: 1),
                              )
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("3805-4559"),
                              Icon(Icons.phone),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
