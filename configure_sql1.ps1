# Rename the computer to SQL1
Rename-Computer -NewName "SQL1" -Restart

# Configure Static IP
New-NetIPAddress –IPAddress 192.168.1.103 -DefaultGateway 192.168.1.1 -PrefixLength 24 -InterfaceIndex (Get-NetAdapter).InterfaceIndex

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

# Create Managed Service Accounts for SQL1
New-ADServiceAccount -Name "msa_SQL1_1a" -Path "OU=Services,OU=LAB,DC=LAB,DC=COM" -RestrictToSingleComputer -Description "Managed Service Account for SQL1 - MSSQL Instance - SQL Server Agent"
New-ADServiceAccount -Name "msa_SQL1_1e" -Path "OU=Services,OU=LAB,DC=LAB,DC=COM" -RestrictToSingleComputer -Description "Managed Service Account for SQL1 - MSSQL Instance - SQL Server Engine"
New-ADServiceAccount -Name "msa_SQL1_1i" -Path "OU=Services,OU=LAB,DC=LAB,DC=COM" -RestrictToSingleComputer -Description "Managed Service Account for SQL1 - MSSQL Instance - SQL Server Integration Service"
New-ADServiceAccount -Name "msa_SQL1_1y" -Path "OU=Services,OU=LAB,DC=LAB,DC=COM" -RestrictToSingleComputer -Description "Managed Service Account for SQL1 - MSSQL Instance - SQL Server Analysis Service"

# Install Managed Service Accounts on SQL1
Install-ADServiceAccount -Identity "msa_SQL1_1a"
Install-ADServiceAccount -Identity "msa_SQL1_1e"
Install-ADServiceAccount -Identity "msa_SQL1_1i"
Install-ADServiceAccount -Identity "msa_SQL1_1y"

# Test Managed Service Accounts on SQL1 - They should return True
Test-ADServiceAccount -Identity "msa_SQL1_1a"
Test-ADServiceAccount -Identity "msa_SQL1_1e"
Test-ADServiceAccount -Identity "msa_SQL1_1i"
Test-ADServiceAccount -Identity "msa_SQL1_1y"

# Configure SPN for Kerberos
# We don't need to do this because we setup SQL using a Domain Admin account
# SETSPN -s MSSQLSvc/sql1.lab.com lab\msa_SQL1_1e
