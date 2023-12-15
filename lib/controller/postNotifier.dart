import 'package:api_to_database/controller/postState.dart';
import 'package:api_to_database/model/postModel.dart';
import 'package:api_to_database/repo/postRepo/getPost.dart';
import 'package:api_to_database/utils/databaseHelper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final postProvider = StateNotifierProvider<PostNotifier, PostState>((ref) {
  return PostNotifier()..fetchData();
});

class PostNotifier extends StateNotifier<PostState> {
  PostNotifier() : super(PostInitialState());

  var postList = <Post>[]; // Make it reactive
  var count = 0; // Make it reactive
  DatabaseHelper databaseHelper = DatabaseHelper();
//-----------------------------------------------

  Future<void> addPost(Post post) async {
    print('postadded successfully');
    databaseHelper.insertNote(post);
    updateNoteList();
  }
//-----------------------------------------------

  Future<List<Post>> updateNoteList() async {
    try {
      final database = await DatabaseHelper().initializeDatabase();
      var updatedNoteList =
          await DatabaseHelper().getNoteList(); //gets the data

      return updatedNoteList;
    } catch (e) {
      print('Error updating post list: $e');
      return [];
    }
  }

//-----------------------------------------------
  Future<List<Post>> reload() async {
    GetPostsApi getPostsApi = GetPostsApi();
    var data = await getPostsApi.fetchPost();

    for (var i = 0; i < data.length; i++) {
      addPost(data[i]);
    }
    print('Api refresh');
    return data;
  }

/////////////////////////////////////////////////////////////////////////////////////////////////////////////
  void fetchData() async {
    state = PostLoadingState();
    GetPostsApi getPostsApi = GetPostsApi();
    try {
      final pref = await SharedPreferences.getInstance();
//------------ if the data is used first time-----------------------------//
      if (pref.getBool('isFirst') == null) {
        var newData =
            await getPostsApi.fetchPost(); //fetch post for the first time

        state =
            PostLoadedState(newData); // state got post data for the first time
        for (var i = 0; i < newData.length; i++) {
          addPost(newData[i]);
        }
        pref.setBool('isFirst', true);
        var date = DateTime.now();
        print(date.toString());
        pref.setString('currentdate', date.toString());
      }

//------------ if the date has come to refresh ---------------------------------------//
      //now lets check first
      var lastDateString = pref.getString('currentdate');
      var lastDate = DateTime.parse(lastDateString!);
      var currentDate = DateTime.now();
      var addedDate = lastDate.add(Duration(minutes: 10));
      pref.setString('latestDate', addedDate.toString());
      //if last date == current date than Hit api
      if (currentDate.isAfter(addedDate)) {
        var Postdata = await reload();
        print('refresheddd');
        print(currentDate.toString());
        pref.setString('currentdate', currentDate.toString());
        state = PostLoadedState(Postdata);
      }
      if (currentDate.isBefore(addedDate)) {
        var data = await updateNoteList();
        state = PostLoadedState(data);
      }
    } catch (e) {
      state = PostErrorState(e.toString());
    }
  }
}
