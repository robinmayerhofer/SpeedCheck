This repository contains the code and the setup process to build your own networking speed monitoring using linux and a few tools.

**Attention: There are many absolute paths in this repository that need to be adapted if your code does not reside under /home/pi/SpeedCheck and the gdrive executable does not lie under /home/pi**


# 1. Install
```
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install python-pip
sudo pip install speedtest-cli
```

# 2. Test Scripts

Test the Speedtest Command Line Interface:
`speedtest-cli --simple`

Test the python script:
`python /home/pi/SpeedCheck/speedtest.py`
--> should output some values separated by ;

Test the bash script:
should output the csv line to your console:
`/home/pi/SpeedCheck/speedtest-cron.sh`

should write the csv line into your csv file
`python /home/pi/SpeedCheck/speedtest.py >> /home/pi/SpeedCheck/SpeedMeasurements.csv`

# 3. Optional: Setup GoogleDrive

Download the gdrive executable (https://github.com/prasmussen/gdrive) and give it executable rights.
```
wget -O gdrive https://docs.google.com/uc?id=0B3X9GlR6EmbnVXNLanp4ZFRRbzg&export=download
chmod +x gdrive
./gdrive list
```

After the last command, Google Drive asks you for authentication via a link. You need to do this only once.
If you have been successfully authenticated, you can create a directory in the Google Drive, this returns an ID that we need to use in the `speedtest-cron.sh` if you want to use the google drive.

```
./gdrive mkdir SpeedCheck
./gdrive sync upload speedtest <ID>
```

# 4. Setup the cronjob

Use `crontab -e` to edit the configuration and enter the following line to run the bash script every full hour:
```
0 */1 * * * /home/pi/SpeedCheck/speedtest-cron.sh
```

# 5. Diagrams

To generate diagrams the repo contains an R script. 
You can add the generation of the diagrams to the bash script or run it in a separate cron job / manually.
To execute it and generate the pdf use `R < CreateDiagrams.R --no-save`.
The prerequisite here is, that you have R installed (r-base, r-recommended) as well as the `parsedate` package.