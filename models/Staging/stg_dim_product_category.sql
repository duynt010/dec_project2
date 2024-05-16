WITH dim_product_category__source as (
    SELECT
    *
    FROM `adventureworks2019.Production.ProductCategory`

)

 ,dim_product_category__rename as (
    SELECT
        ProductcategoryID as product_category_key
        ,Name as product_category_name
    FROM dim_product_category__source
  )

 ,dim_product_category__cast_type as (
  SELECT
    cast(product_category_key AS integer) as product_category_key
    ,cast(product_category_key as STRING) as product_category_name
  FROM dim_product_category__rename
  )

 ,dim_product_category__add_undefined_record as (
  SELECT 
    product_category_key
    ,product_category_name

  FROM dim_product_category__cast_type

  UNION all
  SELECT
    0 as product_category_key
    ,'Undefined' as product_category_name

  UNION ALL
  SELECT
    -1 as product_category_key
    ,'Invalid' as product_category_name
  )

  SELECT
    product_category_key
    ,product_category_name
  FROM dim_product_category__add_undefined_record