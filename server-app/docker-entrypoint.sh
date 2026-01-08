#!/usr/bin/env bash
set -euo pipefail

python - <<'PY'
import os
import time
import pymysql

host = os.getenv("DB_HOST", "127.0.0.1")
port = int(os.getenv("DB_PORT", "3306"))
user = os.getenv("DB_USER", "apex")
password = os.getenv("DB_PASSWORD", "apex08")
name = os.getenv("DB_NAME", "foodforall")

for attempt in range(30):
    try:
        conn = pymysql.connect(host=host, port=port, user=user, password=password, database=name)
        conn.close()
        break
    except Exception as exc:
        print(f"Waiting for database... ({attempt + 1}/30) {exc}")
        time.sleep(2)
else:
    raise SystemExit("Database is not reachable")
PY

python manage.py migrate
python manage.py runserver --noreload 0.0.0.0:8000
