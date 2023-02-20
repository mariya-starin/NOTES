### DEDUPLICATION

#### CREATE INPUT TOPIC

    CREATE STREAM CLICKS (IP_ADDRESS VARCHAR, URL VARCHAR, TIMESTAMP VARCHAR)
    WITH (KAFKA_TOPIC = 'CLICKS',
    FORMAT = 'JSON',
    TIMESTAMP = 'TIMESTAMP',
    TIMESTAMP_FORMAT = 'yyyy-MM-dd''T''HH:mm:ssXXX',
    PARTITIONS = 1);

#### SEND DATA - note IPs and Timestamps

    INSERT INTO CLICKS (IP_ADDRESS, URL, TIMESTAMP) VALUES ('10.0.0.1', 'https://docs.confluent.io/current/tutorials/examples/kubernetes/gke-base/docs/index.html', '2023-02-17T14:50:43+00:00');
    INSERT INTO CLICKS (IP_ADDRESS, URL, TIMESTAMP) VALUES ('10.0.0.12', 'https://www.confluent.io/hub/confluentinc/kafka-connect-datagen', '2023-02-17T14:53:44+00:01');
    INSERT INTO CLICKS (IP_ADDRESS, URL, TIMESTAMP) VALUES ('10.0.0.13', 'https://www.confluent.io/hub/confluentinc/kafka-connect-datagen', '2023-02-17T14:56:45+00:03');
    
  
    INSERT INTO CLICKS (IP_ADDRESS, URL, TIMESTAMP) VALUES ('10.0.0.1', 'https://docs.confluent.io/current/tutorials/examples/kubernetes/gke-base/docs/index.html', '2023-02-17T16:50:43+00:00');
    INSERT INTO CLICKS (IP_ADDRESS, URL, TIMESTAMP) VALUES ('10.0.0.12', 'https://www.confluent.io/hub/confluentinc/kafka-connect-datagen', '2023-02-17T16:53:44+00:01');
    INSERT INTO CLICKS (IP_ADDRESS, URL, TIMESTAMP) VALUES ('10.0.0.13', 'https://www.confluent.io/hub/confluentinc/kafka-connect-datagen', '2023-02-17T16:56:45+00:03');

   
    INSERT INTO CLICKS (IP_ADDRESS, URL, TIMESTAMP) VALUES ('10.0.0.5', 'https://docs.confluent.io/current/tutorials/examples/kubernetes/gke-base/docs/index.html', '2023-02-17T15:50:43+00:00');
    INSERT INTO CLICKS (IP_ADDRESS, URL, TIMESTAMP) VALUES ('10.0.0.17', 'https://www.confluent.io/hub/confluentinc/kafka-connect-datagen', '2023-02-17T15:53:44+00:01');
    INSERT INTO CLICKS (IP_ADDRESS, URL, TIMESTAMP) VALUES ('10.0.0.18', 'https://www.confluent.io/hub/confluentinc/kafka-connect-datagen', '2023-02-17T15:56:45+00:03');


    INSERT INTO CLICKS (IP_ADDRESS, URL, TIMESTAMP) VALUES ('10.0.0.3', 'https://docs.confluent.io/current/tutorials/examples/kubernetes/gke-base/docs/index.html', '2023-02-17T16:50:43+00:00');
    INSERT INTO CLICKS (IP_ADDRESS, URL, TIMESTAMP) VALUES ('10.0.0.16', 'https://www.confluent.io/hub/confluentinc/kafka-connect-datagen', '2023-02-17T16:53:44+00:01');
    INSERT INTO CLICKS (IP_ADDRESS, URL, TIMESTAMP) VALUES ('10.0.0.19', 'https://www.confluent.io/hub/confluentinc/kafka-connect-datagen', '2023-02-17T16:56:45+00:03');

#### CREATE TABLE FOR DEDUP

    SET 'auto.offset.reset' = 'earliest';
    SET 'cache.max.bytes.buffering' = '0';
    
    CREATE TABLE DETECTED_CLICKS AS
    SELECT
    IP_ADDRESS AS KEY1,
    URL AS KEY2,
    TIMESTAMP AS KEY3,
    AS_VALUE(IP_ADDRESS) AS IP_ADDRESS,
    COUNT(IP_ADDRESS) as IP_COUNT,
    AS_VALUE(URL) AS URL,
    AS_VALUE(TIMESTAMP) AS TIMESTAMP
    FROM CLICKS WINDOW TUMBLING (SIZE 2 MINUTES, RETENTION 1000 DAYS)
    GROUP BY IP_ADDRESS, URL, TIMESTAMP; 

#### CREATE STREAM 

_Note: the topic name was created by ksql when creating the table above._

    CREATE STREAM RAW_VALUES_CLICKS (IP_ADDRESS VARCHAR, IP_COUNT BIGINT, URL VARCHAR, TIMESTAMP VARCHAR)
    WITH (KAFKA_TOPIC = 'pksqlc-d5zo7DETECTED_CLICKS',
    PARTITIONS = 1,
    FORMAT = 'JSON');

#### GET DISTINCT 

    CREATE STREAM DISTINCT_CLICKS AS
    SELECT
    IP_ADDRESS,
    URL,
    TIMESTAMP
    FROM RAW_VALUES_CLICKS
    WHERE IP_COUNT = 1
    PARTITION BY IP_ADDRESS;



