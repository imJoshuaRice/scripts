# Get all mailboxes to which me@domain has access
$accessibleMailboxes = Get-Mailbox -ResultSize Unlimited | Get-MailboxPermission | Where-Object { $_.User -like "me@domain.com" }

# Remove access for me@domain.com from each mailbox
foreach ($mailbox in $accessibleMailboxes) {
    Remove-MailboxPermission -Identity $mailbox.Identity -User "me@domain.com" -AccessRights FullAccess -Confirm:$false
}
