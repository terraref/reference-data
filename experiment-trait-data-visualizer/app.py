from api_data_retrieval.trait_data_retrieval import get_trait_data
from api_data_retrieval.management_data_retrieval import get_management_data
from api_data_retrieval.variable_date_plotter import plot_dates

from flask import Flask, render_template
from flask_bootstrap import Bootstrap

app = Flask(__name__)
boostrap = Bootstrap(app)

@app.route('/')
def data_summary():

	year = 2016
	start_month = 8
	end_month = 12

	trait_data = get_trait_data(year, start_month, end_month)
	management_data = get_management_data(year, start_month, end_month)
	plot_dates(year, start_month, end_month)

	return render_template('index.html', trait_data=trait_data, management_data=management_data, 
											year=year, start_month=start_month, end_month=end_month)

if __name__ == '__main__':
	app.run()
