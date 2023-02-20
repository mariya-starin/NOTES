### TUNING



#### PRODUCER

    confluent kafka topic create performance \
    --url http://kafka-1:18082/kafka \
    --partitions 6 \
    --replication-factor 3 \
    --no-auth
    
    kafka-producer-perf-test \
    --topic performance \
    --num-records 1000000 \
    --record-size 100 \
    --throughput 10000000 \
    --producer-props \
    bootstrap.servers=kafka-1:19092,kafka-2:29092 \
    acks=all \
    batch.size=400000 \
    linger.ms=500


| VARIABLES            | THROUGHPUT | LATENCY |
|----------------------|------------|---------|
 | ACK = 1              |            |         |
 | ACK = ALL            |            |         |
 | ACK = 0              |            |         |
 | BATCH.SIZE = 0       |            |         |
| BATCH.SIZE = 1000    |            |         |
| BATCH.SIZE = 100000  |            |         |
| BATCH.SIZE = 1000000 |            |         |
| LINGER.MS = 0        |            |         |
| LINGER.MS = 500      |            |         |
| LINGER.MS = 1000     |            |         |
| LINGER.MS = 3000     |            |         |


// problema swith producer - consumer?
// dead lock on processing?

// testing performance
// consumer idempotance??