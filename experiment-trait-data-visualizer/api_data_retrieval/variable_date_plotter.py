import os
from .trait_data_retrieval import get_trait_data
import pygal
from pygal.style import Style
import datetime

mean_style = Style(background='transparent',
							colors=('#000000','#000000'),
							font_family='googlefont:Open Sans',
							title_font_size=24,
							value_font_size=32,
							major_label_font_size=16,
							label_font_size=16)

def get_mean_plot_filename(trait, start_date, end_date):
	return 'static/plots/plot_' + str(trait) + '_' + str(start_date) + '_' + str(end_date) + '.svg'
	
def plot_dates(start_date, end_date):

	trait_data = get_trait_data(start_date, end_date)

	for trait in trait_data:

		mean_plot_filename = get_mean_plot_filename(trait, start_date, end_date)

		if not os.path.exists(mean_plot_filename):

			date_labels = []
			date_dict = trait_data[trait]["dates"]
			variable_name = trait_data[trait]["variable_data"]["name"]
			variable_standard_name = trait_data[trait]["variable_data"]["standard_name"]
			units = str(trait_data[trait]["variable_data"]["units"]).replace('_', ' ')

			if variable_standard_name:
				mean_plot_title = variable_standard_name
			else:
				mean_plot_title = variable_name

			x_label_rotation = 0
			if len(date_labels) >= 5:
				x_label_rotation = 20

			mean_plot_title = mean_plot_title.replace('_', ' ').title()
			mean_plot = pygal.Box(show_legend=False, style=mean_style, x_label_rotation=x_label_rotation,
				title=mean_plot_title, y_title=units, show_y_guides=False)

			step_date = start_date
			time_step = datetime.timedelta(days=1)

			while step_date <= end_date:

				date_means = []
				count = 0
				if step_date in date_dict:
					count = date_dict[step_date]["count"]
					for mean in date_dict[step_date]["means"]:
						date_means.append({'value':mean, 'color':'#1a6d2f',
							'label': str(step_date) + ', ' + str(count) + ' records'})
				step_date += time_step

				mean_plot.add('', date_means)

			'''for date in range(0, len(date_labels)):
				date_label = date_labels[date]
				date_means = []
				count = date_dict[date_label]["count"]
				for mean in date_dict[date_label]["means"]:
					date_means.append({'value':mean, 'color':'#1a6d2f', 'label': 'Records: ' + str(count)})

				mean_plot.add('', date_means)

			mean_plot.x_labels = date_labels'''

			if not os.path.exists('static/plots'):
				os.makedirs('static/plots')
			mean_plot.render_to_file(mean_plot_filename)
