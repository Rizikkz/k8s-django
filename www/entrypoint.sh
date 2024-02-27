#!/bin/sh

# if [ "$DATABASE" = "postgres" ]
# then
#     echo "Waiting for postgres..."
#     sleep 20


#     echo "PostgreSQL started"
# fi

 python3 manage.py flush --no-input
 sleep 5
 python3 manage.py migrate
 sleep 5
# exec "$@"
 #python3 manage.py runserver 0.0.0.0:8000
 gunicorn app.wsgi:application --bind 0.0.0.0:8000