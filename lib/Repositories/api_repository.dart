import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiRepository {
  Future<Map<String, dynamic>> fetchHomeData() async {
    final response = await http.get(Uri.parse(
        'http://devapiv4.dealsdray.com/api/v2/user/home/withoutPrice'));
    if (response.statusCode == 200) {
      return json.decode(response.body)['data'];
    } else {
      throw Exception('Failed to load data');
    }
  }
}
