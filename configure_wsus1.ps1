# Rename the computer to WSUS1
Rename-Computer -NewName "WSUS1" -Restart

# Configure Static IP
New-NetIPAddress –IPAddress 192.168.1.107 -DefaultGateway 192.168.1.1 -PrefixLength 24 -InterfaceIndex (Get-NetAdapter).InterfaceIndex

# Configure the DNS - to use DC1
Set-DNSClientServerAddress –InterfaceIndex (Get-NetAdapter).InterfaceIndex –ServerAddresses 192.168.1.102

# Join the Domain
Add-Computer -DomainName "LAB.COM" -Restart

# Enter the domain admin creds
USER = LAB\Administrator
PASSWORD = <StrongPassword>

# After reboot and switch user to login as the domain account
USER = LAB\Administrator
PASSWORD = <StrongPassword>

# Congratulations - you’re now cooking with fire!
# Install AD Tools to make GUI administration easy - easier than switching screens
Install-WindowsFeature -Name "RSAT-ADDS"

# Copy the template to C:\CONFIG
# Run to Configure WSUS Role
Install-WindowsFeature -ConfigurationFilePath 'C:\CONFIG\wsus1.xml'
