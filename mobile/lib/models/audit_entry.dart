class AuditEntry {
  final String id;
  final String? previousHash;
  final DateTime timestamp;
  final String eventType;
  final String userId;
  final String deviceId;
  final Map<String, dynamic> payload;
  final String hash;
  final bool rejected;

  AuditEntry({
    required this.id,
    this.previousHash,
    required this.timestamp,
    required this.eventType,
    required this.userId,
    required this.deviceId,
    required this.payload,
    required this.hash,
    this.rejected = false,
  });

  // -------------------------
  // COPY WITH (IMMUTABILITY)
  // -------------------------
  AuditEntry copyWith({
    String? id,
    String? previousHash,
    DateTime? timestamp,
    String? eventType,
    String? userId,
    String? deviceId,
    Map<String, dynamic>? payload,
    String? hash,
    bool? rejected,
  }) {
    return AuditEntry(
      id: id ?? this.id,
      previousHash: previousHash ?? this.previousHash,
      timestamp: timestamp ?? this.timestamp,
      eventType: eventType ?? this.eventType,
      userId: userId ?? this.userId,
      deviceId: deviceId ?? this.deviceId,
      payload: payload ?? this.payload,
      hash: hash ?? this.hash,
      rejected: rejected ?? this.rejected,
    );
  }

  // -------------------------
  // JSON SERIALIZATION (REQUIRED FOR SYNC)
  // -------------------------
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'previous_hash': previousHash,
      'timestamp': timestamp.toIso8601String(),
      'event_type': eventType,
      'user_id': userId,
      'device_id': deviceId,
      'payload': payload,
      'hash': hash,
    };
  }
}
