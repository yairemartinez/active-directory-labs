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

# Lab 11 – DHCP Setup and Reservations
**Purpose:** Centralize IP address management by deploying DHCP on the Domain Controller to ensure consistent network configuration and DNS integration for domain clients.

**Summary:**  
In this lab, I installed and configured the DHCP Server role on the Domain Controller to manage IP address assignment within the Active Directory environment. The DHCP service was authorized in Active Directory, and a dedicated IPv4 scope was created with a defined address range appropriate for domain-joined clients. Scope options were configured to distribute the Domain Controller as the primary DNS server and to advertise the correct default gateway. DHCP reservations were created for specific Windows 11 workstations to ensure they consistently received the same IP addresses while remaining centrally managed. Configuration review confirmed that the DHCP scope, options, and reservations were correctly implemented and aligned with Active Directory best practices.

**Screenshots:**  
DHCP scope configuration on the Domain Controller:  

<img width="600" height="400" alt="Screenshot from 2025-12-17 23-51-37" src="https://github.com/user-attachments/assets/9f74442c-2e21-4c8c-8636-454db0bf9762" />

DHCP reservations for Windows 11 clients:  

<img width="600" height="400" alt="download" src="https://github.com/user-attachments/assets/55f9b85f-fc39-42b9-ad3f-725310c4853d" />

DHCP scope options showing DNS server and domain name configuration: 

<img width="600" height="400" alt="download" src="https://github.com/user-attachments/assets/645b49ff-cc61-408e-bec1-7fe3d83d5359" />

Client-side validation showing correct DNS and IP configuration: 

<img width="600" height="400" alt="Screenshot 2025-12-17 234734" src="https://github.com/user-attachments/assets/79fa53d2-c3ca-44e8-aa6f-13be0a2a6d74" />

**Reflection:**  

This lab reinforced the importance of centralized IP address management in Active Directory environments and highlighted how tight DHCP and DNS integration enables reliable domain communication. Because the lab operates within a shared home broadcast domain, the DHCP scope was intentionally left inactive to avoid conflicts with the upstream consumer router. All DHCP configuration, authorization, scope options, and reservations were implemented to production standards and validated through configuration review rather than live leasing, demonstrating an understanding of real-world infrastructure constraints while maintaining enterprise design principles.

# Lab 12 – DNS A/PTR Records and Scavenging
**Purpose:** Ensure reliable name resolution in an Active Directory environment by maintaining accurate forward and reverse DNS records.

**Summary:**  
In this lab, I managed DNS records on the Domain Controller to validate proper forward and reverse name resolution within the domain. I created and verified an **A record** for a test host and ensured a corresponding **PTR record** existed within the reverse lookup zone. DNS resolution was tested from multiple Windows clients using `nslookup` to confirm that hostname-to-IP and IP-to-hostname queries resolved correctly. The DNS zones were confirmed to be Active Directory–integrated, ensuring replication and consistency across the domain. These steps validated that DNS was functioning correctly as a core dependency for Active Directory operations.

**Screenshots:**  
_DNS Manager showing A records in the forward lookup zone and the reverse lookup zone:_  

<img width="600" height="400" alt="83213a97-3ffe-4f05-b698-28ad733d2ab7" src="https://github.com/user-attachments/assets/1e980bac-e534-47fe-a9d0-2a45835c7ebb" />

_Client-side validation showing successful forward and reverse DNS resolution using nslookup:_  

<img width="600" height="400" alt="Screenshot 2025-12-18 134931" src="https://github.com/user-attachments/assets/fd49d9ff-a88a-4035-bef1-2a3eb400a9c0" />

**Reflection:**  
This lab reinforced the critical role DNS plays in Active Directory functionality and day-to-day network operations. Verifying both forward and reverse lookups highlighted how proper DNS hygiene supports reliable authentication, service discovery, and troubleshooting.

## Lab 13 – Active Directory Recycle Bin + System State Backup
Purpose: Ensure Active Directory resiliency by enabling rapid object-level recovery and implementing full disaster recovery backups for the Domain Controller.

Summary:  
In this lab, I implemented two complementary recovery mechanisms to protect Active Directory: the Active Directory Recycle Bin and System State Backup. I first enabled the Active Directory Recycle Bin using Active Directory Administrative Center, acknowledging that this action is irreversible and would require change planning and approval in a production environment. After enabling the feature, I validated its functionality by deleting a test user account, confirming it appeared in the Deleted Objects container, and restoring it with all attributes and group memberships preserved. To support full disaster recovery, I installed Windows Server Backup and attached a dedicated VirtualBox virtual hard disk (VHD) to the Domain Controller to simulate an isolated backup disk. I initialized and mounted the disk as a backup volume, then performed a System State Backup using `wbadmin`, capturing Active Directory, SYSVOL, the registry, and boot configuration. Backup success was verified by confirming the backup volume via PowerShell and validating the presence of the WindowsImageBackup directory and backup files. Due to virtualization constraints in VirtualBox, backups were validated through configuration review rather than live restore testing; however, I documented the full restore procedure conceptually, including booting into Directory Services Restore Mode (DSRM), identifying backup versions, and restoring system state using wbadmin commands.

Screenshots:  
Active Directory Administrative Center showing the Recycle Bin and Deleted Objects container:  

<img width="600" height="400" alt="Screenshot from 2025-12-18 19-31-04" src="https://github.com/user-attachments/assets/3bcd5ffb-5656-4aab-a7b9-3ea767cdaaf2" />

VirtualBox-attached backup VHD configured as a dedicated backup disk:  

<img width="600" height="400" alt="Screenshot from 2025-12-18 20-27-20" src="https://github.com/user-attachments/assets/20980643-88ef-4fbe-81f1-c0214c86bbfc" />

Backup volume verification using Get-Volume:  

<img width="600" height="400" alt="Screenshot from 2025-12-18 20-27-46" src="https://github.com/user-attachments/assets/a3e71572-310f-4d40-9eda-62584dd779ee" />

Backup directory structure confirming System State backup files exist: 

<img width="600" height="400" alt="Screenshot from 2025-12-18 20-40-00" src="https://github.com/user-attachments/assets/be54672a-4dcc-48aa-84d6-978857dfb987" />

Reflection:  
This lab reinforced the importance of layered recovery strategies in Active Directory environments, combining fast operational recovery with full disaster recovery preparedness. It also highlighted real-world considerations such as irreversible configuration changes, backup storage isolation, and the compromises sometimes required in virtualized lab environments while still following enterprise-aligned recovery practices.

## Lab 14 – Delegation of Control (Least Privilege)
Purpose: Apply least-privilege principles by delegating routine user management tasks without granting full domain administrative access.

Summary:  
In this lab, I implemented delegated administration to allow help desk staff to perform common account management tasks while minimizing security risk. I created a dedicated Helpdesk security group and scoped delegation at the LabUsers organizational unit to prevent permissions from affecting the rest of the domain. Using the Delegation of Control Wizard and advanced security settings, I granted the Helpdesk group the ability to reset user passwords and force password changes at next logon for descendant user objects only. I reviewed the advanced permissions on the OU to confirm inheritance was disabled where appropriate and that access applied only to user objects. To validate the configuration, I logged in as a help desk user and successfully reset a standard user’s password while confirming that privileged actions such as group modification or computer account management were still restricted. This demonstrated a controlled delegation model aligned with real-world enterprise help desk operations.

Screenshot Placeholder:  
Advanced Security Settings showing delegated permissions applied to descendant user objects:  

<img width="600" height="400" alt="b9b22cc0-0ed7-43bc-9f12-7089ca91d27b" src="https://github.com/user-attachments/assets/5507aa37-cc37-487d-b27a-6fbafc0d02ee" />

Password reset successfully performed by delegated help desk account:

<img width="600" height="400" alt="485a4dae-a862-4fd8-a09b-7492e4fb829b" src="https://github.com/user-attachments/assets/905cd96b-9afc-4624-9347-75ec69773d02" />

Reflection:  
This lab reinforced the importance of enforcing least privilege in Active Directory by limiting access to only what is operationally necessary. It also highlighted how proper delegation reduces administrative risk while still enabling efficient help desk workflows.

## Lab 15 – Windows LAPS Deployment
Purpose: Secure local administrator accounts by enforcing unique, rotating passwords stored centrally in Active Directory.

Summary:  
In this lab, I deployed Windows Local Administrator Password Solution (LAPS) to eliminate the security risk of shared local administrator passwords across domain-joined systems. I first configured Group Policy to enable LAPS, defining password complexity, length, and rotation interval to meet modern security standards. The policy was scoped to the LabComputers organizational unit to ensure only intended workstations were affected. I then verified that client systems successfully applied the policy and generated unique local administrator passwords. Using PowerShell, I retrieved the stored passwords from Active Directory to confirm successful encryption, storage, and access control. Finally, I validated that each workstation had a distinct password and that only authorized principals (Domain Admins) could decrypt and view the credentials.

Screenshot Placeholder:  
Group Policy Management Editor showing LAPS password settings and policy configuration:  

<img width="600" height="400" alt="Screenshot from 2025-12-19 00-57-24" src="https://github.com/user-attachments/assets/ee112bab-4c72-4126-bc75-798b718f8e44" />

PowerShell output confirming successful retrieval of unique local administrator passwords for different workstations:  

<img width="600" height="400" alt="Screenshot from 2025-12-19 01-11-05" src="https://github.com/user-attachments/assets/70b20a8f-857f-49a2-aa0c-f9048127feab" />

Reflection:  
This lab reinforced the importance of preventing credential reuse and limiting lateral movement opportunities in Active Directory environments. It also demonstrated how LAPS provides centralized visibility and control over privileged local accounts while maintaining strict access boundaries.

Final Thoughts for Phase 3
Phase 3 focused on infrastructure services and recovery mechanisms that underpin daily domain operations. Documenting DHCP, DNS, backups, and delegated administration clarified how these components work together to support reliability, security, and operational continuity in real-world Active Directory environments.
