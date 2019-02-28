#!/bin/bash

if [ $# -ne 1 ]
then
	echo "Uso: crear-pom.sh prefijojar"
	exit 1
fi

fecha=`date '+%Y%m%d%H%M%S'`
cd /datos/weblogic/test/servletclasses
find . -name "*.class" | zip -@ /datos/scripts/jenkins/$1.jar

cd /datos/scripts/jenkins

echo '<?xml version="1.0" encoding="UTF-8"?><project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">' > pom.xml
echo '<modelVersion>4.0.0</modelVersion>' >> pom.xml
echo '<groupId>es.xx.xxxx.comun</groupId>' >> pom.xml
echo "<artifactId>$1</artifactId>" >> pom.xml
echo "<version>${fecha}</version>" >> pom.xml
echo '</project>' >> pom.xml

ssh -o "StrictHostKeyChecking no" -l xxx xxx "rm /var/tmp/despliegue/$1* 2>/dev/null" 
scp /datos/scripts/jenkins/$1.jar xxx@xxx:/var/tmp/despliegue
scp /datos/scripts/jenkins/pom.xml xxx@xxx:/var/tmp/despliegue
