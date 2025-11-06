# Active Directory Homelab Documentation

This repository documents a series of Active Directory labs I previously completed and am now re-running with proper documentation and structure.

The goal is to rebuild and record my original homelab work with better organization and clarity.  
Each phase focuses on realistic IT support and system administration workflows—joining clients, managing users, applying GPOs, configuring services, and automating tasks with PowerShell.

---

## Environment Overview

- Windows Server 2022 Domain Controller (lab.local)
- Windows 10 Pro clients
- Private virtual network (10.0.0.0/24)
- DNS, DHCP, and Group Policy configured on the DC

---

## Why This Project

I originally built this homelab to strengthen practical IT skills for real-world support and defensive cybersecurity.  
After completing all phases once, I’m now documenting them in a professional format to demonstrate process, repeatability, and technical clarity.

This version emphasizes:
- Step-by-step documentation
- Reflection after each phase
- Organized structure for review or reuse
- Reproducible PowerShell scripts

---

## Lab Phases

**Phase 1 – Core AD + Client Join**  
User, group, and domain setup. Join Windows 10 clients to the domain and apply starter GPOs.

**Phase 2 – User Access and Policies**  
Drive mappings, shared printers, and GPO restrictions.

**Phase 3 – Infrastructure and Recovery**  
DHCP, DNS cleanup, AD Recycle Bin, and delegated admin roles.

**Phase 4 – Security Hardening**  
Windows LAPS, BitLocker, and account audit configuration.

**Phase 5 – Automation and Remote Ops**  
PowerShell scripts for provisioning, password resets, and remote management.

---

## Structure
/labs
phase1_core-ad.md
phase2_policies.md
phase3_infra.md
phase4_security.md
phase5_automation.md

/scripts
bulk_user_creation.ps1
helpdesk_toolkit.ps1

/docs
screenshots/
network_diagram.png
ad_structure.png

Each lab document includes goals, step-by-step notes, and a short reflection.

---

## Reflection

This repository is not just a walkthrough—it’s a re-documentation of completed labs.  
Redoing and writing them from scratch helps reinforce process thinking and technical communication, the same habits used in professional IT environments.

---

## Links

Portfolio: [https://yairmartinezcybersecurityportfolio.com](https://yairmartinezcybersecurityportfolio.com)  
LinkedIn: [https://www.linkedin.com/in/yair-martinez-939a17378](https://www.linkedin.com/in/yair-martinez-939a17378)

Thanks For Reading!
