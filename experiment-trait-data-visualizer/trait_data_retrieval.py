from api_data_helpers import get_trait_records

def get_trait_data(year, start_month, end_month):

	all_traits = get_trait_records(year, start_month, end_month)

	variable_count_dict = {}

	for trait in all_traits:

		if trait["trait"]["variable_id"] not in variable_count_dict:
			variable_count_dict[trait["trait"]["variable_id"]] = 1
			
		variable_count_dict[trait["trait"]["variable_id"]] += 1

	return variable_count_dict
