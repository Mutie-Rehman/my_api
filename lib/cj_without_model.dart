// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

/*
So in this example we learn that how can we get the data from the Api without using the model.
The method is almost same as previous one but we have changed somethings that we can see in code.
*/
class CjWithoutModel extends StatefulWidget {
  const CjWithoutModel({super.key});

  @override
  State<CjWithoutModel> createState() => _CjWithoutModelState();
}

class _CjWithoutModelState extends State<CjWithoutModel> {
  var data;
  Future<void> getUserApi() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Complex Json Without Model"),
      ),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder(
                  future: getUserApi(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return ListView.builder(
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            return Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    ReusableWidget(
                                        title: "name",
                                        value: data[index]['name'].toString()),
                                    ReusableWidget(
                                        title: "username",
                                        value:
                                            data[index]['username'].toString()),
                                    ReusableWidget(
                                        title: "address",
                                        value: data[index]['address']['street']
                                            .toString()),
                                  ],
                                ),
                              ),
                            );
                          });
                    }
                  }))
        ],
      ),
    );
  }
}

class ReusableWidget extends StatelessWidget {
  String title, value;
  ReusableWidget({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(value),
        ],
      ),
    );
  }
}
