# Resources used
# https://github.com/epahomov/docker-spark
# https://medium.com/@achilleus/learn-docker-to-get-started-with-spark-dd8468e9de5b

FROM ubuntu

LABEL image=Spark-base-image

#Run the following commands on my Linux machine
#install the below packages on the ubuntu image
# RUN apt-get update -qq 
# RUN apt install default-jdk  -y
# RUN apt install scala -y
# RUN apt install git -y

RUN apt-get update -qq && \
    apt-get install -qq -y gnupg2 wget openjdk-8-jdk scala

WORKDIR /

#Download the Spark 3.1.1 binaries from Apache website, tar it and move to location
RUN wget https://downloads.apache.org/spark/spark-3.1.1/spark-3.1.1-bin-hadoop2.7.tgz 
RUN tar xvf spark-* 
RUN mv spark-3.1.1-bin-hadoop2.7 /usr/local/spark

ENV SPARK_VERSION=3.1.1
ENV HADOOP_VERSION=2.7
ENV SPARK_HOME=//usr/local/spark
ENV PATH=$PATH:/usr/local/spark/bin
# ENV PATH=$PATH:$SPARK_HOME/bin:$SPARK_HOME/sbin
# ENV PYSPARK_PYTHON=/usr/bin/python3

# Untar the downloaded binaries , move them the folder name spark and add the spark bin on my class path
# RUN tar -xzf /spark-2.4.1-bin-hadoop2.7.tgz && \
    # mv spark-2.4.1-bin-hadoop2.7 spark && \
    # echo "export PATH=$PATH:/spark/bin" >> ~/.bashrc
#Expose the UI Port 3000
# EXPOSE 3000

CMD ["spark-shell"]