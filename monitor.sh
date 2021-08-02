#! /bin/bash

# Cleanup

unset textreset date os_type os_name loadaverages uptime

# Easy text formatting reset

textreset=$(tput sgr0)

# Date

date=$(date)
echo -e '\E[32m'"Time of Report:" $textreset $date

# OS Details

  #OS Type

  os_type=$(uname -o)
  echo -e '\E[32m'"OS Type:" $textreset $os_type
  
  #OS Name (UBUNTU Only)

  os_name=$(awk -F "PRETTY_NAME=" '{print $2}' /etc/os-release | tr -d '\n"')
  echo -e '\E[32m'"OS Type:" $textreset $os_name

# Disk Space Check

df -h | grep 'Filesystem\|/home' > /tmp/diskspace_check
echo -e '\E[32m'"Disk Space Usage:" $textreset
cat /tmp/diskspace_check

# RAM Check

free -h > /tmp/ram_check
echo -e '\E[32m'"Current RAM Usage:" $textreset
grep -v "Swap" /tmp/ram_check

# Load Averages Check

loadaverages=$(uptime | awk '{print $10" "$11" "$12}')
echo -e '\E[32m'"Load Averages:" $textreset $loadaverages

# Uptime Check

uptime=$(uptime | awk '{print $3" "$4" "$5}' | sed 's/.$//')
echo -e '\E[32m'"Uptime (Days, HH:MM):" $textreset $uptime

# Cleanup

unset textreset date os_type os_name loadaverages uptime
rm /tmp/diskspace_check /tmp/ram_check
