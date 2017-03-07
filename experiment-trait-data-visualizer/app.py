from api_data_retrieval.trait_data_retrieval import get_trait_data
from api_data_retrieval.management_data_retrieval import get_management_data
from api_data_retrieval.variable_date_plotter import plot_dates

from flask import Flask, render_template
from flask_bootstrap import Bootstrap

app = Flask(__name__)
boostrap = Bootstrap(app)

@app.route('/')
def data_summary():
	trait_data = get_trait_data(2016, 8, 12)
	management_data = get_management_data(2016, 8, 12)
	plot_dates(2016, 8, 12)

	return render_template('index.html', trait_data=trait_data, management_data=management_data)

if __name__ == '__main__':
	app.run()
