import 'package:flutter/material.dart';
import 'package:number_pagination/number_pagination.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NumberPagenation Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Scaffold(body: MyHomePage()),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

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
          visiblePagesCount: 15,
          totalPages: 100,
          currentPage: selectedPageNumber,
          selectedButtonColor: Colors.amber,
          selectedTextColor: Colors.black,
          unSelectedButtonColor: Colors.grey,
          unSelectedTextColor: Colors.blueGrey,
        ),
      ],
    );
  }
}
