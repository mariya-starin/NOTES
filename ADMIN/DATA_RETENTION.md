### Data Retention Options

#### Age based

    log.cleanup.policy=delete
    retention.ms=604800000 (7 days)

![DELETE_POLICY_CONFIG](../images/delete_policy_config_age.png)

#### Size based

    log.cleanup.policy=delete
    retention.bytes=536870912
    segment.bytes=268435456

![DELETE_POLICY_CONFIG](../images/delete_policy_config_size.png)

#### Key based

    log.cleanup.policy=compact

![DELETE_POLICY_CONFIG](../images/delete_policy_config_key.png)
