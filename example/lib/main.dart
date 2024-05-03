import 'package:flutter/material.dart';
import 'package:number_pagination/number_pagination.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NumberPagenation Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(body: MyHomePage()),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedPageNumber = 3;

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
            child: Text('PAGE INFO $selectedPageNumber'), //do manage state
          ),
        ),
        NumberPagination(
          onPageChanged: (int pageNumber) {
            //To optimize further, use a package that supports partial updates instead of setState (e.g. riverpod)
            setState(() {
              selectedPageNumber = pageNumber;
            });
          },
          threshold: 15,
          pageTotal: 100,
          pageInit: selectedPageNumber, // picked number when init page
          colorPrimary: Colors.red,
          colorSub: Colors.yellow,
        ),
      ],
    );
  }
}
