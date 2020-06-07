# Virtual Home Lab
A collection of scripts for easily setting up a Windows Server Domain Environment in Hyper-V for training purposes.



## OVERVIEW

The goal of this lab is to quickly deploy the bare minimum to setup and configure SQL Server on a Windows Domain.  This lab is a springboard for labbing more things with SQL in a domain environment.

## HARDWARE USED

You don’t need these exact hardware specs to run your home lab but here is what I use if you were curious.  A faster lab PC means less time spent watching the hourglass.  So here's an excuse to go buy some fancy hardware!

CPU = Core i9 5Ghz

MEM = 64GB DDR4

DISK = 1TB Samsung 960 Pro NVME

GFX = whatever the big expensive GeForce RTX card is called...probably overkill but who doesn't need a reason for a big card??!!  Maybe one day we will crunch some GPU and put it to use...

## LAB ASSUMPTIONS

Everything below is setup interactively by the Domain Administrator account since it's a one man lab.  If you want to create user accounts for practice that's up to you.

SQL Service accounts will still be created as that is the prime focus of this lab - to run SQL Server within a domain environment.

Everything is on the same subnet and VLAN to simplify things.

Windows Firewall is enabled by default and will remain enabled.  There are no changes that need to be made here.

We are using a Managed Service Account specifically.  If you want to setup a SQL Cluster you will need to refer to Group Managed Service Accounts.

LAB VMs can reach the Internet to simplify things.  In a production environment this should never be the case.

## HYPER-V TOPOLOGY

We are going to configure 2 virtual machines (a DC and a SQL server) that share the physical host network adapter.  The host will be able to communicate with the VMs, the VMs with each other, and the VMs with the host, for the sake of simplicity.  We are going to assume that the 2 IP addresses below are not being used by anything and that your Physical Router is on the same network as the rest of the world.

### PHYSICAL ROUTER

IP Address = 192.168.1.1

Subnet Mask = 255.255.255.0

HYPER-V VIRTUAL SWITCH

Name = EXTERNAL

Type = EXTERNAL

HYPER-V MACHINES

### DC1

-SPECS
--DISK = 25GB
--CPU = 8x
--MEM = 4GB = NOT DYNAMIC
-OS
--Windows Server 2019 Standard Edition
-NETWORK
--IP = 192.168.1.102
--MASK = 255.255.255.0
--GATEWAY = 192.168.1.1
--DNS = 192.168.1.1
-PASSWORD
--.\ADMINISTRATOR = <StrongPassword>
--DSRM = <StrongPassword>
--LAB\Administrator = <StrongPassword>
-DOMAIN
--FQDN = LAB.COM
--NETBIOS = LAB
  
### SQL1

-SPECS
--DISK = 25GB
--CPU = 8x
--MEM = 4GB = NOT DYNAMIC
-OS
--Windows Server 2019 Standard Edition
-NETWORK
--IP = 192.168.1.103
--MASK = 255.255.255.0
--GATEWAY = 192.168.1.1
--DNS = 192.168.1.102
-SQL SERVER
--DEFAULT INSTANCE
--MEM MIN = 500MB
--MEM MAX = 1GB

### SQL2

-SPECS
--DISK = 25GB
--CPU = 8x
--MEM = 4GB = NOT DYNAMIC
-OS
--Windows Server 2019 Standard Edition
-NETWORK
--IP = 192.168.1.104
--MASK = 255.255.255.0
--GATEWAY = 192.168.1.1
--DNS = 192.168.1.102
-SQL SERVER
--DEFAULT INSTANCE
--MEM MIN = 500MB
--MEM MAX = 1GB

