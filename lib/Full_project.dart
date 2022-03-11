import 'package:flutter/material.dart';
import 'package:page_auth/global_theme.dart';
import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

class FullProject extends StatefulWidget {
  const FullProject({Key? key}) : super(key: key);

  @override
  _FullProjectState createState() => _FullProjectState();
}

class _FullProjectState extends State<FullProject> {
  @override
  Widget build(BuildContext context) {
      return MaterialApp(
        theme: globalTheme(),
        //home: const MainScreen(),
        initialRoute: '/',
        routes: {
          '/': (context) => const MainScreen(),
          '/contacts': (context) => SwitchesDemoScreen(),
          '/auth': (context) => AuthScreen(),
        },
      );
  }
}
Widget navDrawer(context) => Drawer(
  child: ListView(
    padding: EdgeInsets.zero,
    children: [
      DrawerHeader(
        decoration: const BoxDecoration(
          color:Colors.blue,
        ),
        child: Container(
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 100,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(50.0))
                ),
                child: Image.network('https://upload.wikimedia.org/wikipedia/commons/thumb/4/44/Google-flutter-logo.svg/330px-Google-flutter-logo.png'),
              ),
              const Text('Навигация во Flutter'),
            ],
          ),
        ),
      ),
      ListTile(
        leading: const Icon(Icons.one_k),
        title: const Text('Главная'),
        onTap: (){
          Navigator.pushNamed(context, '/');
        },
      ),
      const Divider(
        thickness: 1,
      ),
      ListTile(
        leading: const Icon(Icons.two_k),
        title: const Text('Виджеты'),
        onTap: (){
          Navigator.pushNamed(context, '/contacts');
        },
      ),
      const Divider(
        color: Colors.black26,
        thickness: 2,
      ),
      const Padding(
        padding:  EdgeInsets.only(left: 15),
        child:  Text('Профиль'),
      ),
      ListTile(
        leading: const Icon(Icons.settings),
        title: const Text('Авторизация'),
        onTap: (){
          Navigator.pushNamed(context, '/auth');
        },
      ),
    ],
  ),
);


class MainScreen extends StatelessWidget{
  const MainScreen({Key? key}) : super (key: key);
  @override
  Widget build(BuildContext context){
    final ButtonStyle buttonStyle =
    TextButton.styleFrom(primary: Theme.of(context).colorScheme.onPrimary);
      return Scaffold(
        appBar: AppBar(
          title: const Text('Главная'),
          actions: <Widget>[
            IconButton(
                tooltip: 'Баланс',
                onPressed: (){},
                icon: Icon(Icons.account_balance)),
            IconButton(
                onPressed: (){},
                icon: Icon(Icons.settings)),
            TextButton(
                style: buttonStyle,
                onPressed: (){},
                child: Text('Профиль')),
          ],
        ),
        drawer: navDrawer(context),
        body: _MyStatefulWidgetState(),
      );
  }
}
Future<Posts> fetchPosts() async {
  final response = await http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Posts.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
class Posts {
  final int userId;
  final int id;
  final String title;
  final String body;

  const Posts({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });


  factory Posts.fromJson(Map<String, dynamic> json) {
    return Posts(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}
class _MyStatefulWidgetState extends StatefulWidget {
  const _MyStatefulWidgetState({Key? key}) : super(key: key);

  @override
  _MyStatefulWidgetStateState createState() => _MyStatefulWidgetStateState();
}

class _MyStatefulWidgetStateState extends State<_MyStatefulWidgetState> {
  late Future<Posts> futurePosts;

  @override
  void initState() {
    super.initState();
    futurePosts = fetchPosts();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
            child:Column(
              children: [
                Row(
                  children:const [Text('Заголовок публикации:'),],),
                Row(
                  children: [
                    FutureBuilder<Posts>(
                      future: futurePosts,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return
                            Expanded(child: Text(snapshot.data!.title,textAlign: TextAlign.center,style: Theme.of(context).textTheme.headline6,),);
                        } else if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                        }
                        // By default, show a loading spinner.
                        return const CircularProgressIndicator();
                      },),],),
                Row(children:const [Text('Тело публикации:'),],),
                Row(
                  children: [
                    FutureBuilder<Posts>(
                      future: futurePosts,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Expanded(
                              child:Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.black26,
                                      )
                                  ),
                                  child: Text(snapshot.data!.body,style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,))));
                        } else if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                        }
                        // By default, show a loading spinner.
                        return const CircularProgressIndicator();
                      },
                    ),
                  ],
                )
              ],
            )

        ),
      ),
    );
  }
}

class SwitchesDemoScreen extends StatefulWidget {
  const SwitchesDemoScreen({Key? key}) : super(key: key);

  @override
  _SwitchesDemoScreenState createState() => _SwitchesDemoScreenState();
}
enum SkillLevel {junior,middle,senior}
class _SwitchesDemoScreenState extends State<SwitchesDemoScreen> {
  bool _checked = false;
  //bool _confirmAgreement = true;
  SkillLevel? _skillLevel = SkillLevel.junior;
  void _onCheckedChange(bool? val){
    setState(() {
      _checked = !_checked;
    });
  }
  void _onSkillLevelChange(SkillLevel? value){
    setState(() {
      _skillLevel = value;
    });
  }
  bool _isDarkTheme = false;

  @override
  Widget build(BuildContext context) {
    final ButtonStyle buttonStyle =
    TextButton.styleFrom(primary: Theme.of(context).colorScheme.onPrimary);
    return MaterialApp(
      theme: globalTheme(),
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Виджеты'),
            actions: <Widget>[
              IconButton(
                  tooltip: 'Баланс',
                  onPressed: (){},
                  icon: Icon(Icons.account_balance)),
              IconButton(
                  onPressed: (){},
                  icon: Icon(Icons.settings)),
              TextButton(
                  style: buttonStyle,
                  onPressed: (){},
                  child: Text('Профиль')),
            ],
          ),
          drawer: navDrawer(context),
          body: Center(
            child: Column(
              children: [
                Row(
                  children: [
                    Checkbox(
                        value: _checked,
                        onChanged: _onCheckedChange),
                    const Text('Выбор'),
                  ],
                ),
                CheckboxListTile(
                    tileColor: Theme.of(context).colorScheme.secondary,
                    title: const Text('Принять условия соглашения'),
                    value: _checked,
                    onChanged: _onCheckedChange),
                Row(
                  children: [
                    Switch(
                        value: _checked,
                        onChanged: _onCheckedChange),
                    const Text('Включить'),
                  ],
                ),
                SwitchListTile(
                    title: const Text('Включить'),
                    value: _checked,
                    onChanged: _onCheckedChange),
                 Text('Уровень навыков',style: Theme.of(context).textTheme.headline5),
                RadioListTile<SkillLevel>(
                    title: const Text('junior'),
                    value: SkillLevel.junior,
                    groupValue: _skillLevel,
                    onChanged: _onSkillLevelChange
                ),
                RadioListTile<SkillLevel>(
                  title: const Text('middle'),
                  value: SkillLevel.middle,
                  groupValue: _skillLevel,
                  onChanged: _onSkillLevelChange,
                ),
                RadioListTile<SkillLevel>(
                    title: const Text('senior'),
                    value: SkillLevel.senior,
                    groupValue: _skillLevel,
                    onChanged: _onSkillLevelChange
                ),
                SwitchListTile(
                    title:  Text('Тёмная тема'),
                    value: _isDarkTheme,
                    onChanged: (val){
                      setState(() {
                        _isDarkTheme  =!_isDarkTheme;
                      });
                    }),
              ],
            ),
          )
      ),
    );
  }
}

class AuthScreen  extends StatelessWidget{
const AuthScreen({Key? key}) : super (key: key);
@override
  Widget build(BuildContext context) {
  final ButtonStyle buttonStyle =
  TextButton.styleFrom(primary: Theme.of(context).colorScheme.onPrimary);
    const BorderStyle = OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(36)),
        borderSide: BorderSide(
            color: const Color(0xFFbbbbbb),width:2)
    );
    const LinkTextStyle = TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Color(0xFF0079D0)
    );
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Авторизация'),
          actions: <Widget>[
            IconButton(
                tooltip: 'Баланс',
                onPressed: (){},
                icon: Icon(Icons.account_balance)),
            IconButton(
                onPressed: (){},
                icon: Icon(Icons.settings)),
            TextButton(
                style: buttonStyle,
                onPressed: (){},
                child: Text('Профиль')),
          ],
        ),
        drawer: navDrawer(context),
        body: Container(
          width: double.infinity,
          child: Column(
            children: [
              const SizedBox(height: 60),
              const SizedBox(width: 110,height: 84,child: Placeholder()),
              const SizedBox(height: 20),
              const Text('Введите логин в виде 10 цифр номера телефона',
                  style:TextStyle(fontSize:16,color:Color.fromRGBO(0, 0, 0, 0.6))),
              const SizedBox(height: 20),
              const SizedBox( width: 224,
                child: TextField(
                  decoration: InputDecoration(
                      enabledBorder: BorderStyle,
                      focusedBorder: BorderStyle,
                      filled: true,
                      fillColor: Color(0xFFeceff1),
                      labelText: 'Телефон'
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const SizedBox(width: 224,
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                      enabledBorder: BorderStyle,
                      focusedBorder: BorderStyle,
                      filled: true,
                      fillColor: Color(0xFFeceff1),
                      labelText: 'Пароль'
                  ),
                ),
              ),
              const SizedBox(height: 28),
              SizedBox(
                width: 154,
                height: 42,
                child:
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Войти'),
                  style: ElevatedButton.styleFrom(
                      primary: Color(0xFF0079D0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(36.0),
                      )
                  ),
                ),
              ),
              const SizedBox(height: 62),
              InkWell(
                  child: const Text('Регистрация', style: LinkTextStyle,),
                  onTap: () {}),
              const SizedBox(height: 28),
              InkWell(
                  child: const Text('Забыли пароль?', style: LinkTextStyle,),
                  onTap: () {}),
            ],),
        ),
      ),
    );
  }
}
