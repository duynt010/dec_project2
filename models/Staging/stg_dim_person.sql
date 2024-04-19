WITH person AS (
	SELECT 
		*
	FROM `adventureworks2019.Person.Person`
),
rename AS (
	SELECT
		BusinessEntityID AS person_key,
		Title AS person_title,
		FirstName AS person_first_name,
		MiddleName AS person_middle_name,
		LastName AS person_last_name,
		Suffix AS person_suffix
	FROM person
),
final AS (
	SELECT
		person_key,
		person_title,
		person_first_name,
		person_middle_name,
		person_last_name,
		person_suffix
	FROM rename
)
	,dim_customer__add_undefined_record as (
  SELECT 
    person_key,
	person_title,
	person_first_name,
	person_middle_name,
	person_last_name,
	person_suffix
  FROM final

  UNION all
  SELECT
    0 as person_key,
	'Undefined' as person_title,
	'Undefined' as person_first_name,
	'Undefined' as person_middle_name,
	'Undefined' as person_last_name,
	'Undefined' as person_suffix

  UNION ALL
  SELECT
   -1 as person_key,
	'Invalid' as person_title,
	'Invalid' as person_first_name,
	'Invalid' as person_middle_name,
	'Invalid' as person_last_name,
	'Invalid' as person_suffix
  )

SELECT * FROM dim_customer__add_undefined_record