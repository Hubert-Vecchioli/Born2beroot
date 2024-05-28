# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    monitoring.sh                                      :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: hvecchio <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/05/28 11:08:21 by hvecchio          #+#    #+#              #
#    Updated: 2024/05/28 14:49:33 by hvecchio         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

CMD_ARCH=$(uname -a)
CMD_CPUP=$(lscpu | grep Socket | awk '{print $2}')
CMD_CPUV=$(nproc)
CMD_RAM_TOTAL=$(free -m | grep Mem | awk '{print $2}')
CMD_RAM_USED=$(free -m | grep Mem | awk '{print $3}')
CMD_RAM_PERC=$(free -k | grep Mem | awk '{printf("%.2f%%"), $3 / $2 * 100'})
CMD_DISK_TOTAL=$(df -h --block-size=G --total | grep total | awk '{print $2}'| cut -d G -f1)
CMD_DISK_USED=$(df -h --block-size=G --total | grep total | awk '{print $3}'| cut -d G -f1)
CMD_DISK_PERC=$(df -h --block-size=G --total | grep total | awk '{print $5}' | cut -d G -f1)
CMD_CPU_LOAD=$(mpstat | grep all | awk '{print $4 + $6}')
CMD_LAST_BOOT=$(who -b | awk '{print($3 " " $4)}')
CMD_LVM=$(if [ $(lsblk | grep lvm | wc -l) -eq 0 ]; then echo no; else echo yes; fi)
CMD_TCP=$(grep TCP /proc/net/sockstat | awk '{print $3}')
CMD_USERS_LOG=$(who | wc -l)
CMD_IP_ADDR=$(ip address | grep enp | grep inet | awk '{print $2}' | cut -d / -f1)
CMD_MAC_ADDR=$(ip address | grep enp -A 1 | grep ether | awk '{print $2}')
CMD_SUDO_LOG=$(grep COMMAND /var/log/sudo/sudo.log | wc -l)

printf "#Architecture: $CMD_ARCH\n"
printf "#CPU physical: $CMD_CPUP\n"
printf "#vCPU: $CMD_CPUV\n"
printf "#Memory Usage: $CMD_RAM_USED/$CMD_RAM_TOTAL%s ($CMD_RAM_PERC%%)" "MB"
printf ")"
printf "\n#Disk Usage: $CMD_DISK_USED/$CMD_DISK_TOTAL%s ($CMD_DISK_PERC%% )" "Gb"
printf ")"
printf "\n#CPU load: $CMD_CPU_LOAD%%"
printf "\n#Last boot: $CMD_LAST_BOOT\n"
printf "#LVM use: $CMD_LVM\n"
printf "#Connections TCP: $CMD_TCP ESTABLISHED\n"
printf "#User log: $CMD_USERS_LOG\n"
printf "#Network: IP $CMD_IP_ADDR ($CMD_MAC_ADDR)\n"
printf "#Sudo: $CMD_SUDO_LOG cmd\n"

