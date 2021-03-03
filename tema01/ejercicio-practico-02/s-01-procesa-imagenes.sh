#!/bin/bash
# @Autor Vicente Romero Andrade
# @Fecha 22/02/2021
# @Descripcion Procesa URL de imagenes

ARCHIVO_IMAGENES=${1}
NUM_IMAGENES=${2}
ARCHIVO_ZIP=${3}

function ayuda() {
  STATUS="${1}"
  cat s-02-ayuda.sh
  exit "${STATUS}"
}

if [ -z "${ARCHIVO_IMAGENES}" ]; then
  echo "ERROR: El nombre del archivo de imágenes es obligatorio"
  ayuda 100
elif ! [ -f "${ARCHIVO_IMAGENES}" ]; then
  echo "ERROR: El archivo ${ARCHIVO_IMAGENES} no existe"
  ayuda 101
elif ! [[ "${NUM_IMAGENES}" =~  [0-9]+ && "${NUM_IMAGENES}" -gt 0 && 
  "${NUM_IMAGENES}" -le 90 ]] ; then
  echo "ERROR: El parametro de numero de imagenes no es correcto"
  ayuda 102
elif [ -n "${ARCHIVO_ZIP}" ]; then
  # Extraer la ruta del archivo zip
  DIR_SALIDA=$(dirname "${ARCHIVO_ZIP}")
  mkdir -p "${DIR_SALIDA}"
  NOMBRE_ZIP=$(basename "${ARCHIVO_ZIP}")
  if ! [ -d "${DIR_SALIDA}" ]; then
    echo "ERROR: El directorio de salida no existe"
    ayuda 103
  fi
else
  DIR_SALIDA="/tmp/${USER}/imagenes"
  mkdir -p "${DIR_SALIDA}"
  NOMBRE_ZIP="imagenes-$(date '+%Y-%m-%H-%M-%S').zip"
fi

echo "Parámetros correctos, obteniendo imágenes..."
# Limpiar directorio en caso de que no este vacio
rm -f "${DIR_SALIDA}"/"${NOMBRE_ZIP}"

# Leer el contenido del archivo que contiene la lista imágenes
# que se van a descargas
COUNT=1
while read -r LINEA
do
  wget -q -P "${DIR_SALIDA}" "${LINEA}"
  STATUS=$?
  if ! [ "${STATUS}" -eq 0 ]; then
    echo "ERROR: al descargar una imagen"
    ayuda 104
  fi
  if [ "${COUNT}" -ge "${NUM_IMAGENES}" ]; then
    break
  fi
  COUNT=$((COUNT+1))
done < "${ARCHIVO_IMAGENES}"

#Generando archivo zip
export IMG_ZIP_FILE="${DIR_SALIDA}"/"${NOMBRE_ZIP}"
zip -j "${IMG_ZIP_FILE}" "${DIR_SALIDA}"/*.jpg

# Eliminar imágenes descargadas
rm -rf "${DIR_SALIDA}"/*.jpg

#Cambiar permisos
chmod 700 "${DIR_SALIDA}"/"${NOMBRE_ZIP}"

# Generar lista de archivos
unzip -Z1 "${IMG_ZIP_FILE}" > "${DIR_SALIDA}"/s-00-lista-archivos.txt
