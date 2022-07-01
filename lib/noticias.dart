import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class Noticias extends StatefulWidget{
  @override
  _NoticiasState createState()=>_NoticiasState(); 

}

class _NoticiasState extends State<Noticias> with AutomaticKeepAliveClientMixin<Noticias>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
          stream: FirebaseDatabase.instance.reference().child("noticias").onValue,
          builder: (context, snap){
            if(snap.hasData && !snap.hasError){
                List titulo=[];
                List conteudo=[];
                if(snap.data.snapshot.value is List){
                  List _list = snap.data.snapshot.value;
                  _list.forEach((v){
                    titulo.add(v["titulo"]);
                    conteudo.add(v["conteudo"]);
                  });
                  return ListView.builder(
                    itemCount: titulo.length,
                    itemBuilder: (context, index){
                    return GestureDetector(
                      onTap: (){
                        showDialog(context: context, builder: (_)=> new AlertDialog(
                            title: new Text(titulo[index]),
                            content: new Text(conteudo[index]),
                          ),
                        );
                      },
                      child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(titulo[index], style: TextStyle(fontSize: 18.0),),
                      ),
                    ),
                    );
                    },
                  );
              }
            }
            return Scaffold(
              body: Align(
                alignment: FractionalOffset.center,
                child: RefreshProgressIndicator(),
              ),
            );
          },
        ),
      );
  }

  @override
  bool get wantKeepAlive => true;
}