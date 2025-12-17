# backend/models.py

from pydantic import BaseModel
from typing import Optional, Dict, Any
from datetime import datetime
from enum import Enum


class EventType(str, Enum):
    CREATE = "CREATE"
    UPDATE = "UPDATE"
    DELETE = "DELETE"
    ACCESS = "ACCESS"


class AuditEntry(BaseModel):
    id: str
    previous_hash: Optional[str]
    timestamp: datetime
    event_type: EventType
    user_id: str
    device_id: str
    payload: Dict[str, Any]
    hash: str
