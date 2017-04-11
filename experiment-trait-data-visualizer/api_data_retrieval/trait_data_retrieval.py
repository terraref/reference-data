from .api_data_helpers import get_trait_records
from .variable_data_retrieval import get_variable_data
import datetime

def format_date(date):

	date_string = date.split('T')[0]
	return datetime.datetime.strptime(date_string, '%Y-%m-%d').date()

def get_trait_data(year, start_month, end_month):

	all_traits = get_trait_records(year, start_month, end_month)

	variable_data = {}

	for trait in all_traits:

		trait_variable_id = trait["trait"]["variable_id"]

		trait_method_id = trait["trait"]["method_id"]

		trait_date = trait["trait"]["date"]
		formatted_date = format_date(trait_date)

		trait_created_at = trait["trait"]["created_at"]
		formatted_created_at = format_date(trait_created_at)

		trait_mean = trait["trait"]["mean"]

		if trait_variable_id not in variable_data:
			variable_data[ trait_variable_id ] = {}
			variable_data[ trait_variable_id ]["count"] = 1
			variable_data[ trait_variable_id ]["dates"] = {}
			variable_data[ trait_variable_id ]["dates"][formatted_date] = {}
			variable_data[ trait_variable_id ]["dates"][formatted_date]["count"] = 1
			variable_data[ trait_variable_id ]["dates"][formatted_date]["means"] = []
			variable_data[ trait_variable_id ]["dates"][formatted_date]["means"].append(trait_mean)

			variable_data[ trait_variable_id ]["created_at_dates"] = {}
			variable_data[ trait_variable_id ]["created_at_dates"][formatted_created_at] = 1
			variable_data[ trait_variable_id ]["methods"] = {}
			variable_data[ trait_variable_id ]["methods"][trait_method_id] = 1
		else:
			variable_data[ trait["trait"]["variable_id"]]["count"]  += 1

			if formatted_date not in variable_data[ trait_variable_id ]["dates"]:
				variable_data[ trait_variable_id ]["dates"][formatted_date] = {}
				variable_data[ trait_variable_id ]["dates"][formatted_date]["count"] = 1
				variable_data[ trait_variable_id ]["dates"][formatted_date]["means"] = []
				variable_data[ trait_variable_id ]["dates"][formatted_date]["means"].append(trait_mean)
			else:
				variable_data[ trait_variable_id ]["dates"][formatted_date]["count"] += 1
				variable_data[ trait_variable_id ]["dates"][formatted_date]["means"].append(trait_mean)

			if formatted_created_at not in variable_data[ trait_variable_id ]["created_at_dates"]:
				variable_data[ trait_variable_id ]["created_at_dates"][formatted_created_at] = 1
			else:
				variable_data[ trait_variable_id ]["created_at_dates"][formatted_created_at] += 1

			if trait_method_id not in variable_data[ trait_variable_id ]["methods"]:
				variable_data[ trait_variable_id ]["methods"][trait_method_id] = 1;
			else:
				variable_data[ trait_variable_id ]["methods"][trait_method_id] += 1;

	for trait_variable in variable_data:
		
		variable_data[ trait_variable ]["variable_data"] = get_variable_data(trait_variable)

	return variable_data

