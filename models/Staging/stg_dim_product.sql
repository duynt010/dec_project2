WITH dim_product__source as (
    SELECT
    *
    FROM `adventureworks2019.Production.Product`
)

 ,dim_product__rename as (
  SELECT
    ProductID as product_key
    ,Name as product_name
    ,ProductNumber as product_number
    ,MakeFlag as make_flag
    ,FinishedGoodsFlag as finished_goods_flag
    ,Color as color
    ,size as size
    ,Weight as weight
    ,SizeUnitMeasureCode as size_unit_measure_code
    ,WeightUnitMeasureCode as weight_unit_measure_code
    ,ProductSubcategoryID as product_subcategory_key
    ,ProductModelID as product_model_key
    ,StandardCost as product_standard_cost
    ,ListPrice as list_price
  FROM dim_product__source
  )

 ,dim_product__cast_type as (
  SELECT
    cast(product_key as integer) as product_key
    ,cast(product_name as string) product_name
    ,cast(product_number as string) as product_number
    ,cast(make_flag as integer) as make_flag
    ,cast(finished_goods_flag as integer) as  finished_goods_flag
    ,cast(color as string) as color
    ,cast(size as string) as size
    ,cast(weight as numeric) as weight
    ,cast(size_unit_measure_code as string) as size_unit_measure_code
    ,cast(weight_unit_measure_code as string) as weight_unit_measure_code
    ,cast(product_subcategory_key as integer) as product_subcategory_key
    ,cast(product_model_key as string) as product_model_key
    ,cast(product_standard_cost as numeric) as product_standard_cost
    ,cast(list_price as numeric) as list_price
  FROM dim_product__rename
  )

 ,dim_product__add_undefined_record as (
  SELECT 
    product_key
    ,product_name

  FROM dim_product__cast_type

  UNION all
  SELECT
    0 as product_key
    ,'Undefined' as product_name

  UNION ALL
  SELECT
    -1 as product_key
    ,'Invalid' as product_name
  )

  SELECT
    product_key
    ,product_name
  FROM dim_product__add_undefined_record