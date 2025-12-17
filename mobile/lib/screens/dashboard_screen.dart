import 'package:flutter/material.dart';

import '../models/audit_entry.dart';
import '../utils/hash_util.dart';
import '../services/sync_service.dart';

import 'offline_queue_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final List<AuditEntry> entries = [];
  int pendingSync = 0;
  bool isSyncing = false;

  // -------------------------
  // CREATE OFFLINE ENTRY
  // -------------------------
  void _logEvent() {
    final temp = AuditEntry(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      previousHash: entries.isEmpty ? null : entries.last.hash,
      timestamp: DateTime.now().toUtc(),
      eventType: "CREATE",
      userId: "user_alex",
      deviceId: "device_001",
      payload: {"action": "Warehouse Entry Logged"},
      hash: "",
    );

    // IMPORTANT: hash computed from TEMP entry (not entry)
    final hash = computeHash({
      'id': temp.id,
      'previous_hash': temp.previousHash ?? 'GENESIS',
      'timestamp': temp.timestamp.toIso8601String(),
      'event_type': temp.eventType,
      'user_id': temp.userId,
      'device_id': temp.deviceId,
      'payload': temp.payload,
    });

    setState(() {
      entries.add(
        AuditEntry(
          id: temp.id,
          previousHash: temp.previousHash,
          timestamp: temp.timestamp,
          eventType: temp.eventType,
          userId: temp.userId,
          deviceId: temp.deviceId,
          payload: temp.payload,
          hash: hash,
        ),
      );
      pendingSync++;
    });
  }

  // -------------------------
  // SYNC TO SERVER
  // -------------------------
  Future<void> _sync() async {
    setState(() => isSyncing = true);

    final rejectedIds = await SyncService.syncEntries(entries);

    setState(() {
      isSyncing = false;

      if (rejectedIds.isEmpty) {
        pendingSync = 0;
      }

      for (int i = 0; i < entries.length; i++) {
        if (rejectedIds.contains(entries[i].id)) {
          entries[i] = entries[i].copyWith(rejected: true);
        }
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          rejectedIds.isEmpty
              ? '✓ All entries verified'
              : '✗ ${rejectedIds.length} entry rejected (tampered)',
        ),
        backgroundColor: rejectedIds.isEmpty ? Colors.green : Colors.red,
      ),
    );
  }

  // -------------------------
  // UI
  // -------------------------
  @override
  Widget build(BuildContext context) {
    final integrityBroken = entries.any((e) => e.rejected);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: const Color(0xFF141B2D),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _statusCard(integrityBroken),
          const SizedBox(height: 16),

          _syncCard(),
          const SizedBox(height: 16),

          _actionButton('Log Offline Entry', Icons.edit_note, _logEvent),
          _actionButton('Sync to Server', Icons.sync, _sync),
          _actionButton('Offline Queue', Icons.storage, () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => OfflineQueueScreen(entries: entries),
              ),
            );
          }),

          const SizedBox(height: 24),
          const Text('Recent Activity'),
          const SizedBox(height: 8),

          ...entries.reversed.take(5).map(_activityItem),
        ],
      ),
    );
  }

  Widget _statusCard(bool broken) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF141B2D),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: broken ? Colors.red : Colors.green),
      ),
      child: Text(
        broken ? 'Integrity Compromised' : 'System Integrity Verified',
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _syncCard() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('$pendingSync entries pending sync'),
        TextButton(
          onPressed: isSyncing ? null : _sync,
          child: const Text('Sync Now'),
        ),
      ],
    );
  }

  Widget _actionButton(String label, IconData icon, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: Icon(icon),
        label: Text(label),
      ),
    );
  }

  Widget _activityItem(AuditEntry e) {
    return ListTile(
      title: Text(e.payload['action']),
      subtitle: Text(e.hash.substring(0, 12)),
      trailing: Icon(
        e.rejected ? Icons.warning : Icons.check_circle,
        color: e.rejected ? Colors.red : Colors.green,
      ),
    );
  }
}
