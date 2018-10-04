# MAIN PROGRAM
    
    # rename cuaca.json jadi tanggal kemarin
    saved_file=$(date +%Y%m%d -d "1 day ago")
    fullsavedfile=$(printf "%scuaca.json" $saved_file )
    printf " \n"
    printf "renaming cuaca.json to %s\n"  $fullsavedfile 
    mv /var/www/html/getcuaca/bin/hasil/cuaca.json /var/www/html/getcuaca/bin/hasil/$fullsavedfile 

    # hapus data 30hr lalu
    printf "hapus data cuaca 30 hari yg lalu\n"
    find /var/www/html/getcuaca/bin/hasil -mtime +30 -exec rm {} \;
