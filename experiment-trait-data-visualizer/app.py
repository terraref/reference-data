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


	start_date = datetime.datetime.strptime("2016-8-3", '%Y-%m-%d').date()
	end_date = datetime.datetime.strptime("2016-12-2", '%Y-%m-%d').date()

	trait_data = get_trait_data(start_date, end_date)
	management_data = get_management_data(start_date, end_date)
	plot_dates(start_date, end_date)

	return render_template('index.html', trait_data=trait_data, management_data=management_data,
											start_date=start_date, end_date=end_date)

if __name__ == '__main__':
	app.run()
