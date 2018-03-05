# DNS Enumeration Tool
# Connor Dudarchik
# Usage: enumdns input_file


if(!($args[0] | Test-Path)) # Check if the file exists
{
	Write-Host ("Supplied file does not exist.")
	Write-Host ("Usage: enumdns input_file")
	exit
}

# Create the table
$hostTable = "Host names and IP Addresses"
$table = New-Object system.Data.DataTable "$hostTable"
$col1 = New-Object system.Data.DataColumn HostName,([string]) # Create columns
$col2 = New-Object system.Data.DataColumn IPv4,([string])
$col3 = New-Object system.Data.DataColumn IPv6,([string])
$table.columns.add($col1) # Add the columns to the table
$table.columns.add($col2)
$table.columns.add($col3)

foreach($line in Get-Content $args[0])
{
	$actualaddr = 1
	Try
	{
		$addresses = [System.Net.Dns]::GetHostAddresses($line) # Retrieve IP addresses
	}
	Catch
	{
		$actualaddr = 0
	}
	if($actualaddr -eq 1) # If successful in getting IP addresses
	{
		$hostobj = New-Object psobject -Property @{ # Create a new object
				HostName = $line
				IPv4 = $addresses | Select-String -Pattern '(\d{1,3}\.){3}(\d{1,3})'
				# Looks up the host name and uses a regular expression to get the IPv4 address.
				# Though the regex doesn't protect against things like '987.789.483.920', it should
				# never receive that as input anyways.
				IPv6 = $addresses | Select-String -Pattern ':'
				# This is a bit cheesier but it works.
		}
	}
	else # If there was an error in getting IP addresses
	{
		$hostobj = New-Object psobject -Property @{ # Create a new object with custom fields
				HostName = $line
				IPv4 = "<INVALID HOST NAME>"
				IPv6 = "<INVALID HOST NAME>"
		}
	}
	$row = $table.NewRow() # Transfer data from object to a row in the table
	$row.HostName = $hostobj.HostName
	$row.IPv4 = $hostobj.IPv4
	$row.IPv6 = $hostobj.IPv6
	$table.Rows.Add($row)
}
$table | Format-Table -AutoSize
