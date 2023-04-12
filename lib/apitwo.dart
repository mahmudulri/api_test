import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiTwo extends StatefulWidget {
  ApiTwo({super.key});

  @override
  State<ApiTwo> createState() => _ApiTwoState();
}

List<dynamic> data = [];

class _ApiTwoState extends State<ApiTwo> {
  String url = "https://fakestoreapi.com/products/category/jewelery";

  @override
  void initState() {
    fetchCatData();

    super.initState();
  }

  Future<void> fetchCatData() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      setState(() {
        data = json.decode(response.body);
        print(data);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: data.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(data[index]["title"]),
                );
              },
            ),
    ));
  }
}
