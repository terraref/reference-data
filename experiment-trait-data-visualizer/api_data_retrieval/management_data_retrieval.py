from .api_data_helpers import get_management_records

def get_management_data(year, start_month, end_month):

	all_managements = get_management_records(2016, 8, 12)

	managements_data = {}

	prev_day = 0
	prev_month = 0
	prev_year = 0

	for management in all_managements:

		management_date = management["management"]["date"]
		date_arr = management_date.split('-')
		curr_year = int(date_arr[0])
		curr_month = int(date_arr[1])
		curr_day = int(date_arr[2])

		management_data_entry = {}
		management_data_entry["type"] = management["management"]["mgmttype"]
		management_data_entry["notes"] = management["management"]["notes"]

		if management_date not in managements_data:
			managements_data[management_date] = {}
			managements_data[management_date]["entries"] = []
			timeline_dist = 0
			if (prev_year != 0):
				timeline_dist += 365 * (curr_year - prev_year) + 30 * (curr_month - prev_month) + (curr_day - prev_day)
			managements_data[management_date]["timeline_dist"] = timeline_dist

		managements_data[management_date]["entries"].append(management_data_entry)

		prev_year = curr_year
		prev_month = curr_month
		prev_day = curr_day

	return managements_data
