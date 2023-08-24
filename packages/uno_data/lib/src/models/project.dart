import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uno_data/uno_data.dart';

part 'project.freezed.dart';
part 'project.g.dart';

@freezed

/// {@template uno_project}
/// A game project.
/// {@endtemplate}
class UnoProject with _$UnoProject {
  /// {@macro uno_project}
  const factory UnoProject({
    required String projecPath,
    required List<String> levels,
    required UnoPalette palette,
  }) = _UnoProject;

  /// {@macro uno_project}
  factory UnoProject.fromJson(Map<String, dynamic> json) =>
      _$UnoProjectFromJson(json);
}
