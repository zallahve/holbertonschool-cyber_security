# 4. Persistence Using BITS — Overview & Defence

**Module:** Persistence in Windows
**MITRE ATT&CK:** T1197 — BITS Jobs

> Descriptive write-up for an isolated lab. Covers what BITS is, why it is
> abused, and how to detect and defend against that abuse. It intentionally
> does not include an attack walkthrough, payload, or job-restoration script.

---

## 1. Introduction

**Background Intelligent Transfer Service (BITS)** is a built-in Windows
service that moves files between a machine and a remote server in the
background, using spare network bandwidth and resuming automatically after
interruptions or reboots. It is the plumbing behind Windows Update, Microsoft
Defender signature updates, and many software installers.

Because BITS is signed, native, and expected to make network connections,
it is also a known **living-off-the-land** target: activity that rides on it
can blend in with normal system traffic. This is catalogued by MITRE as
technique **T1197**.

## 2. Understanding BITS

A few properties explain why BITS shows up in intrusions:

- **Persistence across reboots** — jobs survive restarts and resume on their
  own, so a foothold can outlast a reboot without an obvious autostart entry.
- **Native and trusted** — it ships with Windows and runs under a legitimate
  service, so its network activity looks routine.
- **Low visibility** — jobs live in the BITS queue rather than in the common
  autorun locations (Run keys, Services, Scheduled Tasks) that defenders check
  first.

These are the same traits that make it useful to administrators; the risk is
that the trust is misplaced when a job wasn't created by a legitimate process.

## 3. Detecting Suspicious BITS Jobs

**Enumerate current jobs (IR / triage):**

- `bitsadmin /list /allusers` — lists jobs across all users.
- `Get-BitsTransfer -AllUsers` — the PowerShell equivalent, with more detail.

**Event logs to review:**

- `Microsoft-Windows-Bits-Client/Operational` — records job creation,
  transfers, and state changes. This is the primary source.
- Correlate with process-creation and network logs (Sysmon event IDs 1 and 3)
  to see what created a job and where it was reaching out.

**Indicators worth flagging:**

- Jobs that specify a notify command to run on completion.
- Unusually long job lifetimes or high retry counts.
- Jobs owned by user contexts that have no reason to use BITS, or pointing at
  unfamiliar external hosts.

## 4. Prevention & Hardening

- **Shorten job lifetimes** via Group Policy (`Maximum job lifetime`) so
  abandoned/hidden jobs expire quickly instead of lingering.
- **Monitor and alert** on BITS job creation, especially jobs with a notify
  command attached, using your SIEM/EDR.
- **Egress filtering** — restrict outbound destinations so background
  transfers can't reach arbitrary hosts.
- **Baseline normal BITS use** for your environment so anomalies stand out.
- **EDR coverage** — most modern EDRs have built-in detections for anomalous
  BITS usage; confirm they're enabled and tuned.

## 5. Conclusion

BITS is a legitimate, trusted Windows service whose reliability features —
reboot-persistent, native, low-noise — are exactly what make it attractive to
abuse for persistence. Defence doesn't rely on blocking BITS (that breaks
updates) but on **visibility**: watch the BITS-Client operational log, enumerate
jobs during triage, alert on jobs that run commands or reach unknown hosts, and
cap job lifetimes. Treat an unexplained BITS job the same way you'd treat an
unexplained scheduled task or service — as something to run down.

---

*Author: Zia — MCTI, University of Guelph*
