# 3Exoplanetas

Dashboard de analisis exoplanetario (Streamlit + MySQL) con ETL de datos de exoplanetas.

## Requisitos

Docker y Docker Compose.

## Ejecutar

    git clone https://github.com/kmosoriom040/3Exoplanetas.git
    cd 3Exoplanetas
    docker compose up

Abrir http://localhost:8501 (la primera vez el ETL descarga los datos y puede tardar unos minutos).

Para detener: `docker compose down` (agregar `-v` para borrar tambien la base de datos).

## Imagen en Docker Hub

    docker pull kmosorio40/exoplanetas:v1.0

## Estructura

- `3ETL_Full_BDExoplanetas.py`: extraccion, transformacion y carga a MySQL
- `4astronomia_app.py`: dashboard en Streamlit
- `Dockerfile`, `docker-compose.yml`, `entrypoint.sh`: despliegue
- `diagrama_relacional.png`: modelo de la base de datos
