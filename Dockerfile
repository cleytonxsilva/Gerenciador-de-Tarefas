FROM ubuntu:22.04 AS build

RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:openjdk-r/ppa && \
    apt-get update && \
    apt-get install -y openjdk-20-jdk maven && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY . .

RUN mvn clean install

FROM openjdk:17
WORKDIR /app

EXPOSE 8080

COPY --from=build /app/target/todolist-1.0.0.jar app.jar

ENTRYPOINT ["java", "-jar", "app.jar"]

LABEL authors="kone"
