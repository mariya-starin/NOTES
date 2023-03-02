#! /bin/bash

curl -s -X POST -H 'Content-Type: application/json' -d '{"name":"my-connector-name","config":{"connector.class":"io.confluent.kafka.connect.datagen.DatagenConnector","kafka.topic":"users-test","iterations":"500","schema.string":"{\"connect.name\":\"ksql.users\",\"fields\":[{\"name\":\"registertime\",\"type\":\"long\"},{\"name\":\"userid\",\"type\":\"string\"},{\"name\":\"regionid\",\"type\":\"string\"},{\"name\":\"gender\",\"type\":\"string\"}],\"name\":\"users\",\"namespace\":\"ksql\",\"type\":\"record\"}"}}}' http://localhost:8083/connectors | jq .

sleep 180

echo "ran the connector"

kafka-console-producer \
        --bootstrap-server localhost:9092 \
        --topic connect-offsets \
        --property parse.key=true \
        --property key.separator='&' \
        < test-message.txt

echo "counter updated"

curl localhost:8083/connectors/ | jq

curl -X DELETE localhost:8083/connectors/my-connector-name/

echo "deleted connector"
