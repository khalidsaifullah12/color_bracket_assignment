import 'dart:convert';
import 'package:http/http.dart'as http;
class DetailApi{
  Future<List<dynamic>> getEmployeDetail(String id)async{
    var data;
    final response = await http.get(Uri.parse("https://retoolapi.dev/H2F0Ui/getemployedetail?id=${id}"));
    if (response.statusCode==200) {

      data = jsonDecode(response.body.toString());

      return data;
    } else {
      throw Exception("ERROR");
    }
  }
}