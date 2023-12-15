import 'package:api_to_database/controller/postNotifier.dart';
import 'package:api_to_database/controller/postState.dart';
import 'package:api_to_database/controller/postcontroller.dart';
import 'package:api_to_database/view/listOfData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var controller = ref.watch(postProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: Text('data'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Consumer(builder: (context, ref, child) {
          var state = ref.watch(postProvider);
          if (state is PostInitialState) {
            return Center(
              child: Text('initial state'),
            );
          }
          if (state is PostLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is PostErrorState) {
            return Center(
              child: Text(state.message.toString()),
            );
          }
          if (state is PostLoadedState) {
            return Column(
              children: [
                ElevatedButton(
                    onPressed: () {
                      for (var i = 0; i < state.data.length; i++) {
                        controller.addPost(state.data[i]);
                      }
                      //state.data.map((data) => PostController().addPost(data));
                    },
                    child: Text('hello')),
                Center(
                  child: ListOfPost(
                    post: state.data,
                    count: state.data.length,
                  ),
                ),
              ],
            );
          }
          return Center(
            child:
                Text('nothing happened', style: TextStyle(color: Colors.black)),
          );
        }),
      ),
    );
  }
}
