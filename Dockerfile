# Resources used
# https://github.com/epahomov/docker-spark
# https://medium.com/@achilleus/learn-docker-to-get-started-with-spark-dd8468e9de5b
# https://www.stefaanlippens.net/spark-native-hadoop.html
# https://stackoverflow.com/questions/35639159/running-apache-spark-log4jwarn-please-initialize-the-log4j-system-properly

FROM ubuntu

LABEL image=Spark-base-image

ENV SPARK_VERSION=3.1.1
ENV HADOOP_VERSION=3.2
ENV SPARK_HOME=/opt/spark
ENV PATH=$PATH:$SPARK_HOME/bin:$SPARK_HOME/sbin
ENV PYSPARK_PYTHON=/usr/bin/python3

# place everything to be copied in the to-be-copied folder
# copy required files
COPY to-be-copied /copied

WORKDIR /

#install the below packages on the ubuntu image
RUN apt-get update -qq
# use java 8 instead of 11 as java 11 gives illegal usage warnings
# https://stackoverflow.com/questions/65463877/pyspark-illegal-reflective-access-operation-when-executed-in-terminal
RUN apt-get install -y openjdk-8-jdk
RUN apt-get install -y python3 
RUN apt-get install -y scala 
RUN apt-get install -y wget

#Download the Spark 3.1.1 binaries from Apache website, tar it and move to location
RUN wget https://downloads.apache.org/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz 
# COPY spark-3.1.1-bin-hadoop3.2.tgz /
RUN tar xvf spark-* 
RUN mv spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION} /opt/spark
RUN rm spark-3.1.1-bin-hadoop3.2.tgz

# install Hadoop binaries
# COPY hadoop-3.2.2.tar.gz /
RUN wget https://apachemirror.wuchna.com/hadoop/common/hadoop-3.2.2/hadoop-3.2.2-src.tar.gz
RUN tar -xvf hadoop-3.2.2.tar.gz -C /opt/
ENV HADOOP_HOME=/opt/hadoop-3.2.2/
RUN rm hadoop-3.2.2.tar.gz

#spark-env.sh
RUN echo "export HADOOP_HOME=/opt/hadoop-3.2.2" >> /opt/spark/conf/spark-env.sh
RUN echo "export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HADOOP_HOME/lib/native" >> /opt/spark/conf/spark-env.sh

#log4j.properties
RUN echo "   hadoop.root.logger= DEBUG, console" >> /opt/spark/conf/log4j.properties
RUN echo "log4j.appender.console=org.apache.log4j.ConsoleAppender" >> /opt/spark/conf/log4j.properties
RUN echo "log4j.appender.console.target=System.out" >> /opt/spark/conf/log4j.properties
RUN echo "log4j.appender.console.layout=org.apache.log4j.PatternLayout" >> /opt/spark/conf/log4j.properties
RUN echo "log4j.appender.console.layout.ConversionPattern=%d{yy/MM/dd HH:mm:ss} %p %c{2}: %m%n \n" >> /opt/spark/conf/log4j.properties

# install python dependencies
RUN apt-get install python3-pip
RUN pip3 freeze > requirements.txt
RUN pip3 install -r requirements.txt

# spark master port
EXPOSE 8080

CMD ["spark-submit","copied/hello.py"]
# CMD ["pyspark <","copied/hello.py"]