### Encrypt Client Broker Traffic 

#### Encryption in transit

*Create kafka-client trustore and import the CA*

    keytool -keystore kafka.client.truststore.jks -alias CARoot \
    -importcert -file ca-cert

*`client-ssl.properties`*

    bootstrap.servers=kafka-1-external:9093
    security.protocol=SSL
    ssl.truststore.location=/var/ssl/private/kafka.client.truststore.jks
    ssl.truststore.password=test1234

#### Activity

    kafka-topics \
    --bootstrap-server kafka-1-external:19092 \
    --create \
    --topic test-topic \
    --replica-assignment 101:102:103

- Run tcpdump in the netshoot Docker container to inspect TCP packets on ports 19092 and 19093 of the kafka-1 container.

       docker run --rm -it --net container:kafka-1  \
       nicolaka/netshoot  \
       tcpdump -c 40 -X port 19092 or port 19093   

       kafka-console-producer \
       --bootstrap-server kafka-1-external:19092 \
       --topic test-topic 

       send : PLAINTEXT_record (thisis produced toport 19092)

- create Client store and Import the CA


      sudo keytool -keystore ~/tls/client-creds/kafka.client.truststore.pkcs12 \
      -alias CARoot \
      -import \
      -file ~/tls/ca.crt \
      -storepass confluent  \
      -noprompt \
      -storetype PKCS12

*`client-ssl.properties`*

      security.protocol=SSL
      ssl.truststore.location=client-creds/kafka.client.truststore.pkcs12
      ssl.truststore.password=confluent

      docker run --rm -it --net container:kafka-1  \
      nicolaka/netshoot  \
      tcpdump -c 30 -X port 19092 or port 19093
    
      kafka-console-producer \
      --bootstrap-server kafka-1-external:19093 \
      --topic test-topic \
      --producer.config ~/tls/client-creds/client-ssl.properties
    
    send: SSL_producer (thisis produced to port 19093)


#### Updating listeners

    KAFKA_LISTENERS: PLAINTEXT://0.0.0.0:19092,SSL://0.0.0.0:19093,BROKER://0.0.0.0:9092
    KAFKA_ADVERTISED_LISTENERS: PLAINTEXT://kafka-1-external:19092,SSL://kafka-1-external:19093,BROKER://kafka-1:9092
    #KAFKA_LISTENERS: SSL://0.0.0.0:19093,BROKER://0.0.0.0:9092
    #KAFKA_ADVERTISED_LISTENERS: SSL://kafka-1-external:19093,BROKER://kafka-1:9092
    
    #KAFKA_LISTENERS: PLAINTEXT://0.0.0.0:19092,SSL://0.0.0.0:19093,BROKER://0.0.0.0:9092
    #KAFKA_ADVERTISED_LISTENERS: PLAINTEXT://kafka-1-external:19092,SSL://kafka-1-external:19093,BROKER://kafka-1:9092
    KAFKA_LISTENERS: SSL://0.0.0.0:19093,BROKER://0.0.0.0:9092
    KAFKA_ADVERTISED_LISTENERS: SSL://kafka-1-external:19093,BROKER://kafka-1:9092

_Note:_ now only `kafka-1-external:19093` is available for connection.

















