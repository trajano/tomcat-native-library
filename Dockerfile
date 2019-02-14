FROM openjdk:8-jdk-stretch
ARG TOMCAT_NATIVE_VERSION=1.2.21
RUN apt-get -qq update && apt-get -yqq install libaprutil1-dev make gcc libssl-dev
RUN curl --silent http://apache.forsale.plus/tomcat/tomcat-connectors/native/${TOMCAT_NATIVE_VERSION}/source/tomcat-native-${TOMCAT_NATIVE_VERSION}-src.tar.gz | tar zxf -
WORKDIR /tomcat-native-${TOMCAT_NATIVE_VERSION}-src/native
RUN ./configure && make
RUN make install
FROM openjdk:8-jdk-stretch
COPY --from=0 /usr/local/apr/lib /usr/lib
COPY sample-app /sample-app
WORKDIR /sample-app
RUN sh ./mvnw -B -q install
RUN apt-get -qq update && apt-get -yqq install libapr1 libssl1.0.2
RUN java -jar target/demo-0.0.1-SNAPSHOT.jar
FROM scratch
COPY --from=0 /usr/local/apr/lib /usr/local/apr/lib
