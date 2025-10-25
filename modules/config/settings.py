import os
from dotenv import load_dotenv

# .env laden
load_dotenv()

DEBUG_MODE = os.getenv("DEBUG", "false").lower() == "true"
