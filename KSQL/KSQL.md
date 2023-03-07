### KSQL BASICS

#### Non persistent queries

- The result will not be persisted in topic

        select

#### Persistent queries

    create stream as select
    create table as select


#### Pull Query

- look up a value from `materialized table`
- single response returned in HTTP request


    select * from views
    where ROWKEY = 'cool-user'
    and 117185643184 <= WINDOWSTART
    and WINDOWSTART <= 11958345319


#### Push query

    select * from user_table 
    EMIT CHANGES;

