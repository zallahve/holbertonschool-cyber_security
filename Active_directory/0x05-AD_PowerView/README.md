# 0x05 - Active Directory: PowerView

Domain enumeration and ACL-based attack-path discovery using PowerView,
part of the Holberton Cyber Security track.

## Description

Use PowerView to enumerate users, groups, computers, trusts, and ACLs in an
Active Directory domain, then identify abusable rights (GenericAll, GenericWrite,
WriteDACL), delegation misconfigurations, and roastable accounts. Each flag
corresponds to a distinct finding.

## Tools used

- **PowerView** - PowerShell AD enumeration (Get-DomainUser, Get-DomainGroupMember, Get-DomainTrust, ACL queries)
- **Kerberos tooling** - Kerberoasting and AS-REP roasting
- **Delegation abuse** - RBCD via msDS-AllowedToActOnBehalfOfOtherIdentity, Shadow Credentials via msDS-KeyCredentialLink
- **DCSync** - replication-rights abuse for credential extraction

## Author

Zia - [@zallahve](https://github.com/zallahve)
