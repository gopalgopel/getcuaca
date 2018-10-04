#!/bin/bash

# Free Parameter
interval=1
delay_per_link=1

output_directory='/var/www/html/getcuaca/bin/hasil'
user_agent='Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/43.0.2357.125 Safari/537.36'
json_files=(
   'psf_'
   'sst_'
   'rain_'
   'cloud_'
)

# CONSTANT
MIN_HOUR=0
MAX_HOUR=23
DOMAIN=https://sadewa.sains.lapan.go.id

# FUNCTION
download_all_json () {

    for jfile in ${json_files[@]}; do
	prefix_url='wrf'


        full_url=$(printf "%s/%s/%s/%s%s_%s.png" $DOMAIN $prefix_url $2 $jfile $3 $1)
        # contoh: http://sadewa.sains.lapan.go.id/wrf/2018/01/03/rain_20180103_21.png

        output_path=$(printf "%s/%s%s.png" $output_directory $jfile $1)

        printf "Downloading to %s\n"  $output_path
        printf "from %s\n"  $full_url

	#pke curl klo dirun di ubuntu 12, wget version < 1.15
	curl --connect-timeout 30 -s $full_url > $output_path 

        sleep $delay_per_link
    done
}

# MAIN PROGRAM
    date=$(date +%Y/%m/%d) 
    dada=$(date +%Y%m%d) 
    for (( num=$MIN_HOUR; num<=$MAX_HOUR; num+=$interval )); do
        hour=$(printf "%02d" $num)
        download_all_json $hour $date $dada
    done

