import 'package:flutter/material.dart';

class ListViewScreen extends StatelessWidget {
  const ListViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: _MyStatefulWidgetState(),
      ),
    );
  }
}

class MyListItem extends StatelessWidget {
  const MyListItem({Key? key, required this.number}) : super(key: key);
  final int number;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.lightBlueAccent,
          border: Border.all()
      ),
      child: Text('Элемент # $number', style: Theme.of(context).textTheme.headline6),
    );
  }
}
class SimpleList extends StatelessWidget {
  const SimpleList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      children: [
        MyListItem(number: 1),
        MyListItem(number: 1),
        MyListItem(number: 1),
        MyListItem(number: 1),
        MyListItem(number: 1),
        MyListItem(number: 1),
        MyListItem(number: 1),
        MyListItem(number: 5),
        MyListItem(number: 6),
        MyListItem(number: 7),
        MyListItem(number: 8),
        MyListItem(number: 9),
        MyListItem(number: 10),
        MyListItem(number: 11),
        MyListItem(number: 12),
      ],
    );
  }
}

class SimpleListBuilder extends StatelessWidget {
   SimpleListBuilder({Key? key}) : super(key: key);

  var list = new List<int>.generate(50, (i) => i+1);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: 20,
        itemBuilder: (BuildContext context,int index){
        return MyListItem(number: index);
    }
    );
  }
}

class _MyStatefulWidgetState extends StatefulWidget {
  const _MyStatefulWidgetState({Key? key}) : super(key: key);

  @override
  _MyStatefulWidgetStateState createState() => _MyStatefulWidgetStateState();
}

class _MyStatefulWidgetStateState extends State<_MyStatefulWidgetState> {
  int _selectedIndex=0;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 20,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(

         tileColor: Colors.lightBlueAccent,
          title: Text('Item $index', style: Theme.of(context).textTheme.headline6,),
          selected: index == _selectedIndex,
          onTap: () {
            setState(() {
              _selectedIndex = index;
            });
          },
        );
      },
    );
  }
}



