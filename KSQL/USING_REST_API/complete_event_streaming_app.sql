-- Capture Data

CREATE SOURCE CONNECTOR `stockapp.trades` WITH (
    'connector.class' = 'io.confluent.kafka.connect.datagen.DatagenConnector',
    'kafka.topic' = 'ksqldb.stockapp.trades',
    'quickstart' = 'Stock_Trades',
    'max.interval' = 3000,
    'iterations' = 1000,
    'tasks.max' = '1'
);

CREATE SOURCE CONNECTOR `stockapp.users` WITH (
    'connector.class' = 'io.confluent.kafka.connect.datagen.DatagenConnector',
    'kafka.topic' = 'ksqldb.stockapp.users',
    'quickstart' = 'Users_',
    'max.interval' = 3000,
    'iterations' = 1000,
    'tasks.max' = '1'
);

CREATE TABLE stockapp_users (
                                userid STRING PRIMARY KEY,
                                registertime BIGINT,
                                regionid STRING,
                                gender STRING,
                                interests ARRAY<STRING>,
                                contactinfo MAP<STRING, STRING>
) WITH (
      KAFKA_TOPIC = 'ksqldb.stockapp.users',
      VALUE_FORMAT = 'AVRO'
      );

CREATE STREAM stockapp_trades
WITH (
    KAFKA_TOPIC = 'ksqldb.stockapp.trades',
    VALUE_FORMAT = 'AVRO'
);

-- Perform Continuous Transformations

CREATE STREAM stockapp_trades_transformed AS
SELECT
            CAST(price AS DECIMAL(7,2)) * quantity / 100 AS dollar_amount,
            MASK(account, '*', '*', NULL, NULL) AS account_masked,
            symbol,
            userid
FROM stockapp_trades
WHERE symbol LIKE '%T'
    EMIT CHANGES;

CREATE STREAM stockapp_trades_transformed_enriched AS
SELECT s.userid, s.dollar_amount, s.symbol,
       u.regionid, u.interests, u.contactinfo
FROM stockapp_trades_transformed s
         LEFT JOIN stockapp_users u
                   ON s.userid = u.userid
    EMIT CHANGES;

-- Create Continuously Updated Materialized View

CREATE TABLE stockapp_dollars_by_zip_5_min AS
SELECT
    contactinfo['zipcode'] AS zipcode,
    SUM(dollar_amount) AS total_dollars
FROM stockapp_trades_transformed_enriched
         WINDOW TUMBLING (SIZE 5 MINUTES)
    GROUP BY contactinfo['zipcode']
    EMIT CHANGES;

-- Look Up Current Value in the Materialized View

SELECT
    zipcode,
    total_dollars,
    TIMESTAMPTOSTRING(WINDOWSTART, 'yyyy-MM-dd''T''HH:mm:ss.SSS', 'UTC') AS window_start,
    TIMESTAMPTOSTRING(WINDOWEND, 'yyyy-MM-dd''T''HH:mm:ss.SSS', 'UTC') AS window_end
FROM STOCKAPP_DOLLARS_BY_ZIP_5_MIN
WHERE zipcode IN ('94403', '92617', '94301', '95112', '94070')
  AND WINDOWSTART >= '2021-01-23T00:00:00.000'
  AND WINDOWEND <= '2021-01-23T00:10:00.000';