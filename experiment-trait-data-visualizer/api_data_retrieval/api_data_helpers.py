import requests
import json
import os

def make_api_request(endpoint, id, payload_add):

	payload = {'key':os.environ.get('BETYdbKey')}
	payload.update(payload_add)
	api_response = requests.get('https://terraref.ncsa.illinois.edu/bety/api/beta/' + endpoint + '/' + str(id),
			auth=('nickheyek', os.environ.get('BETYdbPass')),
			params=payload)

	api_data = dict(api_response.json())
	return api_data

def get_formatted_month(month):
	if month < 10:
		return '0' + str(month)
	return str(month)

def get_records_file_name(endpoint, year, start_month, end_month):
	return 'api_data_cache/' + endpoint + '_' + str(year) + '-' + get_formatted_month(start_month) + '-' + \
			get_formatted_month(end_month)

def get_records(endpoint, year, start_month, end_month):

	records = []

	cache_filename = cache_filename = get_records_file_name(endpoint, year, start_month, end_month)
	
	if os.path.exists(cache_filename):
		with open(cache_filename) as cache_file:
			records = json.load(cache_file)
		return records

	record_count = 0

	for month in range(start_month, end_month+1):

		formatted_month = get_formatted_month(month)

		payload = {'date':'~'+ str(year) + '-' + str(formatted_month),
					'limit':'none'}

		api_data = make_api_request(endpoint, '', payload)

		records += api_data["data"]
		record_count += api_data["metadata"]["count"]

	if not os.path.exists('api_data_cache'):
		os.makedirs('api_data_cache')
		
	with open(cache_filename, 'w') as cache_file:
		json.dump(records, cache_file)

	return records

def get_trait_records(year, start_month, end_month):
	return get_records('traits', year, start_month, end_month)

def get_management_records(year, start_month, end_month):
	return get_records('managements', year, start_month, end_month)
