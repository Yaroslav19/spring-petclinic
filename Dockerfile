FROM openjdk:11-jre

WORKDIR /app

ARG JAR_FILE=target/*.jar
ARG Xms=256m
ARG Xmx=512m

RUN addgroup --system petclinic && adduser --system --group petclinic
USER petclinic:petclinic

COPY ${JAR_FILE} /app/petclinic.jar

EXPOSE 8080

ENV JAVA_OPTS="-Xms${Xms} -Xmx=${Xmx}"

CMD ["bash","-c","java -jar /app/petclinic.jar"]
