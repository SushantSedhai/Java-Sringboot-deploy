# Build stage
FROM amazoncorretto:17-alpine-jdk AS build
WORKDIR /app
COPY . .
RUN chmod +x ./mvnw
RUN ./mvnw package -DskipTests

# Package stage
FROM amazoncorretto:17-alpine-jre
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
ENTRYPOINT ["java","-jar","app.jar"]
