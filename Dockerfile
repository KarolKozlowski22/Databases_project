FROM python:3.10-slim-buster
WORKDIR /app
COPY ./requirements.txt /app
RUN pip install --upgrade pip
RUN pip install -r requirements.txt
COPY . .
EXPOSE 5000
ENV FLASK_APP=flask_app.py
CMD ["flask", "run", "--host", "0.0.0.0", "--debug"]
