import os
import re
import subprocess
import time

# use absolute path to the speedtest-cli to support running this script from a cronjob
response = subprocess.Popen('/usr/local/bin/speedtest-cli --csv --csv-delimiter ";"', shell = True, stdout = subprocess.PIPE).stdout.read()

values = response.split(';')

serverID = values[0] # speedtest server id
sponsor = values[1]
servername = values[2]
timestamp = values[3]
distance = values[4]
ping = values[5] # ping in ms
download = values[6] # download in b/s
upload = values[7]
share = values[8] # drop this value
ip = values[9]

download =  float(download) / pow(2,10) # convert downlink to kbps
upload =  float(upload) / pow(2,10) # convert uplink to kbps

print '{};{};{};{};{};{};{};{};{}'.format(timestamp, download, upload, ping, serverID, sponsor, servername, distance, ip)
