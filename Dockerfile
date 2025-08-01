FROM python:3.9-slim

WORKDIR /app

COPY . .

RUN apt-get update && apt-get upgrade -y && apt-get install -y gcc default-libmysqlclient-dev build-essential pkg-config && rm -rf /var/lib/apt/lists/*

RUN pip install mysqlclient

RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 5000

CMD ["python","app.py"]

