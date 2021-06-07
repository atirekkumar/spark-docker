# Build pyspark image using the following command from the home folder of the spark binaries download
# ./bin/docker-image-tool.sh -p ./kubernetes/dockerfiles/spark/bindings/python/Dockerfile build

# to build spark image simply run 
# ./bin/docker-image-tool.sh build

# to run in interactive mode
# docker run -it <image-name> /bin/sh

FROM spark

WORKDIR /opt/spark/

# copy /py files 
COPY to-be-copied/ ./

# necessary to install dependencies using pip and use apt-get install
USER root

RUN apt-get --assume-yes install python3

# unchecked dependency issue related to pycairo exists in the base image.
# To resolve them, run the following commands:
# Source: https://github.com/3b1b/manim/issues/751
RUN apt-get --assume-yes install pkg-config
RUN apt-get --assume-yes install libcairo2-dev

# Warnings while running .py file (none of them affect performance)
# https://stackoverflow.com/questions/65463877/pyspark-illegal-reflective-access-operation-when-executed-in-terminal
# https://stackoverflow.com/questions/19943766/hadoop-unable-to-load-native-hadoop-library-for-your-platform-warning
# https://stackoverflow.com/questions/33897307/hadoop-log4j-not-working-as-no-appenders-could-be-found-for-logger-org-apache-h
# Unable to remove these warnings as the image is not importing the config folder

# To run .py file
# CMD ["./bin/spark-submit","hello.py"]

# To run .jar file
# The class should be specified in the manifest file(myfile.mf) or specified using the --class flag
# Writing a jar file: https://www.javatpoint.com/how-to-make-an-executable-jar-file-in-java
CMD ["./bin/spark-submit","myjar.jar"]