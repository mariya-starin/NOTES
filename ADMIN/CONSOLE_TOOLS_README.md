### DOCS

   [ALL TOOLS](https://docs.confluent.io/platform/current/installation/cli-reference.html#cli-tools-for-cp)

### CONSOLE CONSUMERS

** it's a good practice to set `export LOG_DIR=/tmp` instead of the default `/usr/logs`

    kafka-avro-console-consumer \
    --bootstrap-server localhost:9092 \
    --topic temperatures  \
    --property print.key=true \
    --property key.deserializer=org.apache.kafka.common.serialization.StringDeserializer


### CONSOLE PRODUCERS

        kafka-avro-console-producer \
        --bootstrap-server localhost:9092 \
        --topic temperatures \
        --property key.serializer=org.apache.kafka.common.serialization.StringSerializer \
        --property parse.key=true --property key.separator=, \
        --property value.schema.file=$HOME/temperature_reading.avsc


        kafka-producer-perf-test \
        --producer-props bootstrap.servers=localhost:9092 \
        --topic perf-test \
        --num-records 1000 \
        --throughput -1 \
        --record-size 500000
        
        kafka-producer-perf-test \
        --producer-props \
        bootstrap.servers=localhost:9092 \
        client.id=perf-test-producer \
        --topic perf-test \
        --num-records 100 \
        --throughput -1 \
        --record-size 500000


### KAFKA-CONFIGS

  [CHANGING BROKER CONFIG](https://docs.confluent.io/platform/current/kafka/dynamic-config.html#kafka-dyn-broker-config)
  [MODIFYING TOPICS](https://docs.confluent.io/platform/current/kafka/dynamic-config.html#kafka-dyn-broker-config)

        kafka-configs --bootstrap-server localhost:9092 \
        --alter \
        --add-config 'producer_byte_rate=1000000' \
        --entity-type clients \
        --entity-name perf-test-producer
        
        kafka-configs --bootstrap-server localhost:9092 \
        --entity-type broker-loggers \
        --entity-name 0 \
        --alter --add-config \
        kafka.request.logger=DEBUG
        
        kafka-configs --bootstrap-server localhost:9092 \
        --entity-type broker-loggers  \
        --describe --entity-name 0 \
        | grep DEBUG
        
        kafka-configs --bootstrap-server localhost:9092 \
        --entity-type broker-loggers  \
        --describe --entity-name 0

        kafka-configs --bootstrap-server kafka-1:19092 \
        --alter \
        --topic test \
        --add-config max.message.bytes=10000100



#### Broker level

        kafka-configs \
        --bootstrap-server kafka-1:19092 \
        --entity-type brokers \
        --entity-default \
        --describe
        
        kafka-configs \
        --bootstrap-server kafka-1:19092 \
        --entity-type brokers \
        --entity-name 101 \
        --describe
        
        kafka-configs \
        --bootstrap-server kafka-1:19092 \
        --entity-type brokers \
        --entity-name 101 \
        --alter \
        --delete-config 'log.cleaner.threads'

#### Cluster level
        
        kafka-configs \
        --bootstrap-server kafka-1:19092 \
        --entity-type brokers \
        --entity-default \
        --alter \
        --add-config 'log.cleaner.threads=2'
        
        kafka-configs \
        --bootstrap-server kafka-1:19092 \
        --entity-type brokers \
        --entity-default \
        --describe
        
        kafka-configs \
        --bootstrap-server kafka-1:19092 \
        --entity-type brokers \
        --entity-default \
        --alter \
        --delete-config 'log.cleaner.threads'


### CONFLUENT-HUB

        sudo confluent-hub install confluentinc/kafka-connect-datagen:0.5.3
        
        sudo systemctl start confluent-schema-registry
        
        sudo systemctl start confluent-kafka-connect
        
        curl localhost:8083
        
        curl -X POST \
        -H "Content-Type: application/json" \
        --data '{
        "name": "datagen-pageviews-avro",
        "config": {
        "connector.class": "io.confluent.kafka.connect.datagen.DatagenConnector",
        "kafka.topic": "pageviews-avro",
        "quickstart": "pageviews",
        "key.converter": "org.apache.kafka.connect.storage.StringConverter",
        "value.converter": "io.confluent.connect.avro.AvroConverter",
        "value.converter.schema.registry.url": "http://localhost:8081",
        "max.interval": 100,
        "iterations": 10000000,
        "tasks.max": "1"
        }
        }' http://localhost:8083/connectors

        kafka-avro-console-consumer \
        --bootstrap-server localhost:9092 \
        --topic pageviews-avro \
        --property print.key=true \
        --key-deserializer=org.apache.kafka.common.serialization.StringDeserializer \
        --from-beginning


### KAFKA-DUMP-LOG

        cat /etc/kafka/server.properties | grep log.dirs
        
        sudo --shell
        
        ls /var/lib/kafka
        
        ls /var/lib/kafka/pageviews-avro-0/
        
        kafka-dump-log \
        --print-data-log \
        --files /var/lib/kafka/pageviews-avro-0/00000000000000000000.log

### KAFKA-CONSUMER-GROUPS

  [CONSUMER GROUPS DOCS](https://docs.confluent.io/platform/current/clients/consumer.html#list-groups)

    bin/kafka-consumer-groups --bootstrap-server host:9092 --list

    bin/kafka-consumer-groups --bootstrap-server host:9092 --describe --group foo

    kafka-consumer-groups \
    --bootstrap-server kafka-1:9092 \
    --group my-group \
    --topic my_topic \
    --reset-offsets \
    --execute \
    --to-datetime 2021-06-01T17:14:23.933

### KAFKA ACLS - Authorization

  [ACLS DOCS](https://docs.confluent.io/platform/current/kafka/authorization.html#authorization-using-acls)






