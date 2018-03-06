import sys
from scapy.all import *

interface  = raw_input(">>>Enter interface to scan: ")
if(len(interface)==0):
	print "No interface specified, exiting..."
	sys.exit(1)

portOrType = raw_input("Type packet or port to filter for them, press enter if no filter: ")
if (portOrType.upper() == "PACKET"):
	filtering = ""
	count = 0
	print ">>>Enter packet type to filter for, or enter to move on:"
	while(True):
		filType = raw_input(">>>")
		if(len(filType)>0):
			if(count > 0):
				filtering += " and "
			filtering += filType
			count+=1
		else:
			break

elif(portOrType.upper() == "PORT"):
	filtering = ""
	count = 0
	print ">>>Enter TCP ports to filter for, or enter to move on:"
	while(True):
		port = raw_input(">>>")
		if(len(port)>0):
			if(count == 0):
				filtering += "tcp and ("
			if(count > 0):
				filtering += " or "
			filtering += "port " + port
			count+=1
		else:
			if(count > 0):
				filtering += ")"
			break

elif(portOrType.upper() != ""):
	print "Invalid input, exiting..."
	sys.exit(1)

else:
	filtering = ""

print filtering
duration = raw_input(">>>Enter duration of search (default=5): ")
if(duration == ""):
	duration = 5
else:
	duration = int(duration)

print "\n[*] Sniffing"
packets = sniff(iface=interface, filter=filtering, timeout=duration, count=0, prn=lambda x: x.summary())
wrpcap('packets.pcap', packets)
