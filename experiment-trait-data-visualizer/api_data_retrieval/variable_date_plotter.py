from .trait_data_retrieval import get_trait_data
import pygal
from pygal.style import Style 

same_color_style = Style(background='transparent',
							colors=('#000000','#000000'),
							title_font_size=24,
							value_font_size=20,
							major_label_font_size=16,
							label_font_size=16)

def plot_dates(year, start_month, end_month):

	trait_data = get_trait_data(year, start_month, end_month)

	traits = [trait for trait in trait_data]

	for trait in traits:

		date_labels = []
		date_dict = trait_data[trait]["dates"]
		variable_name = trait_data[trait]["variable_data"]["name"]
		variable_standard_name = trait_data[trait]["variable_data"]["standard_name"]
		units = trait_data[trait]["variable_data"]["units"]

		if variable_standard_name:
			plot_title = variable_standard_name
		else:
			plot_title = variable_name

		y_title = str(units)

		for date in date_dict:
			date_labels.append(date)
		date_labels.sort()

		
		plot = pygal.Box(show_legend=False, style=same_color_style,
			title=plot_title, y_title=y_title, show_y_guides=False)

		for date in range(0, len(date_labels)):
			date_means = []
			for mean in date_dict[date_labels[date]]["means"]:
				date_means.append({'value':mean, 'color':'#1a6d2f'})

			plot.add('', date_means, label="test")

		plot.x_labels = date_labels
		plot.render_to_file('static/plots/plot_' + str(trait) + '.svg')
