# Phase 4 – Security Hardening

This phase focuses on baseline security controls that can be applied in small enterprise environments.  
The goal is to demonstrate practical experience with LAPS, BitLocker, and account audit policies.

## Objectives
- Deploy Windows LAPS with password escrow in Active Directory
- Configure BitLocker with AD recovery key backup
- Enable and review account lockout auditing

## Key Tasks
1. Add LAPS ADMX templates to the Central Store if required.
2. Configure a LAPS GPO to back up passwords in AD and set rotation frequency.
3. Verify password retrieval from the Domain Controller.
4. Configure BitLocker policies for VM-friendly encryption and escrow keys to AD.
5. Enable auditing for logon failures and account lockouts.
6. Trigger a test lockout and review Event ID 4740 on the Domain Controller.

## Notes
Include the specific GPO paths and settings.  
Take screenshots showing LAPS retrieval, BitLocker status, and the account lockout event.

## Reflection
These controls are common in production environments.  
Redoing this work allowed for clearer understanding of how identity and device security fit into the domain.
