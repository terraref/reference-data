## Use cases / API

query function 
 input: location, start, end, genotype, data product (sensor, trait)
 output: location of data files

## Example data

* download data to 141.142.204.139:/data/

```sh
wget http://bioinformatics.danforthcenter.org/phenotyping/fahlgren_et_al_2015_bellwether_jpeg.tar.gz
tar xvf falghren* -o fahlgren_et_al_2015_bellwether_jpeg
```

output data will look like 

### Installing PlantCV

* install in 141.142.204.130:/tools/

```sh
# Update the system
apt-get update

# Install software dependencies
apt-get install build-essential unzip cmake libgtk2.0-dev python-dev python-numpy python-gtk2 python-matplotlib libavcodec-dev libavformat-dev libswscale-dev libdc1394-22 libjpeg-dev libpng-dev libjasper-dev libtiff-dev libtbb-dev sqlite3

# Install OpenCV
# Here we demonstrate using Git but you can alternatively download the package from SourceForge. This tutorial assumes you clone OpenCV to /home
git clone https://github.com/Itseez/opencv.git
cd opencv

# Checkout release 2.4.8 (highest version tested)
git checkout 2.4.8

cd build
cmake -D CMAKE_BUILD_TYPE=RELEASE -D WITH_TBB=ON ../
make
make install

# Install PlantCV
# This tutorial assumes you clone PlantCV to /home
git clone https://github.com/danforthcenter/plantcv.git

# Edit your BASH profile to include the OpenCV and PlantCV libraries. Use your favorite editor to edit .profile and add the following line:
echo "export PYTHONPATH=$PYTHONPATH:/tools/plantcv/lib" >> ~/.profile

# Reload your BASH profile
source .profile

```

most of these scripts are in the masking of the plant

example pipelines for specific zoom levels at Danforth indoor field system.

Is it possible to auto-parameterize thresholds other values? 
Or segment w/ machine learning algorithm 

```
cd /tools/plantcv/scripts/dev/

./image_analysis.py -d /data/fahlgren_et_al_2015_bellwether_jpeg/ \
  -p /tools/plantcv/scripts/image_analysis/vis_sv/vis_sv_z3500_L1.py -s /output/testrun.sqlite \
  -i /output/ \
  -T 1 \
  -c -t jpg \
  -r -n 10 \
  -f imgtype_camera_frame_zoom_id -l _ \
  -M imagetype:VIS,camera:SV,zoom:z3500

```
## Lemnatec System at Danforth

File locations exported from lemnatec system:

/data/pgftp/<databasename>/YYYY-MM-DD/blob<1..n>

getting data from Danforth lemnatec system

1. Phenofront query generates url that submits a query, launches processing,  
2. wget from url

https://hub.docker.com/r/schickling/opencv/~/dockerfile/

## Lemnatec field

* dynamic thresholding
* machine learning segmentation, have users recognize plants 
  * 


