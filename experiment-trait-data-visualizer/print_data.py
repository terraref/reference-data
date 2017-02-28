from api_data_retrieval.trait_data_retrieval import get_trait_data

def print_data():
	data = get_trait_data(2016, 8, 12)
	print(data)

print_data()