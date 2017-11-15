#!/bin/bash

output_file="/gpfs/largeblockFS/projects/arpae/terraref/users/dlebauer/dataset_count_report.txt"

echo $(date) > ${output_file}

## UA-MAC Level 1 ##
mac_lev1=(envlog_netcdf fullfield ir_geotiff laser3d_heightmap laser3d_ply2las rgb_geotiff scanner3DTop vnir_netcdf)

for s in ${mac_lev1[@]}
do
	dates=$(ls /gpfs/largeblockFS/projects/arpae/terraref/sites/ua-mac/Level_1/${s}/)
	for d in ${dates[@]}
	do
		count=$(find /gpfs/largeblockFS/projects/arpae/terraref/sites/ua-mac/Level_1/${s}/${d}/ -type d | wc -l)
		echo "${s},${d},${count}" >> ${output_file}
	done
done

## UA-MAC RAW ##

mac_raw=(EnvironmentLogger SWIR VNIR flirIrCamera irrigation lightning scanner3DTop stereoTop weather)

for s in ${mac_raw[@]}
do
    dates=$(ls /gpfs/largeblockFS/projects/arpae/terraref/sites/ua-mac/raw_data/${s}/)
    for d in ${dates[@]}
    do
        count=$(find /gpfs/largeblockFS/projects/arpae/terraref/sites/ua-mac/raw_data/${s}/${d}/ -type d | wc -l)
        echo "${s},${d},${count}" >> ${output_file}
    done
done
chown 47852 ${output_file}
