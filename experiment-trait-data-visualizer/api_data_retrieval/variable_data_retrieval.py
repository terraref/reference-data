from .api_data_helpers import make_api_request
import os
import json

# Helper function returns properly formatted filename for cache storage
def get_filename(variable_id):
	return 'api_data_cache/' + 'variable_data_' + str(variable_id)

# Called by get_trait_data()
# Returns a dict containing variable data
# Variable data used for plot labeling
def get_variable_data(variable_id):

	cache_filename = get_filename(variable_id)
	if (os.path.exists(cache_filename)):
		with open(cache_filename) as cache_file:
			variable_return_data = json.load(cache_file)
		return variable_return_data

	variable_api_data = make_api_request('variables', variable_id, {})
	variable_general_data = variable_api_data["data"]["variable"]

	variable_return_data = {}
	variable_return_data["name"] = variable_general_data["name"]
	variable_return_data["standard_name"] = variable_general_data["standard_name"]
	variable_return_data["description"] = variable_general_data["description"]
	variable_return_data["units"] = variable_general_data["units"]

	with open(cache_filename, 'w') as cache_file:
		json.dump(variable_return_data, cache_file)

	return variable_return_data
