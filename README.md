tomcat native pre-compiled
==========================

This is a multistage build that builds the tcnative library with the specified version to handle the warning

> An incompatible version [1.2.12] of the APR based Apache Tomcat Native library is installed, while Tomcat requires version [1.2.14]

To use this,  the `libapr1` and `libssl1.0.2` is installed and copy the files from `/usr/local/apr/lib` to `/usr/lib`

    FROM trajano/tomcat-native-library as lib

    FROM ...

    COPY --from=lib /usr/local/apr/lib /usr/lib
    RUN apt-get -qq update && apt-get -yqq install libapr1 libssl1.0.2 && rm -rf /var/lib/apt/lists/*
