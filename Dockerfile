FROM tomcat:10.1-jdk17

# Actualiza los certificados CA del sistema (evita errores SSL al conectar
# con servicios externos por HTTPS).
RUN apt-get update && \
    apt-get install -y --reinstall ca-certificates && \
    update-ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# Limpia las apps de ejemplo que trae Tomcat por defecto.
RUN rm -rf /usr/local/tomcat/webapps/*

# Copia el .war y lo renombra a ROOT.war para que la app quede en la raíz
# del dominio (sin tener que escribir /Cafeteriatalleres en la URL).
COPY Cafeteriatalleres.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]
