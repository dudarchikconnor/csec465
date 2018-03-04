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

for i in ipAddr:
	print("IP Addess is: ", i)
	openPorts[]
	for p in port:
		openClose = pScan(i,p)
		if openClose == True:
			openPort.append(i)
		else:
			break
	print "Open ports are: "
	for x in openPort:
		print(x, ", ")
	
def pScan(ip, port):
	openPort
	sock = socket.socket(AF_INET, socket.SOCK_STREAM)
	try:
		result = sock.connect(ip, port)
		return True
	except:
		return False

