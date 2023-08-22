import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uno/models/models.dart';

part 'project.freezed.dart';
part 'project.g.dart';

@freezed
class UnoProject with _$UnoProject {
  const factory UnoProject({
    required String projecPath,
    required List<String> levels,
    required UnoPalette palette,
  }) = _UnoProject;

  factory UnoProject.fromJson(Map<String, dynamic> json) =>
      _$UnoProjectFromJson(json);
}
