import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:share/share.dart';

class AudioRow extends StatefulWidget{

  final List audios;
  final int index;

  AudioRow(this.audios, this.index);

  @override
  _AudioRowState createState()=>_AudioRowState(audios,index); 

}

class _AudioRowState extends State<AudioRow> with AutomaticKeepAliveClientMixin{

  static var httpClient = new HttpClient();
  CancelToken token = new CancelToken();
  Dio dio = new Dio();
  var _progress=0.000;
  List audios;
  int index;
  bool carregando = false;
  bool isPlayingMode = false;
  IconData _audioIcon = Icons.file_download; 
  double _audioProgress = 0;
  AudioPlayer audioPlayer = new AudioPlayer();
  int total=0;
  String duracao;
  String atual;

  _AudioRowState(List audios,int index){
     this.audios=audios;
     this.index=index;
  }

  @override
  Widget build(BuildContext context) {
    audios = widget.audios;
    index = widget.index;
    return Dismissible(
      key: Key(audios[index]["titulo"]),
      confirmDismiss: (DismissDirection direction) async {
        if(direction==DismissDirection.endToStart){
          if(_audioIcon!=Icons.file_download){
            await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Corfirmação"),
                content: const Text("Deseja mesmo deletar o audio?"),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                      _deleteAudio();
                    },
                    child: const Text("Deletar"),
                  ),
                  FlatButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text("Cancelar"),
                  )
                ],
              );
            });
            }
          }
        else{
          _onShareButtonPressed(audios[index]["titulo"], audios[index]["url"]);
        }
      },
      background: Container(
        color: Colors.blue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              color: Colors.blue,
              child: Icon(Icons.share),
              alignment: Alignment.topLeft,
              padding: EdgeInsets.all(16.0),
            ),
            Container(
              color: Colors.blue,
              child: Icon(Icons.delete),
              alignment: Alignment.topRight,
              padding: EdgeInsets.all(16.0),
            ),
          ],
        ),
      ),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                direction: Axis.horizontal,
                runAlignment: WrapAlignment.start,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width*0.7,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(audios[index]["titulo"], style: TextStyle(fontSize: 18.0)),
                        Text(audios[index]["data"], style: TextStyle(fontSize: 14.0)),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      _audioIcon,
                    ),
                    //onPressed: ()=>_onShareButtonPressed(audios[index]["titulo"], audios[index]["url"]),
                    onPressed: ()=>_onAudioButtonPressed(audios[index]["url"], audios[index]["titulo"]+".mp3"),
                  ),
                ],
              ),
              carregando ?
              Column(
                children: <Widget>[
                  LinearProgressIndicator(
                    value: _progress,
                  ),
                  Text("Baixando: ${(_progress*100).round()}%"),
                ],
              ): isPlayingMode ?
              Column(
                children: <Widget>[
                  Slider(
                    onChanged: (double value) {
                      setState(() {
                        if(audioPlayer.state==AudioPlayerState.PLAYING){
                          audioPlayer.pause();
                          _audioIcon=Icons.play_arrow;
                        }
                        _audioProgress=value;
                        Duration seek = new Duration(seconds: (total*value).round());
                        audioPlayer.seek(seek);
                        atual=seek.toString().replaceRange(seek.toString().length-7, seek.toString().length,"");
                      });
                    },
                    value: _audioProgress,
                  ),
                  Text("$atual / $duracao"),
                ],
              ):Container(),
            ],
          ), 
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _setInitialAudioIcon();
  }

  void _setInitialAudioIcon() async {
    var dir = await getApplicationDocumentsDirectory();
    var path = "${dir.path}/${audios[index]["titulo"]}.mp3";
    File file = new File(path);
    if(file.existsSync()){
      setState(() {
        _audioIcon = Icons.play_arrow;
      });
    }
    else{
      setState(() {
          _audioIcon = Icons.file_download;
      });
    }

  }

  void _onShareButtonPressed(String titulo, String url) async {
    Share.share("Acesse o audio da pregação "+Text(titulo, style: TextStyle(fontWeight: FontWeight.bold),).data+ " aqui:\n"+url);
  }

  void _onAudioButtonPressed(String url, String filename) async {

    var dir = await getApplicationDocumentsDirectory();
    var path = "${dir.path}/$filename";

    if(carregando){ // o download esta sendo executado
      _cancelDownload();
    } else {
      File file = new File(path);
      if(file.existsSync()){ //o arquivo existe
        _startAudio(file.path);
      }else{
        _startDownload(url, path);
      }
    }

  }

  void _startDownload(String url, String path) async{
    setState(() {
      _audioIcon = Icons.stop;
      carregando=true;
      _progress=0.0;
      });
      
      await dio.download(url, path, onReceiveProgress: (int recebidos, int total){
        setState(() {
          _progress = recebidos/(audios[index]["tamanho"]*1000000);
        });
      },cancelToken: token);
      setState(() {
        _audioIcon = Icons.play_arrow;
        carregando=false;
    });
  }

  void _cancelDownload(){
    setState(() {
      token.cancel();
      carregando=false;
      _audioIcon = Icons.file_download;
      token = new CancelToken();
    });
  }
  
  void _deleteAudio()async{
    var dir = await getApplicationDocumentsDirectory();
    var path = "${dir.path}/${audios[index]["titulo"]}.mp3";
    File file = new File(path);
    file.delete();
    setState(() {
      carregando = false;
      isPlayingMode = false;
      _audioIcon = Icons.file_download;
    });
  }

  void _startAudio(String filePath) async{
    
    if(!isPlayingMode){ //play no audio
      setState(() {
        isPlayingMode=true;
        _audioIcon=Icons.pause;
      });
      await audioPlayer.play(filePath, isLocal: true);
      audioPlayer.onDurationChanged.listen((Duration p){
        total=p.inSeconds;
        duracao=p.toString().replaceRange(p.toString().length-7, p.toString().length,"");
      });
      audioPlayer.onAudioPositionChanged.listen((Duration d){
        setState((){
          _audioProgress = d.inSeconds/(total+10);
          atual=d.toString().replaceRange(d.toString().length-7, d.toString().length,"");
        });
      });
      audioPlayer.onPlayerCompletion.listen((event){
        setState(() {
          _audioProgress=0;
          _audioIcon=Icons.play_arrow;
          isPlayingMode=false;
        });
      });
    }else{ //pause audio

      if(audioPlayer.state==AudioPlayerState.PLAYING){
        audioPlayer.pause();
        setState(() {
          _audioIcon=Icons.play_arrow; 
        });
      }
      else if(audioPlayer.state==AudioPlayerState.PAUSED){
        audioPlayer.resume();
        setState(() {
          _audioIcon=Icons.pause; 
        });
      }      

    }

  }

  @override
  bool get wantKeepAlive => true;


}
