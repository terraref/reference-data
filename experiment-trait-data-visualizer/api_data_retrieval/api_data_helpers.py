import requests
import json
import os
import datetime

# Makes API call, returns dict object created from JSON API data
def make_api_request(endpoint, id, payload_add):

	payload = {'key':os.environ.get('BETYdbKey')}
	payload.update(payload_add)
	api_response = requests.get('https://terraref.ncsa.illinois.edu/bety/api/beta/' + endpoint + '/' + str(id),
			auth=('nickheyek', os.environ.get('BETYdbPass')),
			params=payload)

	api_data = dict(api_response.json())
	return api_data

# Helper function returns properly formatted filename for cache storage
def get_records_file_name(endpoint, start_date, end_date):
	return 'api_data_cache/' + endpoint + '_' + str(start_date) + '_' + str(end_date)

# Given an endpoint and date, makes the appropriate API call(s),
# accumulating data into and returning an array of trait data
def get_records(endpoint, start_date, end_date):

	records = []

	cache_filename = cache_filename = get_records_file_name(endpoint, start_date, end_date)
	
	if os.path.exists(cache_filename):
		with open(cache_filename) as cache_file:
			records = json.load(cache_file)
		return records

	record_count = 0

	step_date = start_date
	time_step = datetime.timedelta(days=1)

	while step_date <= end_date:

		curr_date_str = str(step_date)
		payload = {'date':'~'+curr_date_str, 'limit':'none'}

		api_data = make_api_request(endpoint, '', payload)
		records += api_data["data"]
		record_count += api_data["metadata"]["count"]

		step_date += time_step

	if not os.path.exists('api_data_cache'):
		os.makedirs('api_data_cache')
		
	with open(cache_filename, 'w') as cache_file:
		json.dump(records, cache_file)

	return records

# Calls get_records() with the appropriate endpoints
def get_trait_records(start_date, end_date):
	return get_records('traits', start_date, end_date)

def get_management_records(start_date, end_date):
	return get_records('managements', start_date, end_date)
