import 'package:uno/helpers/uno.dart';

extension MetadataX on Map<String, String> {
  Map<String, String> editableMetadata() {
    return {
      for (final entry in entries)
        if (!reservedDataKeys.contains(entry.key)) entry.key: entry.value,
    };
  }
}

extension StringX on String {
  String toInitials() {
    late String firstLetter;
    String? lastLetter;

    if (length >= 1) {
      firstLetter = this[0];
    }

    if (length >= 2) {
      lastLetter = this[1];
    }

    return '${firstLetter.toUpperCase()}${lastLetter?.toUpperCase() ?? ''}';
  }
}
