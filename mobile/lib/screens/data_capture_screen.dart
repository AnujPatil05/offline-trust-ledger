import 'package:flutter/material.dart';

class DataCaptureScreen extends StatelessWidget {
  const DataCaptureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF141B2D),
        title: const Text('Field Entry #14092'),
        actions: [
          IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status Chips
            Row(
              children: [
                _statusChip(
                  'OFFLINE',
                  Icons.cloud_off,
                  const Color(0xFF6B7280),
                ),
                const SizedBox(width: 8),
                _statusChip(
                  'NOT SYNCED',
                  Icons.sync_disabled,
                  const Color(0xFFF59E0B),
                ),
                const SizedBox(width: 8),
                _statusChip(
                  'UNVERIFIED',
                  Icons.lock_open,
                  const Color(0xFF6B7280),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Item Identification
            _sectionHeader('Item Identification'),
            const SizedBox(height: 12),
            _buildTextField('SKU / Asset ID', 'AST-902-X1', Icons.inventory),
            const SizedBox(height: 24),

            // Action Details
            _sectionHeader('Action Details'),
            const SizedBox(height: 12),
            _buildTextField(
              'Location',
              'Warehouse A - Zone 4',
              Icons.location_on,
            ),
            const SizedBox(height: 12),

            // Condition
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF141B2D),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFF1F2937)),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Condition',
                          style: TextStyle(
                            color: Color(0xFF9CA3AF),
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Good',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF141B2D),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFF1F2937)),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Quantity',
                          style: TextStyle(
                            color: Color(0xFF9CA3AF),
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '1',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Action Type Buttons
            Row(
              children: [
                _actionButton(
                  'Audit',
                  Icons.checklist,
                  const Color(0xFF4C6FFF),
                  true,
                ),
                const SizedBox(width: 8),
                _actionButton(
                  'Verify',
                  Icons.verified,
                  const Color(0xFF6B7280),
                  false,
                ),
                const SizedBox(width: 8),
                _actionButton(
                  'Move',
                  Icons.drive_file_move,
                  const Color(0xFF6B7280),
                  false,
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Evidence
            _sectionHeader('Evidence'),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _evidenceButton('Attach Photo', Icons.camera_alt),
                ),
                const SizedBox(width: 12),
                Expanded(child: _evidenceButton('Add Note', Icons.note_add)),
              ],
            ),
            const SizedBox(height: 24),

            // Sign & Capture Button
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('✓ Entry captured offline'),
                      backgroundColor: Color(0xFF10B981),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4C6FFF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.fingerprint, size: 20),
                    SizedBox(width: 8),
                    Text(
                      'Sign & Capture',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statusChip(String label, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }

  Widget _buildTextField(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF141B2D),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF1F2937)),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF6B7280), size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: Color(0xFF9CA3AF),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionButton(
    String label,
    IconData icon,
    Color color,
    bool selected,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: selected ? color.withOpacity(0.2) : const Color(0xFF141B2D),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: selected ? color : const Color(0xFF1F2937)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 16,
              color: selected ? color : const Color(0xFF6B7280),
            ),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                color: selected ? color : const Color(0xFF6B7280),
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _evidenceButton(String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF141B2D),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF1F2937)),
      ),
      child: Column(
        children: [
          Icon(icon, color: const Color(0xFF6B7280), size: 32),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 12),
          ),
        ],
      ),
    );
  }
}
