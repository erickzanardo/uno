import 'dart:convert';
import 'dart:io';

import 'package:uno_data/uno_data.dart';

class LevelRepositoryFailure implements Exception {
  const LevelRepositoryFailure({
    required this.message,
  });

  final String message;

  @override
  String toString() => message;
}

class LevelRepository {
  Future<UnoLevel> loadData(String filename) async {
    final file = File(filename);
    final data = await file.readAsString();
    final json = jsonDecode(data) as Map<String, dynamic>;
    return UnoLevel.fromJson(json);
  }

  Future<void> saveLevel({
    required String fileName,
    required UnoLevel data,
  }) async {
    final file = File(fileName);
    await file.writeAsString(jsonEncode(data.toJson()));
  }

  Future<void> deleteLevel(String fileName) async {
    final file = File(fileName);
    await file.delete();
  }
}
