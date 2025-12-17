import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/audit_entry.dart';

class SyncService {
  static const String baseUrl = 'http://127.0.0.1:8000';

  static Future<List<String>> syncEntries(List<AuditEntry> entries) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/sync/batch'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(entries.map((e) => e.toJson()).toList()),
      );

      if (response.statusCode != 200) {
        return entries.map((e) => e.id).toList();
      }

      final data = jsonDecode(response.body);
      return List<String>.from(data['rejected'] ?? []);
    } catch (_) {
      return entries.map((e) => e.id).toList();
    }
  }
}
