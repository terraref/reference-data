from api_data_retrieval.trait_data_retrieval import get_trait_data
import matplotlib.pyplot as plt
import numpy

def plot_dates(year, start_month, end_month):

	trait_data = get_trait_data(year, start_month, end_month)

	traits = [trait for trait in trait_data]

	for trait in traits:


		dateTicks = []
		means = []

		date_dict = trait_data[trait]["dates"]

		for date in date_dict:
			dateTicks.append(date)
		
		dateTicks.sort()

		dates = range(0, len(dateTicks))
		plt.xticks(dates, dateTicks)
		plt.xticks(range(len(dateTicks)), dateTicks, rotation=45)

		i=0
		for date in dateTicks:
			date_means = []
			for mean in date_dict[date]["means"]:
				date_means.append(mean)
				plt.plot(i, mean, 'o', color='black')
			i+=1
			means.append(date_means)

		print(means)

		plt.title('Observations for ' + str(trait))
		plt.ylabel('Mean Value')
		plt.xlabel('Dates')
		plt.show()


plot_dates(2016, 8, 12)