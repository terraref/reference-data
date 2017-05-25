from .api_data_helpers import get_trait_records
from .variable_data_retrieval import get_variable_data
import datetime

# Helper function the returns a datetime.date object given an API formatted date string
def format_date(date):

	date_string = date.split('T')[0]
	return datetime.datetime.strptime(date_string, '%Y-%m-%d').date()

# Returns a dict object containing managements data
# Variables are used as keys, values are dicts containing:
# Total count, dict objects associating dates with mean values to use with plotting library
# Dict object also includes variable data used for plot labeling 
def get_trait_data(start_date, end_date):

	all_traits = get_trait_records(start_date, end_date)

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

	for trait_variable in variable_data:
		variable_data[ trait_variable ]["variable_data"] = get_variable_data(trait_variable)

	return variable_data

