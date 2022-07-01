import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'audiorow.dart';

class Audios extends StatefulWidget{
  @override
  _AudiosState createState()=>_AudiosState(); 

}

class _AudiosState extends State<Audios> with AutomaticKeepAliveClientMixin<Audios>{
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.keyboard_arrow_left),
                  Text("Arraste um item para\nCompartilhar ou Deletar", textAlign: TextAlign.center,),
                  Icon(Icons.keyboard_arrow_right),
                ],
              ),
            ),
            Flexible(
              child: StreamBuilder(
                stream:  FirebaseDatabase.instance.reference().child("audios").child("domingo").onValue,
                builder: (context, snap){
                  if(snap.hasData && !snap.hasError) {
                    List audios=[];
                    Map _list = snap.data.snapshot.value;
                    Map sorted = new SplayTreeMap.from(_list, (a, b) => int.parse(b).compareTo(int.parse(a)));
                    sorted.forEach((k,v){
                      audios.add(v);
                    });
                    return ListView.builder(
                      itemCount: audios.length,
                      itemBuilder: (context, index){
                        return AudioRow(audios, index);
                      },
                    );
                  }
                  return Scaffold(
                    body: Align(
                      alignment: FractionalOffset.center,
                      child: RefreshProgressIndicator(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
  }

  @override
  bool get wantKeepAlive => true;

}