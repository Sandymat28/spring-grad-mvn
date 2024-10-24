FROM gradle:jdk8-jammy

WORKDIR /app

COPY . .

RUN ./gradlew clean build

FROM openjdk:24-slim-bullseye

WORKDIR /app

ARG JAR_FILE=build/libs/*.jar

COPY ${JAR_FILE} /app/greeting.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "/app/greeting.jar"]

#FROM maven:3.9.9-amazoncorretto

#WORKDIR /app

#COPY . .

#RUN mvn clean package

#FROM openjdk:24-slim-bullseye

#WORKDIR /app

#ARG JAR_FILE=target/*.jar

#COPY ${JAR_FILE} /app/greeting.jar

#EXPOSE 8080

#ENTRYPOINT ["java", "-jar", "/app/greeting.jar"]


#FROM openjdk:8-jdk-alpine
#RUN addgroup -S spring && adduser -S spring -G spring
#USER spring:spring
#ARG DEPENDENCY=target/dependency
#COPY ${DEPENDENCY}/BOOT-INF/lib /app/lib
#COPY ${DEPENDENCY}/META-INF /app/META-INF
#COPY ${DEPENDENCY}/BOOT-INF/classes /app
#ENTRYPOINT ["java","-cp","app:app/lib/*","hello.Application"]
