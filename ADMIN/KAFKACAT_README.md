### KAFKACAT

    kafkacat -b kafka-1:19092 -t locations

*single message*

    kafkacat -b kafka-1:19092 -t locations -C -c1

*with key*

    kafkacat -b kafka-1:19092 -t locations -C -c1 -K ,

*format*

    kafkacat -b kafka-1:19092 -t locations -C -c1 -f 'Key: %k\nValue: %s\n'
    
    kafkacat -b kafka-1:19092 -t locations -C -c2 -f '\nKey (%K bytes): %k\t\nValue (%S bytes): %s\nTimestamp: %T\tPartition: %p\tOffset: %o\n--\n'


#### PRODUCER CONSUMER MODE

    kafkacat -b kafka-1:19092 -t locations -P
    
    kafkacat -b kafka-1:19092 -t locations -C
    
    kafkacat -b kafka-1:19092 -t locations -T -P -K , -l key-messages.txt
    
    kafkacat -b kafka-1:19092 -t locations -P -K , -p 1
    
    kafkacat -b kafka-1:19092 -t locations -C -f '\nKey (%K bytes): %k\t\nValue (%S bytes): %s\nTimestamp: %T\tPartition: %p\tOffset: %o\n--\n'

#### METADATA LISTING

    kafkacat -b kafka-1:19092 -L
    
    kafkacat -b kafka-1:19092 -L -J
