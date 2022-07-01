import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:open_file/open_file.dart';



class Inicio extends StatefulWidget{
  @override
  _InicioState createState()=>_InicioState(); 

}

class _InicioState extends State<Inicio> with AutomaticKeepAliveClientMixin<Inicio>, TickerProviderStateMixin {

  TabController _controller;
  var dir;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  getExternalStorageDirectory().then((Directory d){
    dir = d.path+"/Batista Menorah";
  });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: true,
            title: TabBar(
              labelColor: Colors.grey,
              tabs: <Widget>[
                Tab(
                  text: "São Paulo - Sede",
                ),
                Tab(
                  text: "Jequitinhonha",
                ),
                Tab(
                  text: "Olho d'Água do Casado",
                ),
              ],
            ),
          ),
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              _menorah(),
              _jequitinhonha(),
              _olhodagua(),
            ],            
          ),
        ),
        length: 3,
      ), 
    );
  }

  Widget _menorah(){
    return 
    SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // Divider(height: 16.0,),
          // StreamBuilder(
          //   stream: Firestore.instance.collection('avisos').snapshots(),
          //   builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          //     if (snapshot.hasError)
          //       return new Text('Error: ${snapshot.error}');
          //     switch (snapshot.connectionState) {
          //       case ConnectionState.waiting: return new Text('Loading...');
          //       default:{
          //         _controller = TabController(
          //           length: snapshot.data.documents.length,
          //           vsync: this,
          //         );
          //         List<Widget> tabs = [];
          //         for(int i = 0;i<snapshot.data.documents.length; i++){
          //           String btn = "Clique para baixar";
          //           if(File("$dir/${snapshot.data.documents[i]["arquivo"]}").existsSync())
          //             btn = "Clique para abrir";
          //           tabs.add(
          //             Card(
          //               elevation: 6,
          //               child: Container(
          //                 padding: EdgeInsets.all(12.0),
          //                 child: Column(
          //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                   crossAxisAlignment: CrossAxisAlignment.start,
          //                   children: <Widget>[
          //                     Text(snapshot.data.documents[i].documentID, style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),),
          //                     Divider(height: 8.0,),
          //                     Text(snapshot.data.documents[i]["descricao"]),  
          //                     Center(
          //                       child: Padding(
          //                         padding: EdgeInsets.all(16),
          //                         child: RaisedButton(
          //                           onPressed: (){
          //                             _onDowloadButtonPressed(snapshot.data.documents[i]["url"], snapshot.data.documents[i]["arquivo"]);
          //                           },
          //                           child: Text(btn),
          //                         ),
          //                       ),
          //                     ),
          //                   ],
          //                 ),
          //               ),
          //             ));
          //         }
          //         return
          //         Column(
          //           children: <Widget>[
          //             TabPageSelector(controller: _controller,),
          //             Container(
          //               height: 250,
          //               child: TabBarView(
          //                 controller: _controller,
          //                 children: tabs,
          //               ),
          //             ),
          //           ],
          //         );
          //       }
          //     }
          //   }
          // ),
          Divider(height: 16.0,),
          Text("São Paulo - Sede", style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),),
          Divider(height: 16.0,),          
          Card(
            elevation: 6,
            child: Container(
              padding: EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Endereço", style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),),
                  Divider(height: 8.0,),
                  Text("Avenida Elísio Cordeiro de Siqueira, 910 - Jardim Santo Elias"),
                ],
              ),
            ),
          ),
          Divider(height: 16.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Card(
                  elevation: 6,
                  child: Container(
                    padding: EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Culto aos Domingos", style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),),
                        Divider(height: 8.0,),
                        Text("Manhã: 9:00 às 11:00\nNoite: 18:00 às 20:00"),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Card(
                  elevation: 6,
                  child: Container(
                    padding: EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Culto às Quintas", style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),),
                        Divider(height: 8.0,),
                        Text("Às 20:00\n"),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Divider(height: 16.0,),
          Card(
            elevation: 6,
            child: Container(
              padding: EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("GC Juventude Audaz", style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),),
                  Divider(height: 8.0,),
                  Text("Ás 20:00 no último sábado do mês.\nAmbiente, louvor e palavra voltada para o público jovem"),
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
                  Text("Células", style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),),
                  Divider(height: 8.0,),
                  Text("São reuniões que acontecem nas casas às quartas ou sábados."),
                ],
              ),
            ),
          ),
          Divider(height: 16.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Card(
                  elevation: 6,
                  child: Container(
                    padding: EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Vígilia", style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),),
                        Divider(height: 8.0,),
                        Text("Na última sexta de cada mês às 21:00\n"),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Card(
                  elevation: 6,
                  child: Container(
                    padding: EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Ceia", style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),),
                        Divider(height: 8.0,),
                        Text("Primeiro Domingo de cada mês no horário dos cultos"),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _jequitinhonha(){
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Divider(height: 16.0,),
          Text("Jequitinhonha", style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),),
          Divider(height: 16.0,),
          Card(
            elevation: 6,
            child: Container(
              padding: EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Endereço", style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),),
                  Divider(height: 8.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        child: Text("Avenida São Cristovão, 210 - Montes Claros, Jequitinhonha"),
                      ),
                      IconButton(
                        icon:Icon(Icons.content_copy),
                        onPressed: (){
                          Clipboard.setData(new ClipboardData(text: "Avenida São Cristovão, 210 - Jequitinhonha"));
                          Scaffold.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Endereço copiado"),
                              duration: Duration(seconds: 1),
                            )
                          );
                        },
                      ),
                    ],
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
                  Text("Cultos", style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),),
                  Divider(height: 8.0,),
                  Text("Domingos, Quintas e Terças\n19:30h"),
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
                  Text("Whatsapp", style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),),
                  Divider(height: 8.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("(33) 99820-5214"),
                      IconButton(
                        icon:Icon(Icons.content_copy),
                        onPressed: (){
                          Clipboard.setData(new ClipboardData(text: "33998205214"));
                          Scaffold.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Número copiado"),
                              duration: Duration(seconds: 1),
                            )
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );  
  }

  Widget _olhodagua(){
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Divider(height: 16.0,),
          Text("Olho d'Água do Casado", style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),),
          Divider(height: 16.0,),
          Card(
            elevation: 6,
            child: Container(
              padding: EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Endereço", style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),),
                  Divider(height: 8.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        child: Text("Rua João Francisco Soares, 34 - Centro - Olho d'Água do Casado AL"),
                      ),
                      IconButton(
                        icon:Icon(Icons.content_copy),
                        onPressed: (){
                          Clipboard.setData(new ClipboardData(text: "Rua João Francisco Soares, 34 - Centro - Olho d'Água do Casado AL"));
                          Scaffold.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Endereço copiado"),
                              duration: Duration(seconds: 1),
                            )
                          );
                        },
                      ),
                    ],
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
                  Text("Cultos", style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),),
                  Divider(height: 8.0,),
                  Text("Sábados e Domingos: 19:00\nTerças e Quintas às 19:30h"),
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
                  Text("Whatsapp", style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),),
                  Divider(height: 8.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("(82) 9 8834-5671"),
                      IconButton(
                        icon:Icon(Icons.content_copy),
                        onPressed: (){
                          Clipboard.setData(new ClipboardData(text: "82988345671"));
                          Scaffold.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Número copiado"),
                              duration: Duration(seconds: 1),
                            )
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );  
  }

  // void _onDowloadButtonPressed(String url, String fileName) async {

  //   PermissionStatus permission = await PermissionHandler().checkPermissionStatus(PermissionGroup.storage);
  //   if(permission.value==0){
  //     await PermissionHandler().requestPermissions([PermissionGroup.storage]);

  //     permission = await PermissionHandler().checkPermissionStatus(PermissionGroup.storage);

  //     if(permission.value==0) return;

  //   }

  //   var dir = (await getExternalStorageDirectory()).path+"/Batista Menorah";
  //   if(!Directory(dir).existsSync())
  //     new Directory(dir).createSync();
  //   dir = dir+"/"+fileName;
  //   if(File(dir).existsSync()) 
  //     OpenFile.open(dir);
  //   else
  //     _startDownload(url,dir);


  // }

  // void _startDownload(String url, String path) async{

  //   Scaffold.of(context).showSnackBar(new SnackBar(
  //     content: new Text("Baixando..."),
  //   ));

  //   Dio dio = new Dio();
  //   CancelToken token = new CancelToken();
  //   await dio.download(url, path, onReceiveProgress: (int recebidos, int total){
      
  //   },cancelToken: token);
  //   OpenFile.open(path);
      
  // }

  @override
  bool get wantKeepAlive => true;
}