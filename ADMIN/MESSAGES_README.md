### ORDER

#### PRESERVE MESSAGE SEND ORDER

    max.in.flight.requests.per.connection = 5
    retries > 0 
    enable.idempotence = true (this requires ack=all, otherwise throws CoonfigException)

#### PREVENT DUPLICATE MESSAGES

    acks = all
    retries > 0
    enable.idempotance = true

### MESSAGE SIZE

*TO CHANGE DEFAULT MESSAGE SIZE* 

Confluent Cloud max *MB for basic and 20MB for dedicated cluster

  - producer

        max.request.size

  - broker

        message.max.bytes (cluster default)

  - topic

        max.message.bytes

#### COMPRESSION

        compression.type

