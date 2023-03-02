#### How many partitions a kafka change log has

**1.Q** 

Kafka Streams uses local state stores that are made fault-tolerant by associated changelog topics stored in Kafka. 
What will be the number of partitions for the changelog topic
If there are 5 partitions and 5 instance of the stream application is running.

**1.A**  

There is a changelog topic per state store (related to the stateful processor): 
by default, that changelog topic has as name <aplication.id>-<processor-id>-changelog . 
A changelog topic is co-partitioned with its input topic. In your case, the changelog 
topic will have 5 partitions because the input has 5 partitions (independently of the number of instances).