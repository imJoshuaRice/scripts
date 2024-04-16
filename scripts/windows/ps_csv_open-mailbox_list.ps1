# Import the Excel module
Import-Module ImportExcel

# Define the path to the Excel spreadsheet
$excelFilePath = "C:\Users\me\Desktop\mailbox_list.xlsx"

# Import the data from the spreadsheet
$mailboxes = Import-Excel -Path $excelFilePath | Select-Object -ExpandProperty Mailbox

# Loop through the list of mailboxes and open a tab for each email address
foreach ($mailbox in $mailboxes) {
    $url = "https://outlook.office.com/mail/$mailbox"
    Start-Process $url
}
