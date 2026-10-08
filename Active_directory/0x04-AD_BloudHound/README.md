# 0x04 - Active Directory: BloodHound

Enumeration and attack-path analysis of an Active Directory domain using
BloodHound and SharpHound, as part of the Holberton Cyber Security track.

## Description

Collect AD data with the SharpHound collector, import it into BloodHound, and
use the graph to identify privilege-escalation and lateral-movement paths
toward domain compromise. Each captured flag corresponds to a distinct finding
along those paths.

## Tools used

- **BloodHound** - graph-based visualization of AD relationships and attack paths
- **SharpHound** - data collector for BloodHound
- **Kerberos tooling** - Kerberoasting / AS-REP roasting against service and user accounts
- **DCSync** - replication-rights abuse for credential extraction
- **SMB / SYSVOL** - share enumeration for exposed secrets

## Findings (flags)

| File         | Finding                                   |
|--------------|-------------------------------------------|
| `0-flag.txt` | BloodHound collection started             |
| `1-flag.txt` | GenericAll abuse path                     |
| `2-flag.txt` | Kerberoastable service account (backup)   |
| `3-flag.txt` | AS-REP roastable user (Jordan Martin)     |
| `4-flag.txt` | Disabled account (Morgan Liu)             |
| `5-flag.txt` | DCSync -> domain compromise               |
| `6-flag.txt` | SYSVOL SMB share leak (bonus)             |

## Author

Zia - [@zallahve](https://github.com/zallahve)
