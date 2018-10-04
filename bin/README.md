WINDYTY DOWNLOADER
-------

This tiny bash script will scrapped all json from windyty sites.

Parameter

* interval: interval hour
* num_days: number of days, starting today
* delay_per_link: adding sleep before downloading next url
* output_directory: place for json output
* user_agent: user agent used by wget
* json_files: array of json files downloaded

Feature

* No repeated download. If files already downloaded, it won't be redownloaded again
* Flexible parameter for tuning

TODO

* Resume broken download. Currently, the program will skip file if it's already downloaded even it is incomplete




//////////
* NOTE NOTE!!
install curl for backup plan
