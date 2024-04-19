WITH dim_customer__source as (
SELECT *
FROM `adventureworks2019.Sales.Customer`
)

  ,dim_customer__rename as (
    SELECT
        cast(CustomerID as integer) AS customer_key
        ,CAST(
          CASE 
            WHEN PersonID = 'NULL' THEN NULL  -- Explicitly handle 'NULL' as SQL NULL
            ELSE PersonID
          END AS INTEGER)
        as person_key
        ,CAST(
          CASE 
            WHEN StoreID = 'NULL' THEN NULL  -- Explicitly handle 'NULL' as SQL NULL
            ELSE StoreID
          END AS INTEGER)
        as store_key
        ,cast(TerritoryID as integer) as territory_key
    FROM dim_customer__source
    )  

  ,dim_customer__convert AS (
  SELECT
    *,
    CASE --flag defines a reseller where store_id is not null and an individual as a customer where store_id is null
      WHEN store_key is NOT NULL THEN 'Reseller' 
      WHEN store_key is NULL THEN 'Not Reseller'
      ELSE  'Invalid' END
    AS is_reseller
  FROM dim_customer__rename
 )

  ,dim_customer__add_undefined_record as (
  SELECT 
    customer_key
    ,is_reseller
    ,person_key
    ,store_key
    ,territory_key
  FROM dim_customer__convert

  UNION all
  SELECT
    0 as customer_key
    ,'Undefined' as is_reseller
    ,0 as person_key
    ,0 as store_key
    ,0 as territory_key

  UNION ALL
  SELECT
     -1 as customer_key
    ,'Invalid' as is_reseller
    ,-1 as person_key
    ,-1 as store_key
    ,-1 as territory_key
  )

	SELECT
		customer_key
		,is_reseller
		,COALESCE(person_key, 0) as person_key
		,COALESCE(store_key, 0) as store_key
		,territory_key
	FROM dim_customer__add_undefined_record AS dim_customer
