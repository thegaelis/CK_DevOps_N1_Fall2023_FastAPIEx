# pull official base image
FROM python:3.8.1-alpine

# set work directory
WORKDIR /src

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

EXPOSE 5700
# copy requirements file
COPY ./requirements.txt /src/requirements.txt

# install dependencies
RUN set -eux \
    && apk add --no-cache --virtual .build-deps build-base \
    libressl-dev libffi-dev gcc musl-dev python3-dev \
    postgresql-dev \
    && pip install --upgrade pip setuptools wheel \
    && pip install -r /src/requirements.txt \
    && rm -rf /root/.cache/pip

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "5700"]

# copy project
COPY . /src/

