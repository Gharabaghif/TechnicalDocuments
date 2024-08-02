#Active Directory Management
#Move Inactive Computers for 30 days

import-module activedirectory
NEW-ADOrganizationalUnit “Inactive-Computers” –path “OU=HOME-Network,DC=HOME,DC=LAB”
$inactive = (Get-Date).AddDays(-30)
$Computers = Get-ADComputer -Property Name,lastLogonDate -Filter {lastLogonDate -lt $inactive}
$Computers | Set-ADComputer -Description "Computer Disabled on $(Get-Date)"
$Computers | Set-ADComputer -Enabled $false
$Computers | Move-ADObject -TargetPath “OU=Inactive-Computers,DC=HOME,DC=LAB”
## End Of SCRIPT ##

#To add the date of operation in Description uncomment this line
# Get-ADcomputer -Filter * -SearchBase "ou=inactive-computers,dc=HOME,dc=LAB" | set-Adcomputer -enabled $false -Description "Computer Disabled on $(Get-Date)"


#Move Inactive Users for 30 days
## This Script has been created by F.Garebaghi ##
import-module activedirectory
#NEW-ADOrganizationalUnit “Inactive-Users” –path “OU=HOME-Network,DC=HOME,DC=LAB”
$inactive = (Get-Date).AddDays(-30)
$Users = Get-ADUser -Property Name,lastLogonDate -Filter {lastLogonDate -lt $inactive}
$Users | Set-ADuser -Description "User Disabled on $(Get-Date)"
$Users | Set-ADuser -Enabled $false
$Users | Move-ADObject -TargetPath “OU=Inactive-Users,DC=HOME,DC=LAB”

## End Of SCRIPT ##
#To disable all of the users in this OU uncomment this line
### Get-ADuser -Filter * -SearchBase "ou=inactive-users,dc=HOME,dc=LAB" | set-aduser -enabled $false
