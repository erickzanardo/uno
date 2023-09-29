// ignore_for_file: prefer_const_constructors

import 'package:test/test.dart';
import 'package:uno_data/uno_data.dart';

void main() {
  group('UnoLevelObject', () {
    test('can be created', () {
      expect(
        UnoLevelObject(
          x: 0,
          y: 0,
          metadata: {},
        ),
        isNotNull,
      );
    });

    group('metadataValue', () {
      test('returns null if the key does not exist', () {
        expect(
          UnoLevelObject(
            x: 0,
            y: 0,
            metadata: {},
          ).metadataValue<String>('key'),
          isNull,
        );
      });

      test('returns the value if the key exists', () {
        expect(
          UnoLevelObject(
            x: 0,
            y: 0,
            metadata: {'key': 'value'},
          ).metadataValue<String>('key'),
          equals('value'),
        );
      });

      test('returns the value as an int if the key exists', () {
        expect(
          UnoLevelObject(
            x: 0,
            y: 0,
            metadata: {'key': '1'},
          ).metadataValue<int>('key'),
          equals(1),
        );
      });

      test('returns the value as a double if the key exists', () {
        expect(
          UnoLevelObject(
            x: 0,
            y: 0,
            metadata: {'key': '1.0'},
          ).metadataValue<double>('key'),
          equals(1.0),
        );
      });

      test('returns the value as a bool if the key exists', () {
        expect(
          UnoLevelObject(
            x: 0,
            y: 0,
            metadata: {'key': 'true'},
          ).metadataValue<bool>('key'),
          isTrue,
        );
      });
    });
  });
}
