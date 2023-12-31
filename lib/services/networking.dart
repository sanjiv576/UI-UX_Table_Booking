import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/product.dart';

class OnlineStore {
  Future getData() async {
    try {
      String url = 'https://fakestoreapi.com/products';

      http.Response res = await http.get(Uri.parse(url));

      // fetch data successfull then decode it and return
      if (res.statusCode == 200) {
        String data = res.body;

        // decode the json data
        var decodedData = jsonDecode(data);

        // convert json into a list of product entity
        List<Product> productList = (decodedData as List<dynamic>)
            .map<Product>((json) => Product.fromJson(json))
            .toList();

        return productList;
      } else {
        print('Error, status code: ${res.statusCode} ');
      }
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }
}
