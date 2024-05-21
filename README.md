# spark-cluster-docker

docker network create sparknet

docker run -d --rm --name master \
                --network=sparknet \
                -e SPARK_MODE=master \
                -p 4040:4040 \
                bitnami/spark

docker run -d --rm --name worker1\
             --network=sparknet \
             -e SPARK_MODE=worker \
             -e SPARK_MASTER_URL=spark://e81d79f2d152:7077 \
             bitnami/spark

docker run -d --rm --name worker2\
             --network=sparknet \
             -e SPARK_MODE=worker \
             -e SPARK_MASTER_URL=spark://e81d79f2d152:7077 \
             bitnami/spark

docker cp first_script.py e81d79f2d152:/tmp/

docker exec -it e81d79f2d152 spark-submit \
              --master=spark://e81d79f2d152:7077 \
              /tmp/first_script.py