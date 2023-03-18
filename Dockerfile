FROM python:3.8.5-alpine
LABEL maintainer="Mohammad Norouzi"
ENV PYTHONUNBUFFERED 1
ENV PYTHONDONTWRITEBYTECODE 1

WORKDIR /app

RUN apk add --no-cache --virtual .build-deps \
    postgresql-dev \
    gcc \
    python3-dev \
    musl-dev \
    zlib-dev \
    jpeg-dev \
    linux-headers

COPY requirements.txt /app/
RUN pip install -r requirements.txt

COPY ./app /app/

RUN python manage.py migrate

EXPOSE 8000

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
