import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'model.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Data> adata = [];

  Future getdata() async {
    var url = "https://jsonplaceholder.typicode.com/posts";
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        adata = dataFromJson(response.body);
      });

      print(adata);
    }
  }

  @override
  void initState() {
    getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("sf"),
      ),
      body: adata.isEmpty
          ? CircularProgressIndicator()
          : SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: adata.length,
                      itemBuilder: (_, index) {
                        return Center(child: Text(adata[index].toString()));
                      })
                ],
              ),
            ),
    );
  }
}
