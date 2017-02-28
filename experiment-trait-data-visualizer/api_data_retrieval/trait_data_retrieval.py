from .api_data_helpers import get_trait_records

def format_date(date):

	date_time = date.split('T')
	return date_time[0]

def get_trait_data(year, start_month, end_month):

	all_traits = get_trait_records(year, start_month, end_month)

	variable_data = {}

	for trait in all_traits:

		trait_variable_id = trait["trait"]["variable_id"]
		trait_method_id = trait["trait"]["method_id"]
		trait_created_at = trait["trait"]["created_at"]

		trait_date = trait["trait"]["date"]
		formatted_date = format_date(trait_date)

		if trait_variable_id not in variable_data:
			variable_data[ trait_variable_id ] = {}
			variable_data[ trait_variable_id ]["count"] = 1
			variable_data[ trait_variable_id ]["dates"] = {}
			variable_data[ trait_variable_id ]["dates"][formatted_date] = 1
			variable_data[ trait_variable_id ]["methods"] = {}
			variable_data[ trait_variable_id ]["methods"][trait_method_id] = 1
		else:
			variable_data[ trait["trait"]["variable_id"]]["count"]  += 1

			if formatted_date not in variable_data[ trait_variable_id ]["dates"]:
				variable_data[ trait_variable_id ]["dates"][formatted_date] = 1
			else:
				variable_data[ trait_variable_id ]["dates"][formatted_date] += 1

			if trait_method_id not in variable_data[ trait_variable_id ]["methods"]:
				variable_data[ trait_variable_id ]["methods"][trait_method_id] = 1;
			else:
				variable_data[ trait_variable_id ]["methods"][trait_method_id] += 1;

	return variable_data