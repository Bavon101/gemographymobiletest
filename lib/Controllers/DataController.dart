import 'dart:developer';

import 'package:http/http.dart' as http;

class DataController {
  Future<String> gerRepos({required String gitUrl}) async {
    var url = Uri.parse(gitUrl);
    try {
      var response = await http.get(
        url,
      );
      log(response.body);
      if (response.statusCode == 200) {
        return response.body;
      }

      return 'error';
    } catch (e) {
      return 'error';
    }
  }
}
