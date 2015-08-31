

## Use cases / API

query function 
 input: location, start, end, genotype, data product (sensor, trait)
 output: location of data files

# PlantCV installation and demonstration

## Install Dependencies

```sh
ssh 141.142.204.130

apt-get update

# Install software dependencies
apt-get install build-essential unzip cmake libgtk2.0-dev python-dev python-numpy python-gtk2 python-matplotlib libavcodec-dev libavformat-dev libswscale-dev libdc1394-22 libjpeg-dev libpng-dev libjasper-dev libtiff-dev libtbb-dev sqlite3
```

### OpenCV

```sh
# This tutorial assumes you clone OpenCV to /tools/
git clone https://github.com/Itseez/opencv.git
cd opencv

# Checkout release 2.4.8 (highest version tested)
git checkout 2.4.8

cd build
cmake -D CMAKE_BUILD_TYPE=RELEASE -D WITH_TBB=ON ../
make
make install
```


## Install PlantCV

```sh
cd /tools/
git clone https://github.com/danforthcenter/plantcv.git

# append plantcv directory to $PYTHONPATH (in bash profile) 
echo "export PYTHONPATH=$PYTHONPATH:/tools/plantcv/lib" >> ~/.profile

source .profile

```

```

## Download an example dataset

* downloaded to `/data/`
 
```sh
wget http://bioinformatics.danforthcenter.org/phenotyping/fahlgren_et_al_2015_bellwether_jpeg.tar.gz
tar xvf falghren* -o fahlgren_et_al_2015_bellwether_jpeg
```


## Example extraction

* example pipelines for specific zoom levels at Danforth indoor field system.
* vis camera, side view, at 3500 zoom

The second argument `-p filename` reflects the existance of many very similar files in which the masking thresholds are set by calibration. This could be re-factored to take the image type, camera id, and settings (zoom) as parameters. In addition, we could either use 'dynamic thresholding' or machine learning to perform segmentation.

```sh
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

File locations exported from lemnatec system: `/data/pgftp/<databasename>/YYYY-MM-DD/blob<1..n>`

getting data from Danforth lemnatec system

1. Phenofront query generates url that submits a query, launches processing,  
2. wget from url


# Notes

* most of the PlantCV scripts are used to generate masks of the plant

Is it possible to auto-parameterize thresholds other values? 
Or segment w/ machine learning algorithm 

 
https://hub.docker.com/r/schickling/opencv/~/dockerfile/

## Lemnatec field

  * 


