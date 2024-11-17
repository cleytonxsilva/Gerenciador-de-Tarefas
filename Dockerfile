FROM ubuntu:latest AS build

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y openjdk-20-jdk maven
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

COPY . .

RUN mvn clean install
FROM openjdk:20-jre
WORKDIR /app
EXPOSE 8080

COPY --from=build /target/todolist-1.0.0.jar app.jar

ENTRYPOINT ["java", "-jar", "app.jar"]

LABEL authors="kone"

