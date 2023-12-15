// import 'package:api_to_database/model/postModel.dart';
// import 'package:api_to_database/repo/postRepo/getPost.dart';
// import 'package:api_to_database/utils/databaseHelper.dart';
// import 'package:get/get.dart';

// class PostController extends GetxController {
//   @override
//   void onInit() {
//     // TODO: implement onInit
//     super.onInit();
//     updateNoteList();
//   }

//   DatabaseHelper databaseHelper = DatabaseHelper();
//   var postList = <Post>[].obs; // Make it reactive
//   RxInt count = 0.obs; // Make it reactive

//   Future<void> updateNoteList() async {
//     try {
//       final database = await DatabaseHelper().initializeDatabase();
//       var updatedNoteList =
//           await DatabaseHelper().getNoteList(); //gets the data

//       postList.value = updatedNoteList;
//       count.value = updatedNoteList.length;
//       print(postList[1]);
//       print(count);
//     } catch (e) {
//       print('Error updating post list: $e');
//     }
//   }

//   Future<List<Post>> reload() async {
//     GetPostsApi getPostsApi = GetPostsApi();
//    var data= await getPostsApi.fetchPost();

//     for (var i = 0; i < data.length; i++) {
//       addPost(data[i]);
//     }
//     return data;
//     print('Api refresh');
//   }

//   Future<void> addPost(Post post) async {
//     print('postadded successfully');
//     databaseHelper.insertNote(post);
//     updateNoteList();
//   }
// }
