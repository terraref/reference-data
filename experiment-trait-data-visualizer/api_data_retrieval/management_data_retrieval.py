from .api_data_helpers import get_management_records

def get_management_data(year, start_month, end_month):

	all_managements = get_management_records(2016, 8, 12)

	managements_data = []

	for management in all_managements:

		management_data_entry = {}
		management_data_entry["date"] = management["management"]["date"]
		management_data_entry["type"] = management["management"]["mgmttype"]
		management_data_entry["notes"] = management["management"]["notes"]

		managements_data.append(management_data_entry)

	return managements_data
