#!/usr/bin/env python
# Python Port Scanner

import socket

iprange = raw_input('Enter IP Address Range: ')
portrange = input('Enter Port Range: ')

if "-" in iprange:
	ipAddr = iprange.split("-")
	print ipAddr

#elif "/" in iprange:
        
else:
        print("Enter Correct IP Range")

