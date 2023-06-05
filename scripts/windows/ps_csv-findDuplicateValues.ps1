# Task: Search two .csv files and check for duplicate values within a specific column (ColumnReference).
# - Disregards case sensitivity by converting all values to UpperCase when checked.
# - Optionally converts the data location to an equivalent .xlsx cell reference to assist end-user with locating data within spreadsheet programs (Excel).
# - Locates files by specifying two three digit strings that are present in the working file format (sheet123.csv, sheet124.csv..)
# - Moves files if passing checks into '.\Checked' folder

# Ask for the three digit numbers for the first and second file
$firstFileNumber = Read-Host -Prompt 'Enter the three digit number for the first file'
$secondFileNumber = Read-Host -Prompt 'Enter the three digit number for the second file'

# Ask if user wants to see cell references
$cellRefInput = Read-Host -Prompt 'Show cell references: Y or N'
$showCellReferences = $cellRefInput -eq 'Y'

# Clear the terminal
Clear-Host

# Define file names based on user input
$firstFile = "sheet$firstFileNumber.csv"
$secondFile = "sheet$secondFileNumber.csv"

# Show the file names being compared
Write-Host "Comparing files $firstFile and $secondFile`n"

# Check if both files exist
if ((Test-Path -Path $firstFile) -and (Test-Path -Path $secondFile)) {
    # Import the CSV files
    $firstCsv = Import-Csv -Path $firstFile
    $secondCsv = Import-Csv -Path $secondFile

    # Get ColumnReference column from each file and remove any white spaces and convert to upper case
    $firstColumnReference = $firstCsv | ForEach-Object { ($_.ColumnReference -replace '\s','').ToUpper() }
    $secondColumnReference = $secondCsv | ForEach-Object { ($_.ColumnReference -replace '\s','').ToUpper() }

    # Find common ColumnReference values
    $commonColumnReference = $firstColumnReference | Where-Object { $secondColumnReference -contains $_ }

    if ($commonColumnReference) {
        # If there are any common values, print a message for each one
        $duplicateCount = 1
        foreach ($commonRef in $commonColumnReference) {
            $firstCsvRows = $firstCsv | Where-Object { ($_.ColumnReference -replace '\s','').ToUpper() -eq $commonRef }
            $secondCsvRows = $secondCsv | Where-Object { ($_.ColumnReference -replace '\s','').ToUpper() -eq $commonRef }

            Write-Host "${duplicateCount}: Duplicate ColumnReference found: $commonRef"
            $duplicateCount++

            if ($showCellReferences) {
                Write-Host "Cells in ${firstFile}: $(($firstCsvRows | ForEach-Object { 'M' + ([array]::IndexOf($firstCsv, $_) + 2) }) -join ', ')"
                Write-Host "Cells in ${secondFile}: $(($secondCsvRows | ForEach-Object { 'M' + ([array]::IndexOf($secondCsv, $_) + 2) }) -join ', ')"
            }
        }
    } else {
        # If there are no common values, print a message stating that no duplicates were found
        Write-Host 'No duplicate ColumnReference found.'
        
        # Define the destination folder
        $doneFolder = ".\Checked"
        
        # Check if Done folder exists, if not, create it
        if (!(Test-Path -Path $doneFolder)) {
            New-Item -ItemType Directory -Path $doneFolder
        }

        # Move the files to the Done folder
        Move-Item -Path $firstFile -Destination $doneFolder
        Move-Item -Path $secondFile -Destination $doneFolder
        
        Write-Host "Files ${firstFile} and ${secondFile} have been moved to the Done folder."
    }
} else {
    Write-Host 'One or both of the files do not exist.'
}