import 'dart:convert';
import 'dart:io';

import 'package:uno_data/uno_data.dart';

class ProjectRepositoryFailure implements Exception {
  const ProjectRepositoryFailure({
    required this.message,
  });

  final String message;

  @override
  String toString() => message;
}

class ProjectRepository {
  File _getProjectPalette(Directory directory) {
    final files = directory.listSync();
    final palettes = files.where((file) => file.path.endsWith('.uno')).toList();

    if (palettes.length != 1) {
      throw const ProjectRepositoryFailure(
        message: 'There must be exactly one .uno file in the directory',
      );
    }

    return File(palettes.first.path);
  }

  Future<void> savePalette(String projectPath, UnoPalette palette) async {
    final directory = Directory(projectPath);
    final paletteFile = _getProjectPalette(directory);

    await paletteFile.writeAsString(jsonEncode(palette.toJson()));
  }

  Future<UnoProject> fetchProject(String directoryPath) async {
    final directory = Directory(directoryPath);

    final files = directory.listSync();
    final levels = files.where((file) => !file.path.endsWith('.uno')).toList()
      ..sort((a, b) => a.path.compareTo(b.path));

    final paletteRaw = await _getProjectPalette(directory).readAsString();
    final paletteJson = jsonDecode(paletteRaw) as Map<String, dynamic>;
    final palette = UnoPalette.fromJson(paletteJson);

    return UnoProject(
      projecPath: directoryPath,
      levels: levels.map((file) => file.path).toList(),
      palette: palette,
    );
  }
}
