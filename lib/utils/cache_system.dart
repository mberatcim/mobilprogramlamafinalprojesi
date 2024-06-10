import 'dart:io';
import 'package:path_provider/path_provider.dart';

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/data.json');
}

Future<File> writeData(String data) async {
  final file = await _localFile;
  return file.writeAsString(data);
}

Future<String> readData() async {
  try {
    final file = await _localFile;
    String contents = await file.readAsString();
    return contents;
  } catch (e) {
    return "Error: $e";
  }
}
