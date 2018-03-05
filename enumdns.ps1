# DNS Enumeration Tool
# Connor Dudarchik
# Usage: enumdns input_file


if(!($args[0] | Test-Path)) # Check if the file exists
{
	Write-Host ("Supplied file does not exist.")
	Write-Host ("Usage: enumdns input_file")
	exit
}
foreach($line in Get-Content $args[0])
{
	$actualaddr = 1
	Try
	{
		$addresses = [System.Net.Dns]::GetHostAddresses($line)
	}
	Catch
	{
		$actualaddr = 0
	}
	if($actualaddr -eq 1)
	{
		$hostobj = New-Object psobject -Property @{
				HostName = $line
				IPv4 = $addresses | Select-String -Pattern '(\d{1,3}\.){3}(\d{1,3})'
				# Looks up the host name and uses a regular expression to get the IPv4 address.
				# Though the regex doesn't protect against things like '987.789.483.920', it should
				# never receive that as input.
				IPv6 = $addresses | Select-String -Pattern ':'
				# This is a bit cheesier but it works.
		}
	}
	else
	{
		$hostobj = New-Object psobject -Property @{
				HostName = $line
				IPv4 = "XXXXX"
				IPv6 = "XXXXX"
		}
	}
	$hostobj | Format-Table HostName, IPv4, IPv6
}
