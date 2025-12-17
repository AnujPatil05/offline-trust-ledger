import 'package:flutter/material.dart';
import '../models/audit_entry.dart';

class OfflineQueueScreen extends StatelessWidget {
  final List<AuditEntry> entries;

  const OfflineQueueScreen({super.key, required this.entries});

  @override
  Widget build(BuildContext context) {
    final pending = entries.where((e) => !e.rejected).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Offline Queue'),
        backgroundColor: const Color(0xFF141B2D),
      ),
      body: pending.isEmpty
          ? const Center(
              child: Text(
                'No pending entries',
                style: TextStyle(color: Color(0xFF6B7280)),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: pending.length,
              itemBuilder: (context, index) {
                final entry = pending[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF141B2D),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        entry.payload['action'],
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Hash: ${entry.hash.substring(0, 10)}...',
                        style: const TextStyle(
                          fontSize: 11,
                          color: Color(0xFF6B7280),
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Status: Pending Sync',
                        style: TextStyle(
                          fontSize: 11,
                          color: Color(0xFFF59E0B),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
