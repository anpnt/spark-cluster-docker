import pyspark
from pyspark.sql import SparkSession
spark = SparkSession.builder \
                    .appName('ClusterApp001') \
                    .getOrCreate()
rdd=spark.sparkContext.parallelize(range(1,10000))
print(f"Sum of values = {rdd.sum()}")
spark.stop()
