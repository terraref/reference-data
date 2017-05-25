# Experiment Trait Data Visualizer
### A web interface for exploring BETYdb data.

The Experiment Trait Data Visualizer receives data from the [BETYdb API](https://pecan.gitbooks.io/betydb-data-access/content/).
The code for retrieving and handling this data can be found in the api_data_retrieval directory.

The code for calling the API requires the environmental variable `BETYdbKey` be set.

[Pygal](http://pygal.org/en/stable/) is used to generate box plot visualizations for each variable in the traits endpoint of the BETYdb API.
The code for generating these visualizations is in api_data_retrieval/variable_data_plotter.py.

The web interface is served as a [Flask](http://flask.pocoo.org/) application.
It serves svgs rendered by Pygal for each variable, as well as a timeline made from data in the managements enpoint of the BETYdb API.

To run on development server:

`pip install -r requirements.txt`

`python3 app.py`
