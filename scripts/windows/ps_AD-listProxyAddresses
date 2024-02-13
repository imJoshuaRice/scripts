# Import the Active Directory module
Import-Module ActiveDirectory

# Specify the output CSV file path relative to the script location
$scriptDirectory = Split-Path -Parent $MyInvocation.MyCommand.Path
$csvFileName = "ADUsersProxyAddresses.csv"
$csvFilePath = Join-Path -Path $scriptDirectory -ChildPath $csvFileName

# Get all users from Active Directory
$users = Get-ADUser -Filter * -Properties DisplayName, ProxyAddresses

# Create an array to store the data
$data = @()

# Loop through each user and extract relevant information
foreach ($user in $users) {
    $displayName = $user.DisplayName
    $proxyAddresses = $user.ProxyAddresses -join ', '  # If you want to concatenate multiple proxy addresses

    # Create a custom object with the desired information
    $userObject = [PSCustomObject]@{
        DisplayName     = $displayName
        ProxyAddresses  = $proxyAddresses
    }

    # Add the object to the data array
    $data += $userObject
}

# Export the data to a CSV file
$data | Export-Csv -Path $csvFilePath -NoTypeInformation

Write-Host "CSV file created successfully: $csvFilePath"