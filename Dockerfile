FROM openjdk:11-jre-slim
WORKDIR /app
COPY /webapp/target/*.war /app
EXPOSE 8081
CMD ["java", "-jar", "your-app.jar"]

