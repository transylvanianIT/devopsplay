FROM python:3.9

WORKDIR /dockerpart

COPY calculator.py requirements.txt ./

RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 8080

CMD ["python", "calculator.py"]
