import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class Estudos extends StatefulWidget{
  @override
  _EstudosState createState()=>_EstudosState(); 

}

class _EstudosState extends State<Estudos> with AutomaticKeepAliveClientMixin<Estudos>{

  double _fontSize= 14.0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
          stream: FirebaseDatabase.instance.reference().child("estudos").onValue,
          builder: (BuildContext context, AsyncSnapshot snap){
            if(snap.hasData && !snap.hasError) {
              List titulo=[];
              List conteudo=[];
              if(snap.data.snapshot.value is Map){
                Map _list = snap.data.snapshot.value;
                Map sorted = new SplayTreeMap.from(_list, (a, b) => int.parse(b).compareTo(int.parse(a)));
                sorted.forEach((k,v){
                  titulo.add(v["titulo"]);
                  conteudo.add(v["conteudo"]);
                });
                return ListView.builder(
                  itemCount: titulo.length,
                  itemBuilder: (context, index) {
                    return new ExpansionTile(
                      title: Text(titulo[index], style: TextStyle(fontSize: 18.0),),
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 8,right: 8),
                          child: Text(conteudo[index], style: TextStyle(fontSize: _fontSize),),
                        )
                      ],
                    );
                  });
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
        floatingActionButtonLocation: 
          FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(8),
                child: FloatingActionButton(
                  heroTag: null,
                  child: Icon(Icons.zoom_out),
                  onPressed: ()=> _onZoomTapped(-2.0),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: FloatingActionButton(
                  heroTag: null,
                  child: Icon(Icons.zoom_in),
                  onPressed: ()=> _onZoomTapped(2.0),
                ),
              ),
            ],
          )
        );
  }

    void _onZoomTapped(double size){
    setState(() {
      _fontSize = _fontSize+size;
    });
  }

  @override
  bool get wantKeepAlive => true;
  
}