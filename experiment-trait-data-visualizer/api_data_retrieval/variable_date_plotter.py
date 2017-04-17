import os
from .trait_data_retrieval import get_trait_data
import pygal
from pygal.style import Style
import datetime

# Sets style settings for plot
mean_style = Style(background='transparent',
							colors=('#000000','#000000'),
							font_family='googlefont:Open Sans',
							title_font_size=24,
							value_font_size=32,
							major_label_font_size=16,
							label_font_size=16)

# Helper function returns properly formatted filename for rendering and cache storage
def get_mean_plot_filename(trait, start_date, end_date):
	return 'static/plots/plot_' + str(trait) + '_' + str(start_date) + '_' + str(end_date) + '.svg'

# Generates box plots for trait data
# Renders each plot to svg file in 'static' directory, which is then displayed by HTML
def plot_dates(start_date, end_date):

	trait_data = get_trait_data(start_date, end_date)
	trait_variable_ids = []

	for trait in trait_data:

		trait_variable_ids.append(trait)
		mean_plot_filename = get_mean_plot_filename(trait, start_date, end_date)

		if not os.path.exists(mean_plot_filename):

			# Get trait data
			date_dict = trait_data[trait]["dates"]
			variable_name = trait_data[trait]["variable_data"]["name"]
			variable_standard_name = trait_data[trait]["variable_data"]["standard_name"]
			units = str(trait_data[trait]["variable_data"]["units"]).replace('_', ' ')

			# Use standard name as title if provided, otherwise variable name
			if variable_standard_name:
				mean_plot_title = variable_standard_name
			else:
				mean_plot_title = variable_name

			mean_plot_title = mean_plot_title.replace('_', ' ').title()
			mean_plot = pygal.Box(show_legend=False, style=mean_style,
				title=mean_plot_title, y_title=units, show_y_guides=False)

			step_date = start_date
			time_step = datetime.timedelta(days=1)

			# Cycle through all dates in experiment (by day)
			# Generate data point with corresponding data if exists for that date
			# Otherwise, set it as a none value
			# Ensures proper spacing between data points
			while step_date <= end_date:

				date_means = []
				count = 0
				if step_date in date_dict:
					count = date_dict[step_date]["count"]
					for mean in date_dict[step_date]["means"]:
						date_means.append({'value':mean, 'color':'#1a6d2f',
							'label': str(step_date) + ', ' + str(count) + ' records', 'node': {'r': 2}})
					mean_plot.add(None, date_means)
				
				else:
					mean_plot.add(None, [{'value':None, 'color': 'rgba(0, 0, 0, 0)'}])
				step_date += time_step


			# Render to svg
			if not os.path.exists('static/plots'):
				os.makedirs('static/plots')
			mean_plot.render_to_file(mean_plot_filename)

	# Return array of variable ids for HTML to look for corresponding svgs
	return trait_variable_ids