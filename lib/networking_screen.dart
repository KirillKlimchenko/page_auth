import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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


class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<Posts> futurePosts;

  @override
  void initState() {
    super.initState();
    futurePosts = fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body: Center(
          child:Column(
            children: [
              Row(
                children:const [
                  Text('Заголовок публикации:'

                  ),],
              ),
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
                      },
                    ),
                  ],
              ),
              Row(
                children:const [
                  Text('Тело публикации:'

                  ),],
              ),
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