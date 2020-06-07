# Configure AD OU Structure
New-ADOrganizationalUnit -Name "LAB" -Path "DC=LAB,DC=COM"
New-ADOrganizationalUnit -Name "Users" -Path "OU=LAB,DC=LAB,DC=COM"
New-ADOrganizationalUnit -Name "Groups" -Path "OU=LAB,DC=LAB,DC=COM"
New-ADOrganizationalUnit -Name "Services" -Path "OU=LAB,DC=LAB,DC=COM"
New-ADOrganizationalUnit -Name "Servers" -Path "OU=LAB,DC=LAB,DC=COM"

