import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:io';

class SaveFull extends StatelessWidget {
  const SaveFull({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reading',
      home: FlutterDemo(storage: CounterStorage()),
    );
  }
}
class CounterStorage{
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }
  Future<File> get _localFile async{
    final path = await _localPath;
    return File('$path/counter.txt');
  }
  Future<int> readCounter() async{
    try{
      final file = await _localFile;
      final contents = await file.readAsString();
      return int.parse(contents);
    }
    catch (e){
      return 0;
    }
  }
  Future<File> writeCounter(int counter) async{
    final file = await _localFile;
    return file.writeAsString('$counter');
  }
}


class FlutterDemo extends StatefulWidget {
  const FlutterDemo({Key? key, required this.storage}) : super(key: key);
  final CounterStorage storage;

  @override
  State<FlutterDemo> createState() => _FlutterDemoState();
}

class _FlutterDemoState extends State<FlutterDemo> {
  int _counter = 0;
  int _counter2 = 0;

  void initState2(){
    super.initState();
    _loadCounter2();
  }
  void _loadCounter2() async{
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter2 = (prefs.getInt('counter') ?? 0);
    });
  }
  void _incrementCounter2() async{
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter2 = (prefs.getInt('counter') ?? 0) + 1;
      prefs.setInt('counter', _counter2);
    });
  }

  void initState(){
    super.initState();
    widget.storage.readCounter().then((int value){
      setState(() {
        _counter = value;
      });
    });
  }
  Future<File> _incrementCounter(){
    setState(() {
      _counter++;
    });
    return widget.storage.writeCounter(_counter);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reading'),
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: _incrementCounter,
                  icon: Icon(Icons.add), label: Text('Сохранение в файл'),),
                Padding(padding: EdgeInsets.all(10.0)),
                Text(
                  'Button tapped file:$_counter ',
                  style: TextStyle(fontSize: 14)),
              ],
            ),
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: _incrementCounter2,
                  icon: Icon(Icons.add), label: Text('Сохранение в shared'),),
                Padding(padding: EdgeInsets.all(10.0)),
                Text(
                  'Button tapped share:$_counter2',
                    style: TextStyle(fontSize: 14)),
              ],
            )
          ],
        ),
        ),
        //ElevatedButton(
        //  onPressed: _incrementCounter,
        //  child: Text('Button tapped $_counter time${_counter == 1 ? '' : 's'}.',),
       // ),
      //Center(child:
        //Text('Button tapped $_counter time${_counter == 1 ? '' : 's'}.',),
      //),
      //floatingActionButton: FloatingActionButton(
       // onPressed: _incrementCounter,
        //tooltip: 'Increment',
       // child: const Icon(Icons.add),
     // ),

    );
  }
}