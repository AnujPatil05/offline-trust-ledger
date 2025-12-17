# Offline Trust Ledger

An offline-first audit logging system that detects data tampering using cryptographic hash chaining and server-side verification.

## What this project does

- Allows users to log events while offline
- Chains entries using SHA-256 hashes
- Syncs entries in batches when online
- Verifies integrity on the backend
- Rejects logs if tampering or inconsistency is detected

## Why this exists

Traditional offline logging systems trust the client.
This project assumes the client cannot be trusted and verifies data integrity independently on the server.

## Tech Stack

- Frontend: Flutter
- Backend: FastAPI (Python)
- Security: SHA-256 hash chaining
- Architecture: Offline-first with batch sync

## Integrity Model

Each entry includes the hash of the previous entry.
If any entry is modified, the chain breaks and the backend rejects the data.

## Notes

Local device data may be rejected if integrity rules are violated.
On fresh installs, the ledger initializes cleanly.

## How to run

/backend for backend service
/mobile for flutter setup
