import os
from .trait_data_retrieval import get_trait_data
import pygal
from pygal.style import Style 

mean_style = Style(background='transparent',
							colors=('#000000','#000000'),
							font_family='googlefont:Open Sans',
							title_font_size=24,
							value_font_size=32,
							major_label_font_size=16,
							label_font_size=16)

def get_mean_plot_filename(trait, year, start_month, end_month):
	return 'static/plots/plot_' + str(trait) + '_' + str(year) + '_' + str(start_month) + '_' + str(end_month) + '.svg'

def get_count_plot_filename(trait, year, start_month, end_month):
	return 'static/plots/countplot_' + str(trait) + '_' + str(year) + '_' + str(start_month) + '_' + str(end_month) + '.svg'

def plot_dates(year, start_month, end_month):

	trait_data = get_trait_data(year, start_month, end_month)
	traits = [trait for trait in trait_data]


	for trait in traits:

		mean_plot_filename = get_mean_plot_filename(trait, year, start_month, end_month)
		if not os.path.exists(mean_plot_filename):

			date_labels = []
			date_dict = trait_data[trait]["dates"]
			variable_name = trait_data[trait]["variable_data"]["name"]
			variable_standard_name = trait_data[trait]["variable_data"]["standard_name"]
			units = trait_data[trait]["variable_data"]["units"]

			if variable_standard_name:
				mean_plot_title = variable_standard_name
			else:
				mean_plot_title = variable_name

			units = str(units)

			for date in date_dict:
				date_labels.append(date)
			date_labels.sort()

			x_label_rotation = 0
			if len(date_labels) >= 5:
				x_label_rotation = 20

			mean_plot_title = mean_plot_title.replace('_', ' ').title()
			units = units.replace('_', ' ')
			mean_plot = pygal.Box(show_legend=False, style=mean_style, x_label_rotation=x_label_rotation,
				title=mean_plot_title, y_title=units, show_y_guides=False)


			for date in range(0, len(date_labels)):
				date_label = date_labels[date]
				date_means = []
				count = date_dict[date_label]["count"]
				for mean in date_dict[date_label]["means"]:
					date_means.append({'value':mean, 'color':'#1a6d2f', 'label': 'Records: ' + str(count)})

				mean_plot.add('', date_means)

			mean_plot.x_labels = date_labels

			if not os.path.exists('static/plots'):
				os.makedirs('static/plots')
			mean_plot.render_to_file(mean_plot_filename)
