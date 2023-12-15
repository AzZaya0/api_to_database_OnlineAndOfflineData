import 'dart:convert';

import 'package:api_to_database/model/postModel.dart';
import 'package:api_to_database/repo/api/api.dart';

class GetPostsApi {
  Api _api = Api();

  Future<List<Post>> fetchPost() async {
    try {
      final response = await _api.sentrequest.get('/products');
      if (response.statusCode == 200) {
        var datas = postFromJson(jsonEncode(response.data));
        print(datas);
        return datas;
      } else {
        print('error');
        return [];
      }
    } catch (e) {
      print('$e');
      return [];
    }
  }
}
