from .api_data_helpers import get_management_records
import datetime

def format_date(date):

	date_string = date.split('T')[0]
	return datetime.datetime.strptime(date_string, '%Y-%m-%d').date()

def get_management_data(start_date, end_date):

	all_managements = get_management_records(start_date, end_date)

	managements_data = {}

	prev_date = start_date

	for management in all_managements:

		curr_date = format_date(management["management"]["date"])

		management_data_entry = {}
		management_data_entry["type"] = management["management"]["mgmttype"]
		management_data_entry["notes"] = management["management"]["notes"]

		if curr_date not in managements_data:
			managements_data[curr_date] = {}
			managements_data[curr_date]["entries"] = []
			timeline_dist = (curr_date - prev_date).days
			managements_data[curr_date]["timeline_dist"] = timeline_dist

		managements_data[curr_date]["entries"].append(management_data_entry)

		prev_date = curr_date

	return managements_data
