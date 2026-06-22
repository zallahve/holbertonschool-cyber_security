# Active Directory Basics and Concepts

## Description

This project introduces the basic concepts of Microsoft Active Directory environments. It focuses on understanding how Active Directory Domain Services, Domain Controllers, domains, users, groups, LDAP, authentication, and authorization work together inside a Windows enterprise network.

Active Directory is commonly used by organizations to centrally manage identities, computers, permissions, and security policies. Because it controls access across the enterprise, it is also a major target during internal penetration tests and real-world attacks.

## Learning Objectives

By the end of this project, I should be able to explain:

- What Active Directory is
- What Active Directory Domain Services is
- What a Domain Controller is
- What an Active Directory domain is
- What authentication means
- What authorization means
- What LDAP is
- How domain objects and attributes can be queried

## Task 0: Domain Reconnaissance

The objective of this task was to query the root Active Directory domain object and inspect its attributes.

Standard Active Directory queries do not always return all available properties. To discover hidden or non-standard attributes, the domain object must be queried with explicit property requests.

## Tools Used

- Windows Server 2019
- Active Directory Domain Services
- PowerShell
- Active Directory PowerShell module
- VirtualBox

## Key Commands

```powershell
Import-Module ActiveDirectory

$domainDN = (Get-ADDomain).DistinguishedName

Get-ADObject -Identity $domainDN -Properties * | Format-List *
E0F
nano README.md
