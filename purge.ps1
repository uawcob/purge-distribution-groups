$usernames = 'wcoblog','esreq'

$session = New-PSSession -ConfigurationName Microsoft.Exchange `
    -ConnectionUri https://outlook.office365.com/powershell-liveid/ -AllowRedirection `
    -Authentication Basic -Credential "${env:UserName}@uark.edu"

Import-PSSession $session -allowclobber

echo ""

foreach ($username in $usernames) {
    $distname = $((Get-Recipient -Identity ${username}@uark.edu).DistinguishedName)

    if (!($distname)) {continue}

    $groups = Get-DistributionGroup -Filter "
        Name -like 'WCOB:*'
        -and Members -eq '$distname'
    "

    if (!($groups)) {
        echo "No groups found for $username"
        continue
    }

    foreach ($group in $groups) {
        echo "Removing $username from $group"
        Remove-DistributionGroupMember -Identity $group.Identity `
            -Member "$distname" `
            -Confirm:$false
    }

}

Remove-PSSession $session

Read-Host "Press any key to exit..."
