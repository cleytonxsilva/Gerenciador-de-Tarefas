FROM ubuntu:22.04 AS build

RUN apt-get update
RUN apt-get install -y openjdk-20-jdk

COPY . .

RUN apt-get install -y maven
RUN mvn clean install

FROM openjdk:20

EXPOSE 8080

COPY --from=build /target/todolist-1.0.0.jar app.jar

ENTRYPOINT ["java", "-jar", "app.jar"]

LABEL authors="kone"
