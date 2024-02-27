# Базовый образ Alpine Linux
FROM alpine:3.9

# Копирование файлов с зависимостями
COPY ./www/requirements.txt /data/
COPY ./www/entrypoint.sh /docker-entrypoint.sh

# Установка зависимостей и очистка кеша
RUN apk --no-cache add \
    python3 \
    py3-pip \
    curl \
    postgresql-dev \
    gcc \
    libc-dev \
    python3-dev \
    zlib-dev \
 && pip3 install --upgrade pip \
 && pip3 install --no-cache-dir -r /data/requirements.txt \
 && rm -rf /root/.cache \
 && apk del gcc libc-dev python3-dev zlib-dev \
 && addgroup -g 666 -S student02 \
 && adduser -u 666 -D -S -G student02 student02 \
 && chown -R student02:student02 /data 
 
USER student02

# Установка переменных среды
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Открытие порта
EXPOSE 8000

# Установка рабочей директории
WORKDIR /data

# Копирование приложения
COPY ./www/ /data/

# Запуск скрипта entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
