import 'dart:convert';
import 'package:flutter/services.dart';

Future<Map<String, dynamic>> loadJsonData() async {
  final String response = await rootBundle.loadString('assets/splash_data.json');
  final data = await json.decode(response);
  return data;
}
