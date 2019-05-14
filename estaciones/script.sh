#Añadir columna de Estacion 
sed 's/\([0-9]\)\r/\1;Estacion1/' estacion1.csv > e1.csv
sed 's/\([0-9]\)\r/\1;Estacion2/' estacion2.csv > e2.csv
sed 's/\([0-9]\)\r/\1;Estacion3/' estacion3.csv > e3.csv
sed 's/\([0-9]\)\r/\1;Estacion4/' estacion4.csv > e4.csv
#Quitar encabezado de los archivos 2, 3 y 4
sed 1d e2.csv > e22.csv
sed 1d e3.csv > e33.csv
sed 1d e4.csv > e44.csv
#Unir los archivos en uno solo
cat e1.csv e22.csv e33.csv e44.csv > estaciones.csv
#Reemplazar los ; por ,
sed 's/;/,/g' estaciones.csv > estaciones1.csv
#Reemplazar los , por . en los decimales
sed 's/,\([0-9]\),\([0-9]\),/,\1.\2,/' estaciones1.csv > estaciones2.csv
sed 's/,\([0-9][0-9]\),\([0-9]\),/,\1.\2,/' estaciones2.csv > estaciones3.csv
# Reemplazar los \ por ,  en el archivo 
sed 's/\//,/g' estaciones3.csv > estaciones4.csv
# Reemplazar los : por , en el archivo
sed 's/:/,/g' estaciones4.csv > estaciones5.csv
#Reemplazar la primera linea
sed 's/FECHA,HHMMSS,DIR,VEL/Dia,Mes,Año,Hora,Minuto,Segundo,Direccion,Velocidad,Estacion/' estaciones5.csv > estaciones6.csv
#Generando la primera consulta velocidad por mes
csvsql --query 'select Estacion,Mes,avg(Velocidad) as prom_vel_Mes from estaciones6.csv group by Estacion,Mes' estaciones6.csv > velocidadpormes.csv
#Generando la segunda consulta velocidad por año
csvsql --query 'select Estacion,Año,avg(Velocidad) as prom_vel_Año from estaciones6.csv group by Estacion,Año' estaciones6.csv > velocidadporaño.csv
#Generando la tercera consulta velocidad por hora
csvsql --query 'select Estacion,Hora,avg(Velocidad) as prom_vel_Hora from estaciones6.csv group by Estacion,Hora' estaciones6.csv > velocidadporhora.csv
#Removiendo archivos intermedios
rm e1.csv
rm e2.csv
rm e3.csv
rm e4.csv
rm e22.csv
rm e33.csv
rm e44.csv
rm estaciones.csv
rm estaciones1.csv
rm estaciones2.csv
rm estaciones3.csv
rm estaciones4.csv
rm estaciones5.csv
rm estaciones6.csv
