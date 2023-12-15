import 'package:api_to_database/model/postModel.dart';
import 'package:flutter/material.dart';

@immutable
abstract class PostState {}

class PostInitialState extends PostState {}

class PostLoadingState extends PostState {}

class PostLoadedState extends PostState {
  final List<Post> data;

  PostLoadedState(this.data);
}

class PostErrorState extends PostState {
  final String message;

  PostErrorState(this.message);
}
