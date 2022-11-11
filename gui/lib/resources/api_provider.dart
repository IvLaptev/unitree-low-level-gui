import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:gui/models/motion.dart';

class ApiProvider {
  static String baseUrl = '';

  static Future sendMotions(List<Motion> motions) async {
    try {
      await http.post(
        Uri.parse('$baseUrl/server/v1/motions'),
        body: motionsToJson(motions),
        headers: {'Content-Type': ContentType.json.mimeType},
      );
    } catch (e) {
      throw 'Can\'t send data to $baseUrl/server/v1/motions';
    }
  }
}
