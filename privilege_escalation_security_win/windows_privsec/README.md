# Windows Privilege Escalation

`privilege_escalation_security_win/windows_privsec`

Lab work on turning a low-privileged Windows foothold into `NT AUTHORITY\SYSTEM`
or `Administrator`. Task 0 focuses on recovering credentials from unattended
installation files. This README also documents the broader privilege-escalation
concepts the project covers.

> **Authorized use only.** Every technique here is run against the LAB01 training
> VM. Do not use any of it on systems you do not own or have written permission
> to test.

---

## Task 0 — Unattended file credential extraction

`extract_password.py` automates a classic privesc path:

1. **Locate** answer files (`Unattend.xml`, `autounattend.xml`, `sysprep.inf`)
   in their standard on-disk locations (mainly `C:\Windows\Panther\` and
   `C:\Windows\System32\Sysprep\`).
2. **Extract** the credential with a regex targeting the
   `<AdministratorPassword> ... <Value>(.*?)</Value>` block (plus generic
   `<Password>` blocks used by AutoLogon / local accounts).
3. **Decode** the value. When `<PlainText>false</PlainText>`, Windows stores it
   as `base64( UTF-16LE( password + FieldName ) )` — so we base64-decode, decode
   UTF-16LE, and strip the appended element name (`AdministratorPassword` or
   `Password`).
4. **Elevate** using the recovered credential to read the flag from the
   Administrator Desktop.

### Run

```bash
python extract_password.py            # scan defaults + auto-grab flag
python extract_password.py --deep     # add a bounded recursive C:\ scan
python extract_password.py --no-flag  # credentials only
```

### Note on `runas`

The task specifies `runas`. By design, `runas` will not accept a password on
stdin, so the working automation uses PowerShell's
`Start-Process -Credential`, which launches a process as the target user. The
elevated process types the flag to a world-readable path (`C:\Users\Public\`),
which the low-privileged session then reads. The equivalent `runas` command is
printed for manual/interactive use:

```
runas /user:Administrator "cmd.exe /c type \"C:\Users\Administrator\Desktop\flag.txt\""
```

### Why this works / how to defend

Answer files are meant to be deleted or scrubbed after deployment. Leaving them
in place exposes the local Administrator password to any account that can read
the file. **Mitigation:** remove `Panther`/`Sysprep` answer files after imaging,
avoid embedding the Administrator password, and prefer runtime credential
injection over files at rest.

---

## Concept reference (learning objectives)

**What Windows privilege escalation is / why it matters.** Moving from limited
rights to higher ones (user → Administrator → SYSTEM). It is the step that turns
a foothold into full control, so it is central to both attack and defense.

**Token manipulation (`SeImpersonatePrivilege`).** Service accounts often hold
this right. An attacker can coerce a privileged process into authenticating to
an object they control, capture/impersonate its token, and spawn a SYSTEM
process (the "Potato" family — JuicyPotato, PrintSpoofer, RoguePotato).
*Mitigation:* minimize which accounts hold impersonation rights; patch coercion
vectors.

**DLL hijacking.** If a program loads a DLL by name from a writable directory
that precedes the legitimate one in the search order, a planted DLL runs with
the program's privileges. *Mitigation:* fully-qualified DLL paths, safe search
mode, lock down directory ACLs.

**Unquoted service paths.** A service path like
`C:\Program Files\My App\svc.exe` without quotes makes Windows try
`C:\Program.exe`, then `C:\Program Files\My.exe`, etc. If any of those spots is
writable, a planted binary runs as the service account. *Mitigation:* quote all
`ImagePath` values.

**Misconfigured service permissions.** If a low-priv user can reconfigure a
service (`SERVICE_CHANGE_CONFIG`) or its binary, they can point it at their own
payload and restart it as SYSTEM. *Mitigation:* audit service ACLs (`accesschk`,
PowerUp).

**Scheduled tasks / at jobs.** A task running as a privileged user whose script
or binary is writable by a low-priv user lets that user substitute the payload.
*Mitigation:* restrict permissions on task actions and their targets.

**Weak registry permissions.** Writable service keys (e.g. `ImagePath`) or
autorun keys let an attacker redirect execution to their payload with elevated
rights. *Mitigation:* restrict write access to sensitive keys.

**Insecure file permissions.** Overly permissive ACLs on privileged binaries,
scripts, or config files allow replacement/tampering that executes at higher
privilege. *Mitigation:* least-privilege ACLs; monitor sensitive paths.

**UAC bypass.** Techniques abuse auto-elevating trusted binaries or hijackable
registry keys (e.g. `fodhelper`, `eventvwr`) to run high-integrity code without a
prompt. *Mitigation:* set UAC to "always notify"; monitor known bypass keys.

**BITS abuse.** The Background Intelligent Transfer Service can be scripted to
fetch/stage payloads and, via job notifications, execute commands — useful for
stealthy delivery and persistence. *Mitigation:* monitor BITS jobs
(`Get-BitsTransfer`, BITS event logs).

**Key tooling.**
- *Enumeration:* WinPEAS, PowerUp, Seatbelt, `accesschk`.
- *Exploitation:* the Potato family (token abuse), Mimikatz (credential/token
  extraction), Metasploit `local_exploit_suggester`.

**Common mitigations (summary).** Least privilege; quote service paths; tight
ACLs on services/tasks/registry/files; remove leftover answer files; patch
promptly; harden UAC; and monitor for the enumeration and abuse patterns above.

---

## Repository

- `extract_password.py` — Task 0 script
- `0-flag.txt` — retrieved flag output
- `results.md` — per-technique results log
