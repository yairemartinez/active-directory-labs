# Active Directory Labs

This repository documents a hands-on Active Directory lab environment built to reflect real enterprise administration workflows.
I originally completed many of these labs earlier and am now re-running them with structured documentation, validation steps, and clear reasoning behind each configuration.

This repository focuses on process, configuration, verification, and operational thinking.

Portfolio: https://yairmartinezcybersecurityportfolio.com

LinkedIn: https://www.linkedin.com/in/yair-martinez-939a17378

---

## How to Review This Repository

If you are short on time:

- Start with Phase 1 to see foundational domain setup
- Jump to Phase 4 for security hardening (LAPS, BitLocker, auditing)
- Review Phase 5 to see PowerShell automation and help desk workflows

Each phase is documented with:
- Purpose and real-world context
- What was configured and why
- Validation steps and screenshots
- Short reflections focused on operational impact

---

## Lab Environment Overview

- Domain Controller: Windows Server 2022
- Clients: Windows 11 (multiple domain-joined systems)
- Domain: lab.local
- Network: 10.0.0.0/24 (single-site lab)
- Management tools: Active Directory, Group Policy, PowerShell

This environment was designed to mirror common small-to-mid enterprise deployments rather than isolated, one-off labs.

---

## Repository Structure

```text
.
├── README.md
├── labs
│   ├── phase1_core-ad.md
│   ├── phase2_policies.md
│   ├── phase3_infrastructure-recovery.md
│   ├── phase4_security-hardening.md
│   └── phase5_automation-remote-ops.md
└── scripts
    ├── New-BulkUsers.ps1
    ├── HelpDesk-Toolkit.ps1
    └── new_users.csv
```

Screenshots are embedded directly in the lab documentation to keep each phase self-contained and easy to review.

---

## Lab Phases

Phase 1 – Core AD and Client Join  
Domain creation, DNS dependency, client joins, user and group management, and a baseline GPO.
Focuses on fundamentals and verification of domain functionality.

Phase 2 – User Access and Policies  
Shared folders, drive mappings, printer deployment, folder redirection, and user-based Group Policy enforcement.
Demonstrates role-based access control and centralized configuration.

Phase 3 – Infrastructure and Recovery  
DHCP and DNS management, AD Recycle Bin, system state backups, and delegated administration.
Covers recovery readiness and least-privilege operations used in real environments.

Phase 4 – Security Hardening  
Windows LAPS, BitLocker with Active Directory escrow, and account lockout auditing.
Focuses on reducing credential risk, protecting data at rest, and improving investigative visibility.

Phase 5 – Automation and Remote Operations  
PowerShell automation for bulk provisioning, help desk tooling, and remote management using WinRM.
Demonstrates operational scripting, delegation-aware automation, and scalable administration.

---

## What This Project Demonstrates

- Practical Active Directory administration beyond basic setup
- Strong understanding of DNS, Group Policy, and identity workflows
- Security hardening with validation, not just configuration
- PowerShell used for automation, verification, and troubleshooting
- Least-privilege thinking applied consistently across labs
- Clear documentation habits aligned with production environments

All credentials, users, and systems referenced are lab-only and non-production.

---

## Closing Note

This repository is intentionally structured to show how I work, not just what I configured.
Each phase reflects the same mindset used in real IT environments: plan, implement, verify, document, and iterate.

