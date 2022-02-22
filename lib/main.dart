import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
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
          body: Container(
            width: double.infinity,
            child: Column(
            children: [
              SizedBox(height: 60),
              SizedBox(width: 110,height: 84,child: Placeholder()),
              SizedBox(height: 20),
              Text('Введите логин в виде 10 цифр номера телефона',
              style:TextStyle(fontSize:16,color:Color.fromRGBO(0, 0, 0, 0.6))),
              SizedBox(height: 20),
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
              SizedBox(height: 20),
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

