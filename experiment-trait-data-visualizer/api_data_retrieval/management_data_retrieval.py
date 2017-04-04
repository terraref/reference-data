from .api_data_helpers import get_management_records

def get_management_data(year, start_month, end_month):

	all_managements = get_management_records(2016, 8, 12)

	managements_data = []

	prev_day = 0
	prev_month = 0
	prev_year = 0

	for management in all_managements:

		management_data_entry = {}
		management_data_entry["date"] = management["management"]["date"]
		management_data_entry["type"] = management["management"]["mgmttype"]
		management_data_entry["notes"] = management["management"]["notes"]

		timeline_dist = 0
		date_arr = management_data_entry["date"].split('-')
		curr_year = int(date_arr[0])
		curr_month = int(date_arr[1])
		curr_day = int(date_arr[2])

		if (prev_year != 0):
			timeline_dist += 365 * (curr_year - prev_year) + 30 * (curr_month - prev_month) + (curr_day - prev_day)

		management_data_entry["timeline_dist"] = timeline_dist

		prev_year = curr_year
		prev_month = curr_month
		prev_day = curr_day

		managements_data.append(management_data_entry)

	return managements_data
