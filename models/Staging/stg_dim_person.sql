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

SELECT * FROM final