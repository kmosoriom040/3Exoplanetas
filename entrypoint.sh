#!/bin/bash
set -e

DB_HOST="${DB_HOST:-mysql84}"
export DB_HOST

echo "[*] Esperando a MySQL en $DB_HOST..."
until python -c "import mysql.connector as m; m.connect(host='$DB_HOST', user='root', password='root', database='astronomia')" 2>/dev/null; do
  sleep 3
done

FILAS=$(python - <<EOF
import mysql.connector as m
try:
    c = m.connect(host="$DB_HOST", user="root", password="root", database="astronomia")
    cur = c.cursor(); cur.execute("SELECT COUNT(*) FROM planeta"); print(cur.fetchone()[0])
except Exception:
    print(0)
EOF
)

if [ "$FILAS" = "0" ]; then
  echo "[*] Base vacia, ejecutando ETL..."
  python 3ETL_Full_BDExoplanetas.py
else
  echo "[*] Base ya poblada ($FILAS planetas), se omite el ETL."
fi

exec streamlit run 4astronomia_app.py --server.port=8501 --server.address=0.0.0.0
