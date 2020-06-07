# Rename the computer to DC1
Rename-Computer -NewName "DC1" -Restart

# Install the AD DS Windows Feature + AD Deployment Module
Install-WindowsFeature AD-Domain-Services
Import-Module ADDSDeployment
Install-ADDSForest -DomainName "LAB.COM" -DomainNetbiosName "LAB" -InstallDns:$true -Force:$true

# Configure Static IP
New-NetIPAddress –IPAddress 192.168.1.102 -DefaultGateway 192.168.1.1 -PrefixLength 24 -InterfaceIndex (Get-NetAdapter).InterfaceIndex

# Configure the DNS - to use Physical Router
Set-DNSClientServerAddress –InterfaceIndex (Get-NetAdapter).InterfaceIndex –ServerAddresses 192.168.1.1

# Install AD Tools to make GUI administration easy
Install-WindowsFeature -Name "RSAT-ADDS"

