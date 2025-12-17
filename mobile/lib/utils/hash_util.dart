import 'dart:convert';
import 'package:crypto/crypto.dart';

String computeHash(Map<String, dynamic> input) {
  // Sort keys to match backend
  final sortedKeys = input.keys.toList()..sort();
  final sortedMap = {for (final k in sortedKeys) k: input[k]};

  final canonicalJson = jsonEncode(sortedMap);
  final bytes = utf8.encode(canonicalJson);

  // FULL SHA-256 — NO substring
  return sha256.convert(bytes).toString();
}
