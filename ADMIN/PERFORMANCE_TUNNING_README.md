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
    bootstrap.servers=localhost:9092 \
    acks=all \
    batch.size=0 \
    linger.ms=0

    kafka-producer-perf-test \
    --producer.config java.config \
    --throughput 200 \
    --record-size 1000 \
    --num-records 3000 \
    --topic perf-test-topic \
    --producer-props linger.ms=0 batch.size=16384 \
    --print-metrics | grep \
    "3000 records sent\|
    producer-metrics:outgoing-byte-rate\|\
    producer-metrics:bufferpool-wait-ratio\|\
    producer-metrics:record-queue-time-avg\|\
    producer-metrics:request-latency-avg\|\
    producer-metrics:batch-size-avg"


| VARIABLES                                    | THROUGHPUT | LATENCY  |
|----------------------------------------------|------------|----------|
 | ACK = ALL                                    | 39.79      | 217.55   |
 | ACK = 1                                      | 41.90      | 233.78   |
 | ACK = 0                                      | 42.39      | 97.52    |
 | linger.ms=0                                  |            |          |
 | BATCH.SIZE = 100                             | 1.27       | 12309.93 | 
| BATCH.SIZE = 10000                           | 33.56      | 432.75   |
| BATCH.SIZE = 1000000                         | 42.40      | 8.33     |
| batch.size=0                                 |            |          | 
| LINGER.MS = 500                              | 33.06      | 447.93   |
| LINGER.MS = 1000                             | 32.50      | 449.92   |
| LINGER.MS = 3000                             | 33.03      | 459.50   |
 
#### Calculate number of partitions

`t` - expected application throughput (MB/sec)
`p` - producer throughput
`c` - single consumer throughput

`number of partitions = max(t/p, t/c)`


#### CONSUMER

    kafka-consumer-perf-test \
    --bootstrap-server localhost:9092 \
    --topic performance \
    --group cg \
    --messages 10000 \
    --show-detailed-stats \
    --timeout 50000 \
    --reporting-interval 5000

    kafka-consumer-perf-test \
    --bootstrap-server localhost:9092 \
    --topic performance \
    --group cg \
    --messages 10000000 \
    --show-detailed-stats \
    --reporting-interval 5000 \
    --consumer.config consumer.properties