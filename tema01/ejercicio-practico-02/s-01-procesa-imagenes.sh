# @Autor Vicente Romero Andrade
# @Fecha 22/02/2021
# @Descripcion Procesa URL de imagenes

function ayuda() {
    echo "Para ejecutar el programa utilizar la siguiente sintaxis:
    ./s-01-procesa-imagenes.sh <path_archivo_imagen> <num_imagenes> [<nombre_archivo_zip>]
    <path_archivo_imagen> Ruta y nombre donde se encuentra el archivo de texto que contiene un URL
    por cada renglón de la imagen que será descargada de internet.
    <num_imagenes> Total de imágenes a descargar, entre 1 y hasta 90 imágenes
    [<nombre_archivo_zip>] Parámetro opcional que indica la ruta y nombre del archivo zip a generar. 
    En caso de no especificarse se empleará el nombre 
    imagenes-yyyy-mm-dd-hh:mi:ss.zip y estará ubicado en 
    ${TMP}/imagenes/${USER}/imagenes. Si se especifica este parámetro, su valor 
    deberá incluir la ruta y el nombre del archivo zip a generar. La ruta 
    absoluta y el nombre del archivo zip generado deberá ser exportado empleando 
    una variable de entorno IMG_ZIP_FILE"
}

RUTA=${1}
NUM_IMAGENES=${2}
ZIP_GEN=${3}
RE='^[0-9]+$'
if ! [ "$RUTA" != '' ]; then
  exit 100
elif ! [ -f "$RUTA" ]; then
  exit 101
elif [[ "$NUM_IMAGENES" -le 1 || "$NUM_IMAGENES" -ge 90 ]] ; then
  echo "102"
  exit 102
elif ! [ -f "$ZIP_GEN" ]; then
    date
elif ! [[ -f "$ZIP_GEN"  && "$ZIP_GEN" != "" ]]; then
  echo "103"
  exit 103
else 
  for((i=1;i<=NUM_IMAGENES;i++)); do
      URL=$(sed "$i!d" "$RUTA")
       wget -qo- "$URL" | gzip "$ZIP_GEN"
      #RES=$(wget -qo- "$URL")
      #echo "|$RES|"

  done
  
fi


