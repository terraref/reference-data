import requests
import json
import os

def get_formatted_month(month):

	if month < 10:
		return '0' + str(month)
	return str(month)

def get_file_name(endpoint, year, start_month, end_month):

	return endpoint + str(year) + '-' + get_formatted_month(start_month) + '-' + \
			get_formatted_month(end_month) + '.txt'

def get_api_records(endpoint, year, start_month, end_month):

	records = []

	cache_filename = cache_filename = get_file_name(endpoint, year, start_month, end_month)
	
	if os.path.exists(cache_filename):
		with open(cache_filename) as cache_file:
			records = json.load(cache_file)
		return records

	record_count = 0

	for month in range(start_month, end_month+1):

		formatted_month = get_formatted_month(month)

		payload = {'key':os.environ.get(BETYdbKey),
			'date':'~'+ str(year) + '-' + str(formatted_month),
			'limit':'none'}


		api_response = requests.get('https://terraref.ncsa.illinois.edu/bety/api/beta/' + endpoint,
			auth=('nickheyek', os.environ.get('BETYdbPass')),
			params=payload)

		apiData = dict(api_response.json())

		records += apiData["data"]
		print(apiData["metadata"]["count"])
		record_count += apiData["metadata"]["count"]

	with open(cache_filename, 'w') as cache_file:
		json.dump(records, cache_file)

	return records

def get_trait_records(year, start_month, end_month):
	return get_api_records('traits', year, start_month, end_month)

def get_management_records(year, start_month, end_month):
	return get_api_records('managements', year, start_month, end_month)
