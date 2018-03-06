# DNS Enumeration Tool
# Connor Dudarchik
# Usage: enumdns input_file


if(!($args[0] | Test-Path)) # Check if the file exists
{
	Write-Host ("Supplied file does not exist.")
	Write-Host ("Usage: \.enumdns input_file")
	exit
}

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
		Write-Host "$line FINDS $addresses`n"
	}
	else # If there was an error in getting IP addresses
	{
		Write-Host "$line FAILED.`n"
	}
}
