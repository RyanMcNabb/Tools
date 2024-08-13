#This is a quick and dirty script to ingest a list of IPs to run a whoas. - Ryan McNabb

# Define the path to the input file containing the list of IP addresses
$inputFilePath = "C:\path\to\your\iplist.txt"

# Define the path for the output CSV file
$outputFilePath = "C:\path\to\your\whois_output.csv"

# Read the IP addresses from the file into a variable
$IPs = Get-Content -Path $inputFilePath

# Initialize an array to hold the WHOIS results
$whoisResults = @()

# Loop through each IP address and perform a WHOIS lookup
foreach ($ip in $IPs) {
    # Perform the WHOIS lookup
    $whoisInfo = whois $ip
    
    # Create a custom object to store the IP and its WHOIS information
    $result = [PSCustomObject]@{
        IPAddress = $ip
        WhoisInfo  = $whoisInfo
    }
    
    # Add the result to the results array
    $whoisResults += $result
}

# Export the results to a CSV file
$whoisResults | Export-Csv -Path $outputFilePath -NoTypeInformation -Force

Write-Host "WHOIS lookup completed. Results saved to $outputFilePath"