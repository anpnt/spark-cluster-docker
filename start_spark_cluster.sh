#!/bin/bash

# Create the sparknet network
docker network create sparknet

# Run the master container
docker run -d --rm --name master \
    --network=sparknet \
    -e SPARK_MODE=master \
    -p 4040:4040 \
    bitnami/spark

master_id=$(docker ps -aqf "name=master")

# Run worker1 container
docker run -d --rm --name worker1 \
    --network=sparknet \
    -e SPARK_MODE=worker \
    -e SPARK_MASTER_URL=spark://$master_id:7077 \
    bitnami/spark

# Run worker2 container
docker run -d --rm --name worker2 \
    --network=sparknet \
    -e SPARK_MODE=worker \
    -e SPARK_MASTER_URL=spark://$master_id:7077 \
    bitnami/spark

# Copy your Python script to the master container
docker cp first_script.py $master_id:/tmp/

# Submit your Spark job
docker exec -it $master_id spark-submit \
  --master=spark://$master_id:7077 \
  /tmp/first_script.py    
