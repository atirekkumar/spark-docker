# Resources used
# https://github.com/epahomov/docker-spark
# https://medium.com/@achilleus/learn-docker-to-get-started-with-spark-dd8468e9de5b

FROM ubuntu

LABEL image=Spark-base-image

#install the below packages on the ubuntu image
RUN apt-get update -qq && \
    apt-get install -qq -y wget openjdk-8-jdk scala
    # apt-get install -qq -y gnupg2 wget openjdk-8-jdk scala

WORKDIR /

#Download the Spark 3.1.1 binaries from Apache website, tar it and move to location
RUN wget https://downloads.apache.org/spark/spark-3.1.1/spark-3.1.1-bin-hadoop2.7.tgz 
RUN tar xvf spark-* 
RUN mv spark-3.1.1-bin-hadoop2.7 /usr/local/spark

ENV SPARK_VERSION=3.1.1
ENV HADOOP_VERSION=2.7
ENV SPARK_HOME=//usr/local/spark
ENV PATH=$PATH:/usr/local/spark/bin
# ENV PYSPARK_PYTHON=/usr/bin/python3

# place everything to be copied in the to-be-copied folder
# copy required files
COPY to-be-copied /copied

# CMD ["spark-shell"]