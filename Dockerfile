FROM python:3.11-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY 3ETL_Full_BDExoplanetas.py 4astronomia_app.py entrypoint.sh ./
RUN chmod +x entrypoint.sh

EXPOSE 8501
CMD ["./entrypoint.sh"]
