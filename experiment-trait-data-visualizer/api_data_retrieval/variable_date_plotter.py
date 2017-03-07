from .trait_data_retrieval import get_trait_data
import pygal
from pygal.style import CleanStyle

def plot_dates(year, start_month, end_month):

	trait_data = get_trait_data(year, start_month, end_month)

	traits = [trait for trait in trait_data]

	for trait in traits:

		means = []
		date_labels = []
		date_dict = trait_data[trait]["dates"]

		for date in date_dict:
			date_labels.append(date)
		date_labels.sort()

		chart = pygal.XY(show_legend=False, xrange=(0, len(date_labels)), style=CleanStyle)

		for date in range(0, len(date_labels)):
			date_means = []
			for mean in date_dict[date_labels[date]]["means"]:
				date_means.append(mean)
			means.append(date_means)


		for date in range(0, len(date_labels)):
			chart.add(date_labels[date], [(date, mean) for mean in means[date]])

		chart.x_labels = date_labels

		chart.render_to_file('static/charts/chart_' + str(trait) + '.svg')
