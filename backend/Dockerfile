FROM python:3.10 AS build
WORKDIR /code
COPY requirements.txt .
RUN pip install -r requirements.txt
COPY . .

FROM python:3.10-slim
ENV PYTHONUNBUFFERED=1
WORKDIR /code
COPY --from=build /usr/local/lib/python3.10/site-packages /usr/local/lib/python3.10/site-packages
COPY --from=build /code /code
EXPOSE 8000
CMD ["python","manage.py","runserver","0.0.0.0:8000"]
