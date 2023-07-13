import 'dart:convert';
// import "package:sky_engine/_http/http.dart" as http;
// import 'package:sky_engine/_http/http.dart' as http;
// import 'package:sky_engine/_http/http.dart' as http;
import 'package:http/http.dart' as http;
import 'model.dart';

class Repository {
  final _baseUrl = 'https://api.npoint.io/99c279bb173a6e28359c/data';

  Future<List<Blog>> getData() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));

      if (response.statusCode == 200) {
        List<dynamic> jsonData = jsonDecode(response.body);
        List<Blog> blogList = jsonData.map((e) => Blog.fromJson(e)).toList();
        return blogList;
      }
    } catch (e) {
      print(e.toString());
    }
    return []; // Tambahkan kembalian default jika terjadi kesalahan
  }
}
