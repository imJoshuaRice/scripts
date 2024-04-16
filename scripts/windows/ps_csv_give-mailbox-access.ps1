# Import the Excel module
Import-Module ImportExcel

# Define the path to the Excel spreadsheet
$excelFilePath = "C:\Users\me\Desktop\mailbox_list.xlsx"

# Import the data from the spreadsheet
$mailboxes = Import-Excel -Path $excelFilePath | Select-Object -ExpandProperty Mailbox

# Loop through the list of mailboxes and grant access to myself
foreach ($mailbox in $mailboxes) {
    Add-MailboxPermission -Identity $mailbox -User "me@domain.com" -AccessRights FullAccess -AutoMapping $false
}
