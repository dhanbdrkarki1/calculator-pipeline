FROM frolvlad/alpine-oraclejdk8:slim
# default build directory for gradle is build/libs/ and calculator-0.0.1-SNAPSHOT.jar is complete application packaged into one jar file.
COPY build/libs/calculator-0.0.1-SNAPSHOT.jar app.jar
ENTRYPOINT [ "java","-jar", "app.jar" ]