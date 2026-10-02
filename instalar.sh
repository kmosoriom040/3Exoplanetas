#!/bin/bash

echo "======================================"
echo " INICIANDO DESPLIEGUE DEL SISTEMA"
echo "======================================"

# 1. Permisos para los scripts
chmod +x 1limpiar.sh 2crear.sh

# 2. Limpiar y crear Docker
./1limpiar.sh
./2crear.sh

echo ""
echo "[*] Esperando 15 segundos para asegurar que MySQL esté operativo..."
sleep 15

# 3. Mover y ejecutar el script ETL intacto DENTRO del contenedor de Jupyter
echo ""
echo "[*] Copiando script ETL al contenedor Jupyter..."
sudo docker cp 3ETL_Full_BDExoplanetas.py jupyter:/home/jovyan/

echo "[*] Instalando dependencias en el contenedor y ejecutando la extracción de datos..."
sudo docker exec -it jupyter pip install mysql-connector-python sqlalchemy pymysql requests pandas
sudo docker exec -it jupyter python /home/jovyan/3ETL_Full_BDExoplanetas.py

# 4. Instalar dependencias en la máquina local para Streamlit
echo ""
echo "[*] Instalando dependencias locales para Streamlit..."
pip install pandas mysql-connector-python streamlit plotly

# 5. Levantar el dashboard
echo ""
echo "[*] Iniciando servidor de Streamlit..."
streamlit run 4astronomia_app.py
