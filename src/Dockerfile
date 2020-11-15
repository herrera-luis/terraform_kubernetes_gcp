FROM python:3.7.3-alpine

WORKDIR /app/
COPY . .
RUN pip install -r requirements.txt
CMD ["python","app.py"]
EXPOSE 5000