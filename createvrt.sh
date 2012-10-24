#!/bin/bash
#The DuKode Studio 2012
#author ilias koen
#desc: generate vrt and start tiling 
#STEP 1: will process precombined bands 
#STEP 2: will process bands seperately 

#ex .createvrt mycompiledimages/

#################################################################################

#################################////////////////////////////////////////////////////////////
# declare variables 
#################################////////////////////////////////////////////////////////////
args=("$@")
NUM1=$#
NUM2=2
#vrtfile name
VRTFILENAME="myvrt.vrt"
#The directory for image to be compiled VRT. 
ARG_DIRECTORY=${args[0]}

#results directory for storage of vrt
 RESULTS_DIR = "Documents"
# if [ -d $RESULTS_DIR ]; then 
# 		echo "the directory exists! thanks for being right..."
# 	else
# 		;
# fi
# mkdir $TEMPDIR

#################################////////////////////////////////////////////////////////////
# check for argument directory structures. 
#################################////////////////////////////////////////////////////////////

if [ -d $ARG_DIRECTORY ]; then 
		echo "the directory exists! thanks for being right..."
fi

#################################////////////////////////////////////////////////////////////
# list images directorys present in arg_directory
#################################////////////////////////////////////////////////////////////
cd $ARG_DIRECTORY/
FILES=*
TILEDIRARRAY=(`echo $FILES`)
echo "#################################"
echo "SELECT FILE TO DOWNLOAD\n"
n=0
for i in ${TILEDIRARRAY[@]}; do
 	echo "["."$(( n += 1 ))"."]" " $i"
 done
TILEDIRARRAYlength="$n"
echo "$n"
cd .. 

#################################////////////////////////////////////////////////////////////
# process 321 band 
#################################////////////////////////////////////////////////////////////
#georeference the image 
#gdal_translate -of VRT -a_srs EPSG:4326 -gcp 0 0 -180 90 -gcp 21600 0 180 90 -gcp 21600 10800 180 -90 world_200401.jpg $VRTFILENAME


#wrap the image 
#gdalwarp -of VRT -t_srs EPSG:4326 $ARG_DIRECTORY/${TILEDIRARRAY[2]}/321.tif $ARG_DIRECTORY/${TILEDIRARRAY[1]}/321.tif $VRTFILENAME
gdalbuildvrt $VRTFILENAME  $ARG_DIRECTORY/${TILEDIRARRAY[2]}/321.tif $ARG_DIRECTORY/${TILEDIRARRAY[1]}/321.tif


#generate tiles 
#python gdal2tiles.py -p geodetic -k $VRTFILENAME $RESULTS_DIR
#GDAL PATH 
#/Library/Frameworks/GDAL.framework/Versions/1.9/Programs/gdal2tiles.py

python /Library/Frameworks/GDAL.framework/Versions/1.9/Programs/gdal2tiles.py -z 7 -a 0,0,0 $VRTFILENAME $RESULTS_DIR