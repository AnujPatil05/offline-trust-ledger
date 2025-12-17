import 'package:flutter/material.dart';
import '../models/audit_entry.dart';

class AuditLogViewer extends StatefulWidget {
  final List<AuditEntry> entries;

  const AuditLogViewer({super.key, required this.entries});

  @override
  State<AuditLogViewer> createState() => _AuditLogViewerState();
}

class _AuditLogViewerState extends State<AuditLogViewer> {
  String _filter = 'All Logs';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF141B2D),
        title: const Text('Audit Ledger'),
        actions: [
          IconButton(icon: const Icon(Icons.code), onPressed: () {}),
          IconButton(icon: const Icon(Icons.file_download), onPressed: () {}),
          IconButton(icon: const Icon(Icons.delete_outline), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          // Status Banner
          Container(
            color: const Color(0xFF10B981).withOpacity(0.2),
            padding: const EdgeInsets.all(16),
            child: const Row(
              children: [
                Icon(Icons.verified_user, color: Color(0xFF10B981), size: 20),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'SYSTEM SECURE',
                        style: TextStyle(
                          color: Color(0xFF10B981),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Last sync: 14 ago • Blockchain: 462931',
                        style: TextStyle(
                          color: Color(0xFF6B7280),
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Search hash, user, or action ID...',
                      hintStyle: const TextStyle(color: Color(0xFF6B7280)),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Color(0xFF6B7280),
                      ),
                      filled: true,
                      fillColor: const Color(0xFF141B2D),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.filter_list),
                  onPressed: () {},
                  style: IconButton.styleFrom(
                    backgroundColor: const Color(0xFF141B2D),
                    padding: const EdgeInsets.all(16),
                  ),
                ),
              ],
            ),
          ),

          // Filter Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                _filterChip('All Logs', true),
                _filterChip('Errors', false),
                _filterChip('Pending', false),
                _filterChip('Synced', false),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Entries List
          Expanded(
            child: widget.entries.isEmpty
                ? const Center(
                    child: Text(
                      'No audit entries yet',
                      style: TextStyle(color: Color(0xFF6B7280)),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: widget.entries.length,
                    itemBuilder: (context, index) {
                      final entry =
                          widget.entries[widget.entries.length - 1 - index];
                      return _buildLogItem(entry, index == 0);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _filterChip(String label, bool selected) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: selected
            ? const Color(0xFF4C6FFF).withOpacity(0.2)
            : const Color(0xFF141B2D),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: selected ? const Color(0xFF4C6FFF) : const Color(0xFF1F2937),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: selected ? const Color(0xFF4C6FFF) : const Color(0xFF9CA3AF),
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildLogItem(AuditEntry entry, bool isLatest) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF141B2D),
        borderRadius: BorderRadius.circular(12),
        border: isLatest
            ? Border.all(color: const Color(0xFF4C6FFF), width: 2)
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.description,
                  color: Color(0xFF10B981),
                  size: 16,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entry.payload['action'] ?? 'Action',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'User: ${entry.userId} • ${entry.eventType}',
                      style: const TextStyle(
                        color: Color(0xFF6B7280),
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'Verified',
                  style: TextStyle(color: Color(0xFF10B981), fontSize: 10),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF0A0E1A),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _hashRow('Hash', entry.hash.substring(0, 16)),
                const SizedBox(height: 4),
                _hashRow(
                  'Prev',
                  entry.previousHash?.substring(0, 16) ?? 'GENESIS',
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _formatDateTime(entry.timestamp),
            style: const TextStyle(color: Color(0xFF6B7280), fontSize: 10),
          ),
        ],
      ),
    );
  }

  Widget _hashRow(String label, String hash) {
    return Row(
      children: [
        SizedBox(
          width: 40,
          child: Text(
            label,
            style: const TextStyle(color: Color(0xFF6B7280), fontSize: 11),
          ),
        ),
        Text(
          hash,
          style: const TextStyle(
            color: Color(0xFF4C6FFF),
            fontSize: 11,
            fontFamily: 'monospace',
          ),
        ),
      ],
    );
  }

  String _formatDateTime(DateTime dt) {
    return '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')} ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  }
}
