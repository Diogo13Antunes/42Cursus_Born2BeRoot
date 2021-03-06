#Here you get the total memory of your VM.
#The %0.f is a moddifier for the float number.
#Awk is a scripting language used for manipulating data and generating reports.
#Mem is the memory information local.
#With the command free you get access to all your memory information.
#In printf we devide for 1024 because 1GB is about 1024MB and we are simply converting for GB.
MEM_TOTAL=$(free | awk '/Mem/ {printf("%0.f\n", $2 / 1024)}')
#Here you get the used memory of your VM.
MEM_USED=$(free | awk '/Mem/ {printf("%0.f\n", $3 / 1024)}')
#Here you get the used memory of your VM. But in form of a percentage number.
#The %.2f is a precision modifier for the float number.
#The last part of printf '($1 / $2) * 100)' makes the conversion for percentage type.
MEM_USED_PERCENT=$(echo "$MEM_USED $MEM_TOTAL" | awk '{printf ("%.2f", ($1 / $2) * 100)}')

#At this point you get the DISK_USED value in GB.
DISK_USED=$(df --output=used | tail --lines=+2 | paste -sd+ | bc | awk '{printf("%.0f\n", $1 / 1024)}')
#Here you have the MB available in your DISK.
DISK_AVAIL_MB=$(df --output=avail | tail --lines=+2 | paste -sd+ | bc | awk '{printf("%.0f\n", $1 / 1024)}')
#Here you have the GB available in your DISK geted by converting the DISK_AVAIL_MB to GB.
DISK_AVAIL_GB=$(echo "$DISK_AVAIL_MB" | awk '{printf ("%d", ($1 / 1024))}')
#Finaly you get the percentage of space available in your DISK in form of percentage.
DISK_AVAIL_PERCENT=$(echo "$DISK_USED $DISK_AVAIL_MB" | awk '{printf ("%.2f", ($1 / $2) * 100)}')

#With this command you get the exact day and time of your LAST_BOOT.
#The Last Boot is the time VM was rebooted.
LAST_BOOT=$(uptime -s)
#You make this command to hide the 3 last digits witch correspond to the seconds of LAST_BOOT.
LAST_BOOT=${LAST_BOOT::-3}

#Here you see how many LVM (Logical Volume Manager) you have.
LVM_COUNT=$(lsblk -o TYPE | grep lvm | wc -l)
#Define the Variable to "no".
HAS_LVM="no"
#If you have more than 0 LVM the variable turns in to a "yes".
if [[ "$LVM_COUNT" > 0 ]]
then
        HAS_LVM="yes"
fi

#At this point you are going to print all information on the screen.
#You do all this stuff using 'echo' function.

#With "whoami" (Who Am I) you get all your machine stuff like IP and stuff like that.
#With "'hostnamectl | awk '/Static hostname/ {print $3}'".
#With "date" your today info.
echo "Broadcast message from" $(whoami)"@"$(hostnamectl | awk '/Static hostname/ {print $3}') "("$(tty | awk -F/ '{print $3}')")" $(date)
#Using "uname -a" you get all Architecture info.
echo "#Architecture: " $(uname -a)
#here you are printing the CPU info.
echo "#CPU physical :" $(cat /proc/cpuinfo | grep 'physical id' | sort -u | wc -l)
#Here you print the number of processing units available.
echo "#vCPU :" $(nproc)
#Here you are printing the memory usage in MB and in percentage.
echo "#Memory Usage:" "${MEM_USED}/${MEM_TOTAL}MB" "($MEM_USED_PERCENT%)"
#Here you are printing the disk usage.
echo "#Disk Usage:" "${DISK_USED}MB/${DISK_AVAIL_GB}GB" "($DISK_AVAIL_PERCENT%)"
#Here you print the CPU load in percentage.
echo "#CPU load:" $(grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {printf("%.2f%%\n", usage)}')
#Here you print the last time you reboot your machine.
echo "#Last boot: $LAST_BOOT"
#Here paste if you have any LVM (Logical Volume Manager).
echo "#LVM: $HAS_LVM"
#Here you print your TCP Connections.
echo "Connections TCP:" $(grep '^ *[0-9]\+: [0-9A-F: ]\{27\} 01 ' /proc/net/tcp -c) "ESTABLISHED"
#Print how many users is logged into your machine.
echo "#User log:" $(who | awk '{print $1}' | sort -u | wc -l)
#This is used to print your network IP.
echo "#Network: IP" $(hostname -I | awk '{print $2}') "("$(ip a | grep ether | tail -n 1 | awk '{print $2}')")"
#You print the Sudo log.
echo "#Sudo : $(cat /var/log/sudo/sudo.log | grep -c COMMAND) cmd"


# USEFULL INFO

# Command -> awk
# Awk is a utility that enables a programmer to write tiny but effective programs in the form of statements that define text patterns that are to be searched for in each line of a document and the action that is to be taken when a match is found within a line.

# Command -> grep
# Print lines that match patterns.

# Command -> uname
# Is a command-line utility that prints basic information about the operating system name and system hardware.
# Is most commonly used to determine the processor architecture, the system hostname and the version of the kernel running on the system.

# Command -> nproc
# Print the number of processing units available.

# Command -> hostname
# Is used to obtain the DNS (Domain Name System) name.

# Command -> who
# The who command is used to get information about currently logged in user on to system.

# Abbreviations
# GB -> GigaBytes
# MB -> MegaBytes

# Conversions
# 1 GB = 1024 MB

# Convert to percentage
# Number / 100
