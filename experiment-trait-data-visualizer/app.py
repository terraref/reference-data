from api_data_retrieval.trait_data_retrieval import get_trait_data
from api_data_retrieval.management_data_retrieval import get_management_data
from api_data_retrieval.variable_date_plotter import plot_dates
import datetime

from flask import Flask, render_template
from flask_bootstrap import Bootstrap

app = Flask(__name__)
boostrap = Bootstrap(app)

@app.route('/')
def data_summary():

	# Start date and end date set to Sorghum Season 2
	# Will pull from experiments endpoint of BETYdb API to use most recent experiment once available

	start_date = datetime.datetime.strptime("2016-8-3", '%Y-%m-%d').date()
	end_date = datetime.datetime.strptime("2016-12-2", '%Y-%m-%d').date()

	# Get managements data for timeline visualization
	management_data = get_management_data(start_date, end_date)
	# Create svgs for trait data (if they don't exist)
	# Returns list of trait ids to display in HTML
	trait_variable_ids = plot_dates(start_date, end_date)

	return render_template('index.html', trait_variable_ids=trait_variable_ids, management_data=management_data,
											start_date=start_date, end_date=end_date)

if __name__ == '__main__':
	app.run()
