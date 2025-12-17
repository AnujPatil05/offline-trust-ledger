import hashlib
import json
from typing import List
from models import AuditEntry


def compute_hash(entry: AuditEntry) -> str:
    payload = {
        "id": entry.id,
        "previous_hash": entry.previous_hash or "GENESIS",
        "timestamp": entry.timestamp.isoformat(),
        "event_type": entry.event_type,
        "user_id": entry.user_id,
        "device_id": entry.device_id,
        "payload": entry.payload,
    }

    canonical = json.dumps(payload, sort_keys=True)
    return hashlib.sha256(canonical.encode()).hexdigest()


def validate_chain(entries: List[AuditEntry]):
    errors = []

    for i, entry in enumerate(entries):
        expected = compute_hash(entry)

        if expected != entry.hash:
            errors.append({
                "entry_id": entry.id,
                "error": "Hash mismatch (possible tampering)"
            })

        if i > 0 and entry.previous_hash != entries[i - 1].hash:
            errors.append({
                "entry_id": entry.id,
                "error": "Chain broken (previous hash mismatch)"
            })

    return {
        "valid": len(errors) == 0,
        "entries_checked": len(entries),
        "errors": errors,
    }
