import sys
from scapy.all import *

interface  = raw_input(">>>Enter interface to scan: ")
if(len(interface)==0):
	print "No interface specified, exiting..."
	sys.exit(1)

#filterType = raw_input(">>>Enter packet type to filter: ")
#ports      = raw_input(">>>Enter port to monitor for  : ")

filterType = []
count = 0
print ">>>Enter packet type to filter for, or enter to move on:"
while(True):
	filType = raw_input(">>>")
	if(len(filType)>0):
		if(count > 0):
			filterType.append(" and ")
		filterType.append(filType)
		count+=1
	else:
		break

ports = []
count = 0
print ">>>Enter TCP ports to filter for, or enter to move on:"
while(True):
	port = raw_input(">>>")
	if(len(port)>0):
		if(count == 0):
			ports.append("tcp and (")
		if(count > 0):
			ports.append(" or ")
		ports.append("port " + port)
		count+=1
	else:
		if(count > 0):
			ports.append(")")
		break

duration   = int(raw_input(">>>Enter duration of search (default=5)  : "))
if(duration == ""):
	duration = 5
	
completeFilter=""
for filType in filterType:
	completeFilter += filType
if(len(ports) > 0):
	completeFilter += " and "
for port in ports:
	completeFilter += port
print completeFilter	

print "\n[*] Sniffing"
packets = sniff(iface=interface, filter=completeFilter, timeout=duration, count=0, prn=lambda x: x.summary())
wrpcap('packets.pcap', packets)
