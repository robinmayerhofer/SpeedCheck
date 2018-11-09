# the script that should be run by the cronjob
# runs the speedtest, saves the results to the csv, then syncs the changes to the google drive
python /home/pi/SpeedCheck/speedtest.py >> /home/pi/SpeedCheck/SpeedMeasurements.csv
/home/pi/gdrive sync upload /home/pi/SpeedCheck <<YOUR GDRIVE FOLDER ID>>

