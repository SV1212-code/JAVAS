
FROM openjdk:17-slim

WORKDIR /app

COPY helloworld.java .

RUN javac helloworld.java

CMD ["java", "helloworld"]
