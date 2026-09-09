from snowflake.snowpark import Session

conn_parameters = {
    "account": "EVFUUFU-KN22973",
    "user": "AMMU",
    "password": "**********",
    "role": "ACCOUNTADMIN",
    "warehouse": "COMPUTE_WH",
    "database": "SNOWFLAKE_SAMPLE_DATA",
    "schema": "TPCH_SF1"
}   

session = Session.builder.configs(conn_parameters).create()
result = session.sql("SELECT CURRENT_warehouse(), CURRENT_DATABASE()").collect()
print(result)




session.close()


