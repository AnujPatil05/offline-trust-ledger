# backend/main.py

from fastapi import FastAPI
from typing import List
from models import AuditEntry
from hash_chain import validate_chain
from hash_chain import compute_hash

app = FastAPI(title="Offline Trust Ledger")

# In-memory store (TEMPORARY)
AUDIT_LOG: List[AuditEntry] = []


@app.post("/sync/batch")
def sync_batch(entries: List[AuditEntry]):
    rejected = []

    for entry in entries:
        expected = compute_hash(entry)

        if entry.hash != expected:
            rejected.append(entry.id)
            continue

        AUDIT_LOG.append(entry)

    return {
        "accepted": len(entries) - len(rejected),
        "rejected": rejected,
        "total": len(AUDIT_LOG)
    }

@app.post("/verify/chain")
def verify_chain():
    return validate_chain(AUDIT_LOG)


@app.get("/health")
def health():
    return {"status": "ok"}
