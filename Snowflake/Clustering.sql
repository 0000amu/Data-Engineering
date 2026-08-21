-- creating non cluster table off cashe memory 
create or replace table avd.test.lineitem_noncluster
as
select * from snowflake_sample_data.tpch_sf1000.lineitem;

create or replace table avd.test.lineitem_cluster
as 
select * from snowflake_sample_data.tpch_sf1000.lineitem; -- 20s load time using 4x l
-- SHUTDOWN cache mem
alter session set use_cached_result = false

select * from avd.test.lineitem_noncluster limit 50;

-- automatically cluster by mail 
select * from avd.test.lineitem_noncluster 
where l_shipmode = 'MAIL' -- 5.6S LOAD TIME 

-- APPLYING CLUSTER 
ALTER TABLE AVD.TEST.LINEITEM_CLUSTER 
CLUSTER BY(L_SHIPMODE) 

-- CHECK CLUSTERING INFORMATION
SELECT SYSTEM$CLUSTERING_INFORMATION ('AVD.TEST.LINEITEM_CLUSTER');

SELECT * FROM AVD.TEST.LINEITEM_CLUSTER 
WHERE L_SHIPMODE = 'MAIL' -- 5.5 S LOAD TIME BAD CLUSTERING METHOD 



