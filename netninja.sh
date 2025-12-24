#!/bin/bash
clear

echo -e "\033[1;32m"
figlet -f standard "NetNinja"
echo -e "\033[0m"
echo -e "\033[1;31mNetworking made Simple :)                    {Author:Mhd._.akbar}\033[0m"
echo "version 1.0 , more tools will be added!!"
echo "select an option:"
echo "[1] Network discovery"
echo "[2] Port + Services"
echo "[3] Quick scan"
echo "[4] OS detection"
echo "[5] UDP scan"
echo "[6] Exit"

echo -ne "\033[1;33m NetNinja:~# \033[0m"
read choice

if [ "$choice" = "6" ]; then
    echo -e "\033[1;32mGoodbye!\033[0m"
    exit 0
fi

echo -ne "\033[1;33mEnter target IP/Domain: \033[0m"
read target

if [ -z "$target" ]; then
    echo -e "\033[1;31mERROR: Target cannot be empty!\033[0m"
    exit 1
fi

if ! command -v nmap &> /dev/null; then
    echo -e "\033[1;31mERROR: nmap is not installed!\033[0m"
    exit 1
fi

case $choice in
    1)
        echo "Network discovery (-sn)"
        sudo nmap -sn "$target"
        ;;
    2)
        echo "Port and Service (-sS -sV)"
        sudo nmap -sS -sV -T4 "$target"
        ;;
    3)
        echo "Quick scan (-F)"
        sudo nmap -F -T4 "$target"
        ;;
    4)
        echo "OS detection (-A)"
        sudo nmap -A -T4 "$target"
        ;;
    5)
        echo "UDP scan (-sU)"
        sudo nmap -sU -p 53,67,68,69,123,137,161,162 "$target"
        ;;
    *)
        echo -e "\033[1;31mInvalid choice!\033[0m"
        exit 1
        ;;
esac
