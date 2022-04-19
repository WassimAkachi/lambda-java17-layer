#!/bin/sh

# -4 IPv4 only
# -L follow redirect if the server responds with a redirect
mkdir layer
curl -4 -L https://repo.maven.apache.org/maven2/com/amazonaws/aws-lambda-java-runtime-interface-client/1.1.0/aws-lambda-java-runtime-interface-client-1.1.0.jar -o layer/aws-lambda-java-runtime-interface-client-1.1.0.jar
curl -4 -L https://repo.maven.apache.org/maven2/com/amazonaws/aws-lambda-java-core/1.2.1/aws-lambda-java-core-1.2.1.jar -o layer/aws-lambda-java-core-1.2.1.jar
curl -4 -L https://repo.maven.apache.org/maven2/com/amazonaws/aws-lambda-java-serialization/1.0.0/aws-lambda-java-serialization-1.0.0.jar -o layer/aws-lambda-java-serialization-1.0.0.jar

chmod 755 bootstrap && zip -r java17layer.zip jre17-slim bootstrap layer/aws-lambda-java-runtime-interface-client-1.1.0.jar layer/aws-lambda-java-core-1.2.1.jar layer/aws-lambda-java-serialization-1.0.0.jar