FROM ubuntu:latest AS build

RUN apt-get update && apt-get install -y openjdk-20-jdk maven && rm -rf /var/lib/apt/lists/*


COPY . .

RUN apt-get install maven -y
RUN mvn clean install

FROM openjdk:20
EXPOSE 8080

COPY --from=build /target/todolist-1.0.0.jar app.jar

ENTRYPOINT ["java", "-jar", "app.jar"]

LABEL authors="kone"

