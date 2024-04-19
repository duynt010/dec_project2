WITH dim_person__source AS (
	SELECT 
		*
	FROM `adventureworks2019.Person.Person`
)

  ,dim_person__rename AS (
	SELECT
		BusinessEntityID AS person_key,
		Title AS person_title,
		FirstName AS person_first_name,
		MiddleName AS person_middle_name,
		LastName AS person_last_name,
		Suffix AS person_suffix
	FROM dim_person__source
)

  ,dim_person__convert AS (
  SELECT
    person_key,
    CASE 
      WHEN person_title = 'NULL' THEN NULL  -- Explicitly handle 'NULL' as SQL NULL
      ELSE person_title
    END  person_title,
    CASE 
      WHEN person_first_name = 'NULL' THEN NULL  -- Explicitly handle 'NULL' as SQL NULL
      ELSE person_first_name
    END  person_first_name,
    CASE 
      WHEN person_middle_name = 'NULL' THEN NULL  -- Explicitly handle 'NULL' as SQL NULL
      ELSE person_middle_name
    END  person_middle_name,
    CASE 
      WHEN person_last_name = 'NULL' THEN NULL  -- Explicitly handle 'NULL' as SQL NULL
      ELSE person_last_name
    END  person_last_name,
    CASE 
      WHEN person_suffix = 'NULL' THEN NULL  -- Explicitly handle 'NULL' as SQL NULL
      ELSE person_suffix
    END  person_suffix
  FROM dim_person__rename
 )

	,dim_person__add_undefined_record as (
  SELECT 
    person_key,
    person_title,
    person_first_name,
    person_middle_name,
    person_last_name,
    person_suffix
  FROM dim_person__convert

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

  SELECT 
    person_key,
    person_title,
    person_first_name,
    person_middle_name,
    person_last_name,
    person_suffix
  FROM dim_person__add_undefined_record