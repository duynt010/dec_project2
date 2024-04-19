SELECT
    dim_customer.customer_key
    ,dim_customer.is_reseller
    ,dim_customer.store_key as reseller_store_key
    ,dim_store.store_name as reseller_store_name
    ,dim_customer.person_key
    ,dim_person.person_title
    ,dim_person.person_first_name
    ,dim_person.person_middle_name
    ,dim_person.person_last_name


FROM
    {{ref("stg_dim_customer")}} dim_customer
    LEFT JOIN {{ref("stg_dim_person")}} dim_person
        ON dim_customer.person_key = dim_person.person_key
    LEFT JOIN {{ref("stg_dim_store")}} dim_store
        on dim_store.store_key = dim_customer.store_key