import 'package:flutter/material.dart';
import 'package:number_pagination/number_pagination.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(body: MyHomePage()),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Flexible(
          child: Container(
            alignment: Alignment.center,
            height: 100,
            color: Colors.yellow[200],
            child: Text('PAGE INFO'),
          ),
        ),
        NumberPagination(
          listner: (int selectedPage) {
            //do somthing for selected page
          },
          totalPage: 100,
          currentPage: 3, // picked number when render page
        ),
      ],
    );
  }
}
