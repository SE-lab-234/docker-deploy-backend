FROM openjdk:16-jdk-alpine

# Add a group and user for running the application
RUN addgroup -S spring && adduser -S spring -G spring

# Expose port 8080 for the application
EXPOSE 8080

# Set environment variable for Java profile
ENV JAVA_PROFILE=prod

# The location of compiled application dependencies in the build context
ARG DEPENDENCY=target/dependency

# Copy the compiled dependencies from the build context into the container
COPY ${DEPENDENCY}/BOOT-INF/lib /app/lib
COPY ${DEPENDENCY}/META-INF /app/META-INF
COPY ${DEPENDENCY}/BOOT-INF/classes /app

# Set the entry point for the container to run the Java application
ENTRYPOINT ["java", "-Dspring.profiles.active=${JAVA_PROFILE}", "-cp", "app:app/lib/*", "camt.se234.lab10.Lab10Application"]