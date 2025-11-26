# Phase 3 – Infrastructure and Recovery

This phase covers core domain services and recovery tools used in real environments.  
It includes DHCP, DNS cleanup, deleted object recovery, and delegated administration.

## Objectives
- Configure DHCP on the Domain Controller
- Manage DNS records and enable scavenging
- Enable and test Active Directory Recycle Bin
- Perform a system state backup
- Delegate limited administrative control

## Key Tasks
1. Install and configure DHCP with a clean IP scope.
2. Set DNS options, A/PTR records, and enable scavenging.
3. Enable the AD Recycle Bin and test restoring a deleted user.
4. Install Windows Server Backup and perform a system state backup.
5. Create a Help Desk user and delegate password reset permissions.
6. Test delegated actions by logging in as the Help Desk user.

## Notes
Record the PowerShell commands used and capture screenshots of DHCP, DNS, and the Recycle Bin.  
Summaries should be short and focused on what was configured and why.

## Reflection
This phase reinforces core domain services that support daily operations.  
Documenting it a second time provides a better understanding of recovery and least-privilege administration.
