// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:api_to_database/model/postModel.dart';

class ListOfPost extends StatelessWidget {
  ListOfPost({
    Key? key,
    required this.post,
    required this.count,
  }) : super(key: key);
  final List<Post> post;
  final count;

  @override
  Widget build(BuildContext context) {
    print(post);
    return Container(
      height: 500,
      child: ListView.builder(
        itemCount: post.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
                subtitle: Text('data'),
                title: Text(
                  post[index].title.toString(),
                  style: TextStyle(color: Colors.black),
                )),
          );
        },
      ),
    );
  }
}
