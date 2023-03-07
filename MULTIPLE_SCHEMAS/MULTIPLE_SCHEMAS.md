### SET UP MULTIPLE SCHEMAS ON A TOPIC

_Note: you will need to install CLI prior to the tutorial._

#### Run the following

        confluent update
        
        confluent logout
        
        confluent login                                                                          
        Enter your Confluent Cloud credentials:
        Email: mstarin+svcs-nemea@confluent.io
        Password: ********
        
        confluent environment list

- create client in control-center UI, save in `configuration/client.config`

- in CLI and TOOLS tab in Confluent control-center UI you will find the environment and cluster details for set up

        confluent environment use env-gwg3m
        
        confluent kafka cluster use lkc-r56jvp
        
        confluent api-key store --resource lkc-r56jvp
        Key: Q44PWGCW6SZET2B3
        Secret: *******************************************
        
        confluent api-key use Q44PWGCW6SZET2B3 --resource lkc-r56jvp

- create some topics

        confluent kafka topic create avro-events
        confluent kafka topic create proto-events


_Just some sample commands (just FYI)_

        confluent kafka topic create test-topic
        confluent kafka topic list
        confluent kafka topic produce test-topic
        confluent kafka topic consume -b test-topic --group YOUR_CONSUMER_GROUP_NAME

#### Build

create the `build.gradle` file

        gradle wrapper

#### Create development config

`configuration/dev.properties`

        max.poll.interval.ms=300000
        enable.auto.commit=true
        auto.offset.reset=earliest
        key.deserializer=org.apache.kafka.common.serialization.StringDeserializer
        key.serializer=org.apache.kafka.common.serialization.StringSerializer
        
        # Application specific properties
        proto.topic.name=proto-events
        proto.topic.partitions=1
        proto.topic.replication.factor=3
        
        avro.topic.name=avro-events
        avro.topic.partitions=1
        avro.topic.replication.factor=3

update the file with client props

        cat configuration/ccloud.properties >> configuration/dev.properties


#### Create schemas

in `proto` and `avro` directories create the schema files

        ./gradlew build

this section in the `build.gradle` defines the schema registration and adds reference: 

    // Possible types are ["JSON", "PROTOBUF", "AVRO"]
    register {
    subject('page-view', 'src/main/avro/page-view.avsc', 'AVRO')
    subject('purchase', 'src/main/avro/purchase.avsc', 'AVRO')
    subject('avro-events-value', 'src/main/avro/all-events.avsc', 'AVRO')
    .addReference("io.confluent.developer.avro.PageView", "page-view", 1)
    .addReference("io.confluent.developer.avro.Purchase", "purchase", 1)
    }

register the schemas:

    ./gradlew registerSchemasTask





































