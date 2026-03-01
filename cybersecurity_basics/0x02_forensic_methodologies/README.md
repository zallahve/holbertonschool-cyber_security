# 0x02 - Forensic Methodologies

This project introduces the fundamentals of digital forensics and forensic methodologies, with a focus on ethics, evidence integrity, and repeatable investigation processes.

## Learning Objectives

- Explain what digital forensics is and why it matters
- Understand why ethics is critical in digital forensics
- Identify common ethical issues (privacy, scope, conflicts of interest, chain of custody)
- Explain integrity and objectivity in forensic analysis
- Describe the ACPO principles and their purpose
- Explain evidence admissibility and the importance of chain of custody
- List the typical stages of a digital forensic investigation
- Describe how to document findings in a forensic report
- Name common forensic tools and organizations that influence standards

## Core Concepts

### Digital Forensics
Digital forensics is the practice of collecting, preserving, analyzing, and presenting digital evidence in a way that is legally defensible and repeatable.

### Ethics
Ethics ensures investigators act lawfully and fairly, respect privacy, avoid bias, and maintain public trust. Ethical failures can make evidence inadmissible or harm innocent parties.

### Integrity & Objectivity
- Preserve integrity by minimizing changes to evidence, working on copies, and verifying with hashes.
- Maintain objectivity by documenting steps, separating facts from interpretation, and avoiding assumptions.

### ACPO Principles (Summary)
1. Do not change data that may be relied upon in court.
2. If accessing original data is necessary, it must be done by a competent person who can explain the impact.
3. Maintain an audit trail so an independent examiner can reproduce results.
4. Ensure overall responsibility for compliance is assigned.

### Chain of Custody
A documented record of who handled evidence, when, where, why, and how. It is crucial to prove evidence authenticity and integrity.

## Tools Commonly Used
- exiftool (metadata extraction)
- sha256sum / md5sum (hashing and integrity verification)
- strings / file (basic file inspection)
- binwalk / foremost / scalpel (embedded data and carving)
- sleuthkit / autopsy (filesystem and timeline analysis)

## Tasks

### 0. The Case of the Mysterious Image
Use exiftool to extract metadata from a provided image and identify suspicious entries that reveal an owner name. Save the owner name into:
- `0-mystery.txt`
