FROM python:3.11 as builder

WORKDIR /app/backend

COPY requirements.txt /app/backend
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y gcc default-libmysqlclient-dev pkg-config \
    && rm -rf /var/lib/apt/lists/*


# Install app dependencies
RUN pip install --prefix=/install -r requirements.txt

FROM python:3.11-slim
WORKDIR /app/backend

RUN apt-get update \
    && apt-get install -y \
        default-libmysqlclient-dev \
    && rm -rf /var/lib/apt/lists/*

COPY --from=builder /install /usr/local

COPY . /app/backend

EXPOSE 8000
CMD ["python3", "manage.py", "runserver", "0.0.0.0:8000"]
#RUN python manage.py migrate
#RUN python manage.py makemigrations
