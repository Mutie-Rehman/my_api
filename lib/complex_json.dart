// ignore_for_file: must_be_immutable
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_api/Models/users_model.dart';
/*
So here we have used the complex json structure and we have done the same things as 
we have done in the previous examples. The method and everything is same for all.
*/

class ComplexJson extends StatefulWidget {
  const ComplexJson({super.key});

  @override
  State<ComplexJson> createState() => _ComplexJsonState();
}

class _ComplexJsonState extends State<ComplexJson> {
  List<UsersModel> usersList = [];
  Future<List<UsersModel>> getUsers() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      usersList.clear();
      for (var i in data) {
        usersList.add(UsersModel.fromJson(i));
      }
      return usersList;
    } else {
      return usersList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Complex Json"),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getUsers(),
                builder: (context, AsyncSnapshot<List<UsersModel>> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return ListView.builder(
                        itemCount: usersList.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  ReusableWidget(
                                      title: "Id",
                                      value:
                                          snapshot.data![index].id.toString()),
                                  ReusableWidget(
                                      title: "Name",
                                      value: snapshot.data![index].name
                                          .toString()),
                                  ReusableWidget(
                                      title: "Address",
                                      value: snapshot.data![index].address
                                          .toString()),
                                  ReusableWidget(
                                      title: "Phone",
                                      value: snapshot.data![index].phone
                                          .toString()),
                                ],
                              ),
                            ),
                          );
                        });
                  }
                }),
          ),
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        Text(value),
      ],
    );
  }
}
