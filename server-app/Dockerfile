FROM python:3.8-slim

WORKDIR /app

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

RUN apt-get update \
    && apt-get install -y --no-install-recommends build-essential default-libmysqlclient-dev gcc \
    && rm -rf /var/lib/apt/lists/*

COPY server-app/requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY server-app/ .

EXPOSE 8000

CMD ["/app/docker-entrypoint.sh"]
