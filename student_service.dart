import 'dart:convert';

import 'package:http/http.dart' as http;

import 'student_model.dart';

StudentModel studentModelFromJson(String str) =>
    StudentModel.fromJson(json.decode(str));

String studentModelToJson(StudentModel data) => json.encode(data.toJson());

class StudentService {
  static Future<StudentModel> read() async {
    final String url = "http://10.0.0.1:8000/students?page=1"; // Android emulator
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return studentModelFromJson(response.body);
    } else {
      throw Exception("Failed to load students");
    }
  }



  static Future<bool> insert(Datum item) async {
    final url = Uri.parse("http://127.0.0.1:8000/students?page=1");
    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(item.toJson()),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        throw Exception(
          "Error status code: ${response.statusCode}\nBody: ${response.body}",
        );
      }
    } catch (e) {
      throw Exception("Network error: ${e.toString()}");
    }
  }

  static Future<bool> update(Datum item) async {
    final String url = "http://127.0.0.1:8000/students/${item.id}";
    try {
      http.Response response = await http.put(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(item.toJson()),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        throw Exception(
          "Error status code: ${response.statusCode}\nBody: ${response.body}",
        );
      }
    } catch (e) {
      throw Exception("Network error: ${e.toString()}");
    }
  }
  

  static Future<bool> delete(int id) async {
    final String url = "http://127.0.0.1:8000/students/$id";
    try {
      http.Response response = await http.delete(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        throw Exception(
          "Error status code: ${response.statusCode}\nBody: ${response.body}",
        );
      }
    } catch (e) {
      throw Exception("Network error: ${e.toString()}");
    }
  }
}
