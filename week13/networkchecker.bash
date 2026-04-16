#!/bin/bash

myIP=$(bash myIP.bash)

function helpmenu(){
  echo ""
  echo "HELP MENU"
  echo ""
  echo "-n: Add -n as an argument for this script to use nmap"
  echo "-n external: External NMAP scan"
  echo "-n internal: Internal NMAP scan"
  echo ""
  echo "-s: Add -s as an argument for this script to use ss"
  echo "-s external: External ss(Netstat) scan"
  echo "-s internal: Internal ss(Netstat) scan"
  echo ""
  echo "Usage: bash networkchecker.bash -n/s external/internal"
  echo ""
  exit 1
}

function ExternalNmap(){
  nmap "$myIP" | awk -F"[/[:space:]]+" '/open/ {print $1,$4}'
}

function InternalNmap(){
  nmap localhost | awk -F"[/[:space:]]+" '/open/ {print $1,$4}'
}

function ExternalListeningPorts(){
  ss -ltpn | awk -F"[[:space:]:(),]+" -v ip="$myIP" '$5 ~ ip {print $5,$9}' | tr -d "\""
}

function InternalListeningPorts(){
  ss -ltpn | awk -F"[[:space:]:(),]+" '/127.0.0./ {print $5,$9}' | tr -d "\""
}

# must have exactly 2 args
if [ $# -ne 2 ]; then
  helpmenu
fi

while getopts ":n:s:" opt; do
  case $opt in
    n)
      if [ "$OPTARG" == "external" ]; then
        ExternalNmap
      elif [ "$OPTARG" == "internal" ]; then
        InternalNmap
      else
        helpmenu
      fi
      ;;
    s)
      if [ "$OPTARG" == "external" ]; then
        ExternalListeningPorts
      elif [ "$OPTARG" == "internal" ]; then
        InternalListeningPorts
      else
        helpmenu
      fi
      ;;
    *)
      helpmenu
      ;;
  esac
done
