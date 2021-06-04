# Build pyspark image using the following command from the home folder of the spark binaries download
# ./bin/docker-image-tool.sh -p ./kubernetes/dockerfiles/spark/bindings/python/Dockerfile build

# to build spark image simply run 
# ./bin/docker-image-tool.sh build

FROM spark

WORKDIR /opt/spark/

# copy /py files 
COPY to-be-copied/hello.py ./

# necessary to install dependencies using pip and use apt-get install
USER root

RUN apt-get --assume-yes install python3

# Warnings while running .py file (none of them affect performance)
# https://stackoverflow.com/questions/65463877/pyspark-illegal-reflective-access-operation-when-executed-in-terminal
# https://stackoverflow.com/questions/19943766/hadoop-unable-to-load-native-hadoop-library-for-your-platform-warning
# https://stackoverflow.com/questions/33897307/hadoop-log4j-not-working-as-no-appenders-could-be-found-for-logger-org-apache-h
# Unable to remove these warnings as the image is not importing the config folder

CMD ["./bin/spark-submit","hello.py"]