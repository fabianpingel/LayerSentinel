import os
import logging

def get_secret(name: str, required: bool = True) -> str | None:
    value = os.getenv(name)
    if required and not value:
        logging.error(f"❌ Required environment variable '{name}' is missing!")
        raise EnvironmentError(f"Missing required environment variable: {name}")
    return value

def mask_secret(secret: str | None, visible: int = 4) -> str:
    if not secret:
        return "(not set)"
    return '*' * max(len(secret) - visible, 0) + secret[-visible:]
