WITH dim_product_subcategory__source as (
    SELECT
    *
    FROM `adventureworks2019.Production.ProductSubcategory`

)

 ,dim_product_subcategory__rename as (
    SELECT
        ProductSubcategoryID as product_subcategory_key
        ,ProductCategoryID as product_category_key
        ,Name as product_subcategory_name
    FROM dim_product_subcategory__source
  )

 ,dim_product_subcategory__cast_type as (
  SELECT
    cast(product_subcategory_key AS integer) as product_subcategory_key
    ,cast(product_subcategory_name as string) as product_subcategory_name
    ,cast(product_category_key as integer) as product_category_key
  FROM dim_product_subcategory__rename
  )

 ,dim_product_subcategory__add_undefined_record as (
  SELECT 
    product_subcategory_key
    ,product_subcategory_name
    ,product_category_key
  FROM dim_product_subcategory__cast_type

  UNION all
  SELECT
    0 as product_subcategory_key
    ,'Undefined' as product_subcategory_name
    ,0 as product_category_key

  UNION ALL
  SELECT
    -1 as product_subcategory_key
    ,'Invalid' as product_subcategory_name
    ,-1 as product_category_key
  )

  SELECT
    product_subcategory_key
    ,product_subcategory_name
    ,product_category_key
  FROM dim_product_subcategory__add_undefined_record