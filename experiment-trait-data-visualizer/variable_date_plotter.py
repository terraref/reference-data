from api_data_retrieval.trait_data_retrieval import get_trait_data
import matplotlib.pyplot as plt

def plot_dates(year, start_month, end_month):

	trait_data = get_trait_data(year, start_month, end_month)

	traits = [trait for trait in trait_data]

	for trait in traits:

		dateTicks = []
		counts = []

		date_dict = trait_data[trait]['dates']

		for date in date_dict:
			dateTicks.append(date)
		
		dateTicks.sort()

		for date in dateTicks:
			counts.append(date_dict[date])

		dates = range(0, len(dateTicks))
		plt.xticks(dates, dateTicks)
		plt.xticks(range(len(dateTicks)), dateTicks, rotation=45)

		plt.plot(dates, counts)

		plt.title('Observations for ' + str(trait))
		plt.ylabel('Observations')
		plt.xlabel('Dates')
		plt.show()


plot_dates(2016, 8, 12)