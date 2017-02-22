from api_data_helpers import get_trait_records

def get_trait_data(year, start_month, end_month):

	all_traits = get_trait_records(year, start_month, end_month)

	variable_data = {}

	for trait in all_traits:

		trait_variable_id = trait["trait"]["variable_id"]
		trait_date = trait["trait"]["date"]

		if trait_variable_id not in variable_data:
			variable_data[ trait_variable_id ] = {}
			variable_data[ trait_variable_id ]["count"] = 1
			variable_data[ trait_variable_id ]["dates"] = {}
			variable_data[ trait_variable_id ]["dates"][trait_date] = 1
		else:
			variable_data[ trait["trait"]["variable_id"]]["count"]  += 1

			if trait_date not in variable_data[ trait_variable_id ]["dates"]:
				variable_data[ trait_variable_id ]["dates"][trait_date] = 1
			else:
				variable_data[ trait_variable_id ]["dates"][trait_date] += 1

	return variable_data

print(get_trait_data(2016, 8, 12))