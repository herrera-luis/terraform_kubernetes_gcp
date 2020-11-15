FROM python:3.7.3-stretch

WORKDIR /app/
COPY . .
RUN pip install -r requirements.txt
CMD ["python","app.py"]
EXPOSE 5000