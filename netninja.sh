#!/bin/bash
clear

echo -e "\033[1;32m"
toilet -f mono12 --metal "NetNinja"
echo -e "\033[1;31mNetworking made Simple!!                    By:Mhd.Akbar\033[0m"
echo "version 2.0 , more tools will be added!!"
echo "select an option:"
echo "[1] Network discovery"
echo "[2] Port + Services"
echo "[3] Quick scan"
echo "[4] OS detection"
echo "[5] UDP scan"
echo "[6]Subnet calculator"
echo "[7] Exit"
echo "Enter a valid choice:"
read choice
get_target() {
    echo -ne "\033[1;33mEnter target IP/Domain: \033[0m"
    read target

    if [ -z "$target" ]; then
        echo -e "\033[1;31mERROR: Target cannot be empty!\033[0m"
        return 1
    fi

    if ! command -v nmap &> /dev/null; then
        echo -e "\033[1;31mERROR: nmap is not installed!\033[0m"
        return 1
    fi

    return 0
}

case $choice in
1)
    echo "Network discovery (-sn)"
    get_target || break
    sudo nmap -sn "$target"
    ;;
2)
    echo "Port and Service (-sS -sV)"
    get_target || break
    sudo nmap -sS -sV -T4 "$target"
    ;;
3)
    echo "Quick scan (-F)"
    get_target || break
    sudo nmap -F -T4 "$target"
    ;;
4)
    echo "OS detection (-A)"
    get_target || break
    sudo nmap -A -T4 "$target"
    ;;
5)
    echo "UDP scan (-sU)"
    get_target || break
    sudo nmap -sU -p 53,67,68,69,123,137,161,162 "$target"
    ;;

6)
    echo "Enter an IP with CIDR (example: 192.168.1.200/24)"
    read -r input

    ip=${input%/*}
    cidr=${input#*/}

    IFS='.' read -r o1 o2 o3 o4 <<< "$ip"

    ip_int=$(( (o1 << 24) | (o2 << 16) | (o3 << 8) | o4 ))
    mask=$(( 0xFFFFFFFF << (32 - cidr) & 0xFFFFFFFF ))
    network=$(( ip_int & mask ))
    broadcast=$(( network | (~mask & 0xFFFFFFFF) ))

    first=$(( network + 1 ))
    last=$(( broadcast - 1 ))

    host_bits=$(( 32 - cidr ))
    total_hosts=$(( (1 << host_bits) - 2 ))

    int_to_ip() {
      echo "$(( ($1 >> 24) & 255 )).$(( ($1 >> 16) & 255 )).$(( ($1 >> 8) & 255 )).$(( $1 & 255 ))"
    }

    echo
    echo "----- SUBNET CALCULATION -----"
    echo "IP Address       : $ip/$cidr"
    echo "Subnet Mask      : $(int_to_ip $mask)"
    echo "Network Address  : $(int_to_ip $network)"
    echo "Broadcast Address: $(int_to_ip $broadcast)"
    echo "Usable Range     : $(int_to_ip $first) - $(int_to_ip $last)"
    echo "Total Hosts      : $total_hosts"
    ;;









    *)
        echo -e "\033[1;31mInvalid choice!\033[0m"
        exit 1
        ;;
esac
