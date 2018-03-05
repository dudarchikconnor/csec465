# DNS Enumeration Tool
# Connor Dudarchik
# Usage: enumdns input_file


if(!($args[0] | Test-Path)) # Check if the file exists
{
	Write-Host ("Supplied file does not exist.")
	Write-Host ("Usage: enumdns input_file")
	exit
}
Write-Host ("Host Name`t`tIPv4 Address`t`t`tIPv6Address")
foreach($line in Get-Content $args[0])
{
	$host = New-Object newhost -Property @{
		Try
		{
			IPv4 = [System.Net.Dns]::GetHostAddresses($line) | Select-String -Pattern '(\d{1,3}\.){3}(\d{1,3})'
			# Looks up the host name and uses a regular expression to get the IPv4 address.
			# Though the regex doesn't protect against things like '987.789.483.920', it should
			# never receive that as input.
			IPv6 = [System.Net.Dns]::GetHostAddresses($line) | Select-String -Pattern ':'
			# This is a bit cheesier but it works.
		}
		Catch
		{
			IPv4 = "XXXXX"
			IPv6 = "XXXXX"
		}
	}
	$host | Format-Table IPv4, IPv6
	#$ipaddr = [System.Net.Dns]::GetHostAddresses($line) # Retrieve IPv4 and IPv6 addresses
	#Write-Host ($line + "`t`t" + $ipaddr) | Format-Table -Property IPAddressToString
}
