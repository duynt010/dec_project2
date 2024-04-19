WITH dim_customer__source as (
SELECT *
FROM `adventureworks2019.Sales.Customer`
)

,dim_customer__rename as (
    SELECT
        cast(CustomerID as integer) AS customer_key
        ,cast(REPLACE(PersonID,"NULL","0") as INTEGER) as person_key
        ,cast(REPLACE(StoreID,"NULL","0") AS INTEGER)  as store_key
        ,cast(TerritoryID as integer) as territory_key
    FROM dim_customer__source
    )  

,dim_customer__add_undefined_record as (
  SELECT 
    customer_key
    ,person_key
    ,store_key
    ,territory_key
  FROM dim_customer__rename

  UNION all
  SELECT
    0 as customer_key
    ,0 as person_key
    ,0 as store_key
    ,0 as territory_key

  UNION ALL
  SELECT
     -1 as customer_key
    ,-1 as person_key
    ,-1 as store_key
    ,-1 as territory_key
  )

    SELECT
        customer_key
        ,person_key
        ,store_key
        ,territory_key
    FROM dim_customer__add_undefined_record AS dim_customer
