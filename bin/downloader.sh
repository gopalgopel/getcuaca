#!/bin/bash

# Free Parameter
# interval=3
# num_days=1
delay_per_link=5

# contoh url = http://nomads.ncep.noaa.gov/cgi-bin/filter_wave_multi.pl?file=multi_1.glo_30mext.t00z.f000.grib2&lev_surface=on&var_DIRPW=on&var_HTSGW=on&var_UGRD=on&var_VGRD=on&leftlon=0&rightlon=359&toplat=90&bottomlat=-77&dir=%2Fmulti_1.20160315
url_noaa='http://nomads.ncep.noaa.gov/cgi-bin/filter_wave_multi.pl?file=multi_1.glo_30mext.t00z.f000.grib2&lev_surface=on&var_DIRPW=on&var_HTSGW=on&var_UGRD=on&var_VGRD=on&leftlon=0&rightlon=359&toplat=90&bottomlat=-77&dir=%2Fmulti_1.'
output_directory='/var/www/html/getcuaca/bin/hasil'
output_backup='/var/www/html/getcuaca'
user_agent='Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/43.0.2357.125 Safari/537.36'
# json_files=(
#     'wind-surface.json'
#     'temp-surface.json'
#     'waves-surface.json'
#     'pressure-highs-lows.json'
#     'pressure-surface.json'
# )

# CONSTANT
# MIN_HOUR=0
# MAX_HOUR=23
# DATE=$(date +"%Y%m%d" )
# DOMAIN=www.windyty.com

# FUNCTION
download_grib_convert () {
    date_url=$(date +%Y%m%d -d "$1")
    saved_file=$(date +%Y%m%d -d "$1")


    # for jfile in ${json_files[@]}; do
    #     if [ $jfile = "waves-surface.json" ]; then
    #         prefix_url='waves'
    #     else
    #         prefix_url='gfs'
    #     fi

        # full_url=$(printf "https://%s/%s/%s/%s/%s" $DOMAIN $prefix_url $date_url $2 $jfile)
        full_url=$(printf "%s%s" $url_noaa $date_url )        
        output_path=$(printf "%s/%scuaca.grib2" $output_directory $saved_file )
        output_path_backup=$(printf "%s/%scuacadb.bckup" $output_backup $saved_file )
        output_path_terkini=$(printf "%s/gempaterkini.xml" $output_directory)
        output_path_autogempa=$(printf "%s/gempaauto.xml" $output_directory)
	output_path_dirasakan=$(printf "%s/gempadirasakan.xml" $output_directory)

        printf " \n"
        printf "Downloading to %s\n"  $output_path
        printf "from %s\n"  $full_url

    #pke wget klo dirun di ubuntu 14 
        #wget --secure-protocol=TLSv1 --user-agent='$user_agent' -O $output_path $full_url

    #pke curl klo dirun di ubuntu 12, wget version < 1.15
    # pg_dump -Fc -h localhost -U postgres puskodal30maret > $output_path
    # pg_dump -Fc -h 192.168.254.67 -U postgres puskodal1 > $output_path_backup
    curl --tlsv1 --connect-timeout 30 -s -o $output_path $full_url
    
    printf "Download data gempa dari BMKG!\n"  
    curl --tlsv1 --connect-timeout 30 -s -o $output_path_terkini  http://data.bmkg.go.id/gempaterkini.xml
    curl --tlsv1 --connect-timeout 30 -s -o $output_path_autogempa  http://data.bmkg.go.id/autogempa.xml
    curl --tlsv1 --connect-timeout 30 -s -o $output_path_dirasakan  http://data.bmkg.go.id/gempadirasakan.xml
    
        sleep $delay_per_link

    fullsavedfile=$(printf "%scuaca.grib2" $saved_file )
    fullfile=$(printf "cuaca.json")
    
    printf " \n"
    printf "convert %s to %s\n"  $fullsavedfile $fullfile
    /var/www/html/getcuaca/bin/grib2json -d -n -v -o $output_directory/$fullfile $output_directory/$fullsavedfile
    printf "converting is DONE!\n"  
    # done
}

# MAIN PROGRAM
# max_days=$(expr $num_days - 1)
# for i in $(seq 0 $max_days); do
    # date=$(date +%Y/%m/%d -d "${start_date}+${i} days")    
    # date=$(date +%Y/%m/%d -d "-1 day")    
    date=$(date +%Y/%m/%d) 

    # for (( num=$MIN_HOUR; num<=$MAX_HOUR; num+=$interval )); do
        # hour=$(printf "%02d" $num)
        download_grib_convert $date         
    # done
# done
