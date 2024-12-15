# Build stage
FROM maven:3-openjdk-21 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Run stage
FROM openjdk:21-jdk-slim
WORKDIR /app
COPY --from=build /app/target/demo-0.0.1-SNAPSHOT.war demo.war
EXPOSE 8082
ENTRYPOINT ["java", "-jar", "demo.war"]
