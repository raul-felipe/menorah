import 'package:flutter/material.dart';

class Contribua extends StatefulWidget{
  @override
  _ContribuaState createState()=>_ContribuaState(); 

}

class _ContribuaState extends State<Contribua>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contribuição"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Card(
              elevation: 6,
              child: Container(
                padding: EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Itaú", style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),),
                    Divider(height: 8.0,),
                    Text("CPF: 02.369.820/0001-80\nAgência: 6906\nConta: 08934-4"),
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
                    Text("Bradesco", style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),),
                    Divider(height: 8.0,),
                    Text("CPF: 02.369.820/0001-80\nAgência: 2876\nConta: 2137-7"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
