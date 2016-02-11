#!/bin/ksh

################################################################################
# Script: ocupa
# Version: 1.00 (Unificada SunOS/Linux)
# Fecha: Enero 2013
#
# Muestra el tamano de los archivos incluyendo subdirectorios
#
#################################################################################
#
### -------------------- Variables -------------------------- ####
#

# Unificacion echo con Linux
if [ $OS_TYPE = 'Linux' ]
then
  alias echo='echo -e'
fi


#
### -------------------- Funciones -------------------------- ####
#
#
### -------------------- Principal -------------------------- ####
#

if [ "$1" != "-no" ]
then
  echo "Para obtener salida sin ordenar usar: ocupa -no"
  echo "Calculando y ordenando salida"
  du -s -k * | awk '{ printf "%-25s -> %5.3f MB\n",$2,($1/1024) }'|sort -k 3 -n
else
  du -s -k * | awk '{ printf "%-25s -> %5.3f MB\n",$2,($1/1024) }'
fi

echo "Total ocupado filesystem : `du -h 2>/dev/null | tail -1 | awk '{print $1}'`"

N=`df -kh . | wc -l`
if [ $N -eq 3 ]
then
  echo "Libre en filesystem : `df -kh . | tail -1 | awk '{print $3}'`"
else
  echo "Libre en filesystem : `df -kh . | tail -1 | awk '{print $4}'`"
fi
