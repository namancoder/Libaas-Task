import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:libaas/functions.dart';

class UnsplashPage extends StatefulWidget {
  const UnsplashPage({Key? key}) : super(key: key);

  @override
  _UnsplashPageState createState() => _UnsplashPageState();
}

class _UnsplashPageState extends State<UnsplashPage> {
  List myList = [];
  int i = 1;
  ScrollController _scrollController = ScrollController();
  bool flag = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future<List> curr = APISERVICE().fetchData(i.toString());
    curr.then((value) {
      setState(() {
        myList = value;
        flag = false;
      });
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        ++i;
        Future<List> curr = APISERVICE().fetchData(i.toString());
        curr.then((value) {
          setState(() {
            myList.addAll(value);
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Unsplash'),
      ),
      body: flag
          ? Center(child: CupertinoActivityIndicator())
          : ListView.builder(
              controller: _scrollController,
              itemCount: myList.length,
              itemBuilder: (context, index) {
                if (index == myList.length) {
                  return Center(
                      child: CircularProgressIndicator(
                    color: Colors.black,
                  ));
                }
                return Container(
                  child: Image.network(myList[index],
                      height: 200.0, width: 200.0, fit: BoxFit.cover),
                );
              },
            ),
    );
  }
}
