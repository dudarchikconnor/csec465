# Zhi-Han Ling
# Python Port Scanner

import socket

iprange = raw_input('Enter IP Address Range: ')
portrange = input('Enter Port Range: ')

if "-" in iprange:
	ipAddr = iprange.split("-")
	print ipAddr

#elif "/" in iprange:
        
else:
	ipAddr = iprange
	
if "-" in portrange:
	port = portrange.split("-")
	print port

else:
	port = portrange

def pScan(ip, port):
	sock = socket.socket(AF_INET, socket.SOCK_STREAM)
	