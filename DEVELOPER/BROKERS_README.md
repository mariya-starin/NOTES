## BROKERS

#### MESSAGE SIZES

**broker**

    message.max.bytes=1000012 (cluster default)

**topic**

    topic=max.messages.bytes=1000012


### RETENTION POLICIES

cleanup.policy:

- delete
- compact
- delete, compact

#### DELETE RETENTION POLICY

We do not delete messages, we delete segments

Two cases for deleting segment:
- retention.ms - segment too old, when newest message in segment is older than retention time
  default = 7 days
- retention.bytes - partition get too large
  default = -1 (unlimited)


#### COMPACT RETENTION POLICY

Keep only the latest value per key

- Dirty segment = not compacted
- Clean segment = compacted

After compaction the message will have it latest offset


#### ACTIVE AND INACTIVE SEGMENTS

**can be configured on topic and broker level

    roll.ms = how long you fill a segment, so if its 7 days, then after 7 days we will open a new segment
    retention.ms = how long we keep the messages, if the longest message in segment is older than retention time, then we delete the segment
    retention.byte = size of partition set, when the size goes beyond this, the oldest records are deleted


Messages are written to active segments

- Active segments roll to be inactive
- Consumers read from all segments
- Retention policies do not alter active segments
- Segments have 2 indexes - offset to position, timestamp to offset

#### RACK AWARE REPLICA SELECTOR

** setting broker rack will make sure the brokers will try to spread replicas across as many racks as possible

_BROKER_

    broker.rack=us-east-1a (leader)
    
    broker.rack=us-east-1b (follower)
 
    broker.rack=us-east-1c (follower)
    
    In all broker props - configure the plugin:
    
    replica.selector.class=org.apache.kafka.common.replica.RackAwareReplicaSelector
    ** default is LeaderSelector class

_CLIENT_

    client.rack=us-east-1b  (consumers will read from here)


### CONTROLLER

- Controller is one of the brokers
- Every broker send heart beat to zookeeper approx 6 sec
- Controller provides zookeeper and brokers with information about ISRs
- Main job of controller is leader election
- When discussing the leader election - we actually talk about `leaderS` elections - which means leader election for all partitions that had their leader on the broker that died


### ZOOKEEPER

- You need at least 2 zookeeper nodes for cluster to be stable, and hence we recommend at least 3 nodes for zookeeper cluster:

- /var/lib/kafka/data/replication-offset-checkpoint - like an offset high water mark of the last committed, replicated message

- Each partition has leader-epoch file - indicating where the leadership has changed.
