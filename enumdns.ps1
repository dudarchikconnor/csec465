# DNS Enumeration Tool
# Connor Dudarchik
# Usage: enumdns input_file

# Checking to see if file exists
if(!($args[0] | Test-Path))
{
	Write-Host ("Supplied file does not exist.")
	Write-Host ("Usage: enumdns input_file")
	exit
}
foreach($line in Get-Content $args[0])
{
	$test = nslookup $line | Out-String
	Write-Host ($test)
}
