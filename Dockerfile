# se dijo que se usaba Linux
FROM ubuntu:20.04

WORKDIR /spark

# Java necesario para Spark
# wget para descargar la versión deseada de Spark
# Python2.7 para usar PySpark dado que 1.5.2 es del 2015
# curl para descargar pip2.7
RUN apt-get update && apt-get install -y \
    openjdk-8-jdk wget python2.7 curl

RUN curl https://bootstrap.pypa.io/pip/2.7/get-pip.py -o get-pip.py && python2.7 get-pip.py && rm get-pip.py

RUN wget https://archive.apache.org/dist/spark/spark-1.5.2/spark-1.5.2-bin-hadoop2.6.tgz && \
    tar -zvxf spark-1.5.2-bin-hadoop2.6.tgz && \
    rm spark-1.5.2-bin-hadoop2.6.tgz

# definir las variables de ambiente
# necesarias para que Spark funcione
# correctamente
ENV SPARK_HOME /spark/spark-1.5.2-bin-hadoop2.6
ENV PATH="${PATH}:${SPARK_HOME}/bin/"
ENV PYSPARK_PYTHON /usr/bin/python2.7

# irnos a este directorio
WORKDIR /app/movies

# copiar el programa word count
COPY word_count.py ./word_count.py

# mandar el 'job' de Spark para que se ejecute en el cluster
# ENTRYPOINT [ "spark-submit", "--master", "local[*]", "word_count.py" ]