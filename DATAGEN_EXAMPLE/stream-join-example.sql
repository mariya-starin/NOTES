CREATE TABLE users
(
    name       VARCHAR PRIMARY KEY,
    email      VARCHAR,
    status     VARCHAR,
    user_added VARCHAR
) WITH (
      KAFKA_TOPIC = 'ksqldb.users',
      PARTITIONS = 4,
      VALUE_FORMAT = 'DELIMITED',
      TIMESTAMP = 'user_added',
      TIMESTAMP_FORMAT = 'yyyy-MM-dd''T''HH:mm:ssX'
      );



insert into users (name, email, status, user_added)
values ('Hall', 'hchaters0@cmu.edu', null, '2023-02-21T14:49:09Z');
insert into users (name, email, status, user_added)
values ('Verge', 'vpicken1@nationalgeographic.com', 'gold', '2023-02-21T14:49:09Z');
insert into users (name, email, status, user_added)
values ('Alex', 'alaurentin2@yandex.ru', 'silver', '2023-02-21T14:49:09Z');
insert into users (name, email, status, user_added)
values ('Cathy', 'cdumbreck3@adobe.com', 'platinum', '2023-02-21T14:49:09Z');
insert into users (name, email, status, user_added)
values ('Ruth', 'rfrankcombe4@theguardian.com', 'silver', '2023-02-21T14:49:09Z');
insert into users (name, email, status, user_added)
values ('Ferne', 'fduiged5@buzzfeed.com', 'silver', '2023-02-21T14:49:09Z');
insert into users (name, email, status, user_added)
values ('Joyann', 'jrigg6@youtu.be', null, '2023-02-21T14:49:09Z');
insert into users (name, email, status, user_added)
values ('Ardene', 'aannear7@icio.us', 'gold', '2023-02-21T14:49:09Z');
insert into users (name, email, status, user_added)
values ('Melvin', 'mdumbar8@cafepress.com', 'silver', '2023-02-21T14:49:09Z');
insert into users (name, email, status, user_added)
values ('Maridel', 'mnasey9@netlog.com', 'silver', '2023-02-21T14:49:09Z');
insert into users (name, email, status, user_added)
values ('Mervin', 'mbaskervillea@alibaba.com', 'silver', '2023-02-21T14:49:09Z');
insert into users (name, email, status, user_added)
values ('Redd', 'rjoddensb@un.org', null, '2023-02-21T14:49:09Z');
insert into users (name, email, status, user_added)
values ('Murial', 'mbokenc@csmonitor.com', 'silver', '2023-02-21T14:49:09Z');
insert into users (name, email, status, user_added)
values ('Jay', 'jpalserd@nasa.gov', 'silver', '2023-02-21T14:49:09Z');
insert into users (name, email, status, user_added)
values ('Sig', 'sgoodlade@mediafire.com', 'silver', '2023-02-21T14:49:09Z');
insert into users (name, email, status, user_added)
values ('Nicoline', 'nhassardf@squarespace.com', 'silver', '2023-02-21T14:49:09Z');
insert into users (name, email, status, user_added)
values ('Cleavland', 'cstachinig@seesaa.net', 'silver', '2023-02-21T14:49:09Z');

CREATE
STREAM payments (
    name VARCHAR KEY,
    payment_id BIGINT,
    amount VARCHAR,
    payment_timestamp VARCHAR
    ) WITH (
    KAFKA_TOPIC = 'ksqldb.payments',
    PARTITIONS = 4,
    VALUE_FORMAT = 'DELIMITED',
    TIMESTAMP='payment_timestamp',
    TIMESTAMP_FORMAT = 'yyyy-MM-dd''T''HH:mm:ssX'
    );

insert into payments (name, payment_id, amount, payment_timestamp)
values ('Alex', 1, '$41.25', '2023-02-05T04:14:00Z');
insert into payments (name, payment_id, amount, payment_timestamp)
values ('Verge', 2, '$59.83', '2023-02-21T14:49:09Z');
insert into payments (name, payment_id, amount, payment_timestamp)
values ('Verge', 3, '$76.31', '2023-02-05T16:27:51Z');
insert into payments (name, payment_id, amount, payment_timestamp)
values ('Hall', 4, '$8.28', '2023-02-05T12:21:16Z');
insert into payments (name, payment_id, amount, payment_timestamp)
values ('Hall', 5, '$58.53', '2023-02-25T11:26:54Z');
insert into payments (name, payment_id, amount, payment_timestamp)
values ('Cathy', 6, '$68.69', '2023-02-26T17:13:07Z');
insert into payments (name, payment_id, amount, payment_timestamp)
values ('Hall', 7, '$82.37', '2023-02-29T10:25:34Z');
insert into payments (name, payment_id, amount, payment_timestamp)
values ('Cathy', 8, '$12.23', '2023-02-13T02:34:14Z');
insert into payments (name, payment_id, amount, payment_timestamp)
values ('Verge', 9, '$67.47', '2023-02-28T22:18:13Z');
insert into payments (name, payment_id, amount, payment_timestamp)
values ('Cathy', 10, '$95.84', '2023-02-05T20:16:30Z');
insert into payments (name, payment_id, amount, payment_timestamp)
values ('Cathy', 11, '$42.42', '2023-02-27T08:31:46Z');
insert into payments (name, payment_id, amount, payment_timestamp)
values ('Cathy', 12, '$52.98', '2023-02-02T20:18:34Z');
insert into payments (name, payment_id, amount, payment_timestamp)
values ('Alex', 13, '$74.58', '2023-02-23T08:20:18Z');
insert into payments (name, payment_id, amount, payment_timestamp)
values ('Hall', 14, '$14.85', '2023-02-27T20:52:56Z');
insert into payments (name, payment_id, amount, payment_timestamp)
values ('Alex', 15, '$20.21', '2023-02-02T14:41:22Z');
insert into payments (name, payment_id, amount, payment_timestamp)
values ('Hall', 16, '$21.98', '2023-02-01T15:42:19Z');
insert into payments (name, payment_id, amount, payment_timestamp)
values ('Verge', 17, '$30.38', '2023-02-23T21:56:11Z');
insert into payments (name, payment_id, amount, payment_timestamp)
values ('Cathy', 18, '$69.63', '2023-02-05T22:25:43Z');
insert into payments (name, payment_id, amount, payment_timestamp)
values ('Alex', 19, '$69.97', '2023-02-23T14:52:02Z');
insert into payments (name, payment_id, amount, payment_timestamp)
values ('Cathy', 20, '$92.86', '2023-02-13T22:10:34Z');

SELECT p.name, p.amount, u.status
FROM payments p
         LEFT JOIN users u
                   ON p.name = u.name
WHERE u.status = 'platinum' EMIT CHANGES;