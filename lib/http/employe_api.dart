import 'dart:convert';

import '../model/get_emp_model.dart';
import 'package:http/http.dart'as http;
class GetEmploye{


  Future<List<dynamic>> getEmployeData()async{
    var data;
    final response = await http.get(Uri.parse("https://retoolapi.dev/GFHqAV/getemployees"));
    if (response.statusCode==200) {
      data = jsonDecode(response.body.toString());

      return data;
    } else {
      throw Exception("ERROR");
    }
  }
}