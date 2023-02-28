
INSERT INTO ORDERS (id, order_ts, total_amount, customer_name) VALUES (1, '2023-02-19T06:01:18Z', 133548.84, 'Ricardo Ferreira');
INSERT INTO ORDERS (id, order_ts, total_amount, customer_name) VALUES (2, '2023-02-19T17:02:20Z', 164839.31, 'Tim Berglund');
INSERT INTO ORDERS (id, order_ts, total_amount, customer_name) VALUES (3, '2023-02-19T13:44:10Z', 90427.66, 'Robin Moffatt');
INSERT INTO ORDERS (id, order_ts, total_amount, customer_name) VALUES (4, '2023-02-19T11:58:25Z', 33462.11, 'Viktor Gamov');

INSERT INTO shipments (id, ship_ts, order_id, warehouse) VALUES ('ship-ch83360', '2023-02-22T18:13:39Z', 1, 'UPS');
INSERT INTO shipments (id, ship_ts, order_id, warehouse) VALUES ('ship-xf72808', '2023-02-22T02:04:13Z', 2, 'UPS');
INSERT INTO shipments (id, ship_ts, order_id, warehouse) VALUES ('ship-kr47454', '2023-02-22T20:47:09Z', 3, 'DHL');

kafka-console-producer --broker-list pkc-l6wr6.europe-west2.gcp.confluent.cloud:9092 --producer.config producer.config --topic _orders --property "parse.key=true" --property "key.separator=:" < /Users/mstarin/PROJECTS/NOTES/KSQL/USING_REST_API/orders_input.txt
