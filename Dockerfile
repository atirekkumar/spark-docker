# Build pyspark image using the following command from the home folder of the spark binaries download
# /bin/docker-image-tool.sh -p ./kubernetes/dockerfiles/spark/bindings/python/Dockerfile build

FROM spark-py

# COPY . .
COPY to-be-copied/hello.py /opt/spark/

WORKDIR /opt/spark/
CMD ["./bin/spark-submit","hello.py"]