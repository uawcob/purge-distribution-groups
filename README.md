# Purge Office 365 Distribution Groups

Given a list of users,
this script removes them from all WCOB distribution groups.

Download [`purge.ps1`][1] and change the usernames at the top.
They must be a comma-separated list of quoted GACL usernames.

```powershell
$usernames = 'john001','jane002','jeff003'
```

You can also just have one person in the list.

```powershell
$usernames = 'john004'
```

**WARNING** this destructive script does not confirm anything.
Use with caution.

[1]:./purge.ps1
