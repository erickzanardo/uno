import 'dart:convert';
import 'dart:io';

import 'package:uno/models/models.dart';

class LevelRepositoryFailure implements Exception {
  const LevelRepositoryFailure({
    required this.message,
  });

  final String message;

  @override
  String toString() => message;
}

class LevelRepository {
  Future<UnoProject> fetchProject(String directoryPath) async {
    final directory = Directory(directoryPath);

    final files = directory.listSync();
    final levels = files.where((file) => !file.path.endsWith('.uno')).toList();
    final palettes = files.where((file) => file.path.endsWith('.uno')).toList();

    if (palettes.length != 1) {
      throw const LevelRepositoryFailure(
        message: 'There must be exactly one .uno file in the directory',
      );
    }

    final paletteRaw = await File(palettes.first.path).readAsString();
    final paletteJson = jsonDecode(paletteRaw) as Map<String, dynamic>;
    final palette = UnoPalette.fromJson(paletteJson);

    return UnoProject(
      projecPath: directoryPath,
      levels: levels.map((file) => file.path).toList(),
      palette: palette,
    );
  }

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
