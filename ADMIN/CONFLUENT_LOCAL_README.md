
![LOCAL](../images/confluent_local.png)

    confluent local services start

** this will output a number `/tmp/confluent.<number>`

    confluent local destroy
    sudo rm -rf /tmp/*

    confluent local services status
    confluent local services kafka log -f
    

_CREATE SCHEMA_

    cat <<EOF > ~/temperature_reading.avsc
    {
    "namespace": "io.confluent.examples",
    "type": "record",
    "name": "temperature_reading",
    "fields": [
    {"name": "city", "type": "string"},
    {"name": "temp", "type": "int", "doc": "temperature in Fahrenheit"} ]
    }
    EOF

_CONSUME_

    confluent local services \
    kafka consume temperatures \
    --property print.key=true \
    --property key.deserializer=org.apache.kafka.common.serialization.StringDeserializer \
    --value-format avro

_PRODUCE_

    confluent local services \
    kafka produce temperatures \
    --property parse.key=true --property key.separator=, \
    --property key.serializer=org.apache.kafka.common.serialization.StringSerializer \
    --value-format avro \
    --property value.schema.file=$HOME/temperature_reading.avsc