import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'api_keys.dart';

class APISERVICE {
  Future<List> fetchData(String i) async {
    // dart code to fetch data from unsplash
    List myList = [];
    http.Response response = await http.get(Uri.parse(BASE_URL +
        "photos/?client_id=" +
        ACCESS_KEY +
        "&page=" +
        i +
        "&per_page=10"));
    print(response.statusCode);
    List imgData = json.decode(response.body);

    imgData.forEach((element) {
      myList.add(element["urls"]["regular"]);
    });

    return myList;
  }
}
