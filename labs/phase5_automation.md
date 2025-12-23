# Phase 5 – Automation and Remote Operations

This phase focuses on PowerShell automation for common administrative tasks.  
The goal is to demonstrate scripting skills that support repetitive Help Desk workflows.

### Objectives
- Automate user provisioning from a CSV file
- Build a small Help Desk toolkit for resets and group changes
- Use PowerShell Remoting to manage clients without RDP

### Key Tasks
1. Write a CSV-driven user creation script.
2. Add logic to assign users to the correct OU and groups.
3. Create a simple menu-based toolkit for unlocking accounts, resetting passwords, or adding group membership.
4. Enable PowerShell Remoting on Windows clients.
5. Run remote commands from the Domain Controller to retrieve system information.

## Lab 18 – Bulk User Provisioning from CSV (PowerShell Automation)

### Purpose: 
Automate Active Directory user onboarding by provisioning multiple user accounts and assigning group memberships from a structured CSV file using PowerShell. This lab demonstrates how enterprise environments streamline HR-driven onboarding while reducing manual administrative effort and error.

### Summary:  
In this lab, I built and executed a PowerShell automation workflow to bulk-create Active Directory user accounts from a CSV file. This simulates a real-world onboarding scenario where IT receives a standardized user list from HR and provisions accounts in a repeatable, auditable manner.

A dedicated onboarding directory was created to store the provisioning assets. The CSV file (`new_users.csv`) contains user attributes including first name, last name, username, target OU, and group memberships. A PowerShell script (`New-BulkUsers.ps1`) imports this data, iterates through each entry, and creates enabled AD user accounts using `New-ADUser`.

The script also handles group assignment by parsing a semicolon-delimited group list and adding each user to the appropriate security groups using `Add-ADGroupMember`. Script output provides real-time confirmation of successful account creation, allowing quick validation during execution.

After the script completed, Active Directory Users and Computers (ADUC) was used to verify that all users were created in the correct OU and that group memberships were applied as intended.

### Screenshot:  
PowerShell execution of `New-BulkUsers.ps1` showing successful creation messages and ADUC view confirming newly created users and security groups  

<img width="600" height="400" alt="Screenshot from 2025-12-21 22-25-12" src="https://github.com/user-attachments/assets/2283f790-9199-4084-a2a5-684d0a1be629" />

### Reflection:  
This lab highlights the operational value of PowerShell automation in identity lifecycle management. Bulk provisioning ensures consistency, reduces human error, and enables IT teams to scale onboarding efficiently as organizations grow. In production environments, this approach integrates cleanly with HR systems, service desks, and identity governance workflows. 

The lab also reinforces best practices such as separating data (CSV) from logic (script), using standardized naming conventions, and validating results post-execution. Bulk user provisioning is a foundational skill for Windows administrators and a critical capability in enterprise Active Directory environments.

> Note: New-BulkUsers.ps1 and new_users.csv will be available in the scripts folder 

## Lab 19 – Help Desk Toolkit (Unlock, Reset, Group Management)

### Purpose:
Demonstrate how common Tier 1 help desk identity management tasks can be securely delegated and automated using PowerShell, while maintaining strict least-privilege controls in Active Directory.

### Summary:
In this lab, I built and validated a lightweight, menu-driven PowerShell help desk toolkit designed to perform routine Active Directory support operations without granting broad administrative access. The toolkit accepts a target username as input and provides an interactive interface for common help desk actions, including account unlocks, password resets, and group membership changes.

The script was intentionally executed under a delegated **Helpdesk** security context rather than Domain Admin credentials. This design reflects real enterprise environments, where Tier 1 staff must resolve user access issues quickly while remaining constrained to narrowly scoped permissions.

During testing, the toolkit successfully performed password resets and group modifications; however, account unlock operations initially failed despite using the Active Directory Delegation Wizard. This discrepancy prompted further investigation into attribute-level permissions required for account unlocks.

Using PowerShell to inspect the access control list (ACL) on the user OU, it was identified that the Helpdesk group lacked **WriteProperty** permissions on the **lockoutTime** attribute. Since unlocking an account requires modifying this attribute, the operation was silently blocked by Active Directory despite other delegated rights being present.

Manual delegation was applied to grant the Helpdesk group write access to the **lockoutTime** attribute on descendant user objects. After refreshing the delegated user’s security token, account unlock operations functioned as expected. This validated both the toolkit’s logic and the corrected delegation model.

### Script Behavior and Validation:
The toolkit provides the following controlled operations:

- Unlock user accounts by clearing the `lockoutTime` attribute  
- Reset user passwords, with optional enforcement of password change at next logon  
- Add users to security groups  

Each action produces immediate console output confirming success, reducing ambiguity for help desk operators.

PowerShell was also used to programmatically verify delegation correctness by querying OU ACLs and resolving rights GUIDs. This ensured the Helpdesk group had:

- Extended rights for password resets  
- Write access to `lockoutTime` for account unlocks  
- No unnecessary administrative permissions  

### Screenshots:
Delegation Verification (PowerShell ACL Output): Shows resolved Active Directory permissions confirming that the Helpdesk group has WriteProperty access to the `lockoutTime` attribute and extended rights for password resets.

<img width="600" height="400" alt="e5f79db1-91aa-459e-94a3-a9e26601dbaa" src="https://github.com/user-attachments/assets/1af5d1d8-3fb5-4ba5-9d5f-f5b98bb9310c" />

---

Help Desk Toolkit Execution (Menu Workflow): Demonstrates the interactive PowerShell menu used by help desk staff to unlock an account, reset a password, and add a user to a group, with real-time success confirmation.

<img width="600" height="400" alt="ea49938c-1ce4-4202-a7cd-1da3325035fa" src="https://github.com/user-attachments/assets/656c93bf-3bba-44c7-abb2-cab70ddca93d" />

### Reflection:
This lab reinforced that successful delegation in Active Directory requires more than simply relying on the Delegation of Control Wizard. While the wizard provides a useful baseline, real-world troubleshooting often demands an understanding of attribute-level permissions and how Active Directory enforces access control internally.

Building the help desk toolkit highlighted the operational value of PowerShell as both an automation and verification tool. By scripting common support workflows, the risk of human error is reduced, actions become consistent, and permissions can be tightly scoped to business requirements.

In a production environment, this toolkit would be extended with structured logging, input validation, error handling, and integration with ticketing systems to support auditing and compliance. Even in its intentionally minimal form, the lab demonstrates how automation and least privilege can coexist to improve both security posture and operational efficiency in enterprise identity management.

## Lab 20 – Remote Management & Windows Update Control

### Purpose: 
Enable secure remote administration of domain-joined workstations using PowerShell Remoting while enforcing centralized Windows Update behavior through Group Policy.

### Summary:  
In this lab, I configured PowerShell Remoting across domain-joined Windows 11 workstations to allow remote management without relying on interactive RDP sessions. A dedicated Group Policy Object was created and linked to the LabComputers OU to enable Windows Remote Management (WinRM) over HTTP, ensuring that remoting traffic was allowed and properly scoped within the domain profile.

After policy deployment, WinRM connectivity was validated from the Domain Controller using PowerShell remoting tests. Successful responses from multiple client systems confirmed that remoting was functioning correctly and that commands could be executed remotely using `Invoke-Command`. This demonstrated secure, scalable administrative access suitable for real-world enterprise environments.

In addition to remoting, Windows Update behavior was centrally managed through Group Policy. Update policies were configured to enforce automatic updates, define installation schedules, and control active hours to prevent disruptive reboots during business hours. These policies were applied consistently across all lab workstations.

Policy application was verified directly on client systems by reviewing configured update policies in Windows Settings and by generating Group Policy Result reports. This confirmed that the intended GPOs were successfully applied and enforced at the computer level.

### Key Configuration Details:  
- Enabled WinRM via Group Policy for domain-joined computers  
- Validated remoting using `Test-WSMan` from the Domain Controller  
- Executed remote commands using `Invoke-Command` without RDP access  
- Configured Windows Update policies (automatic updates, schedules, active hours)  
- Verified applied policies using `gpresult /h` reports on multiple clients  

### Screenshots:  
WinRM GPO configuration

<img width="600" height="400" alt="Screenshot from 2025-12-22 20-48-12" src="https://github.com/user-attachments/assets/12a98a7e-4d97-483b-9da6-784e51afc449" />

---

Successful Test-WSMan responses and remote command execution output 

<img width="600" height="400" alt="Screenshot from 2025-12-22 20-05-29" src="https://github.com/user-attachments/assets/4a7091ac-5d62-4742-bc73-1ba368e3337f" />

---

Windows Update policy enforcement on clients

<img width="600" height="400" alt="Screenshot 2025-12-22 204229" src="https://github.com/user-attachments/assets/02ea7032-27f1-4c1d-8dfb-c3e96ec50fae" />

---

Group Policy Results reports validating applied settings.

<img width="600" height="400" alt="dd267df3-05b1-4274-ba0c-c80e8f51db7e" src="https://github.com/user-attachments/assets/cad95240-df22-4ab1-9c52-a11fa6456941" />

### Reflection:  
This lab demonstrated how enterprise administrators can manage systems efficiently without excessive RDP usage by leveraging PowerShell Remoting. Centralizing remote access through Group Policy ensures consistency, security, and reduced attack surface while enabling powerful administrative workflows.

Managing Windows Updates through Group Policy reinforced the importance of centralized patch management to maintain system security without disrupting users. Validating policy application using `gpresult` highlighted the necessity of verification when deploying critical configurations at scale.

Together, these configurations reflect real-world operational practices where automation, remote management, and policy enforcement are essential for maintaining secure and reliable enterprise environments.

## Final Thoughts

Phase 5 tied the entire lab together by shifting from configuration to operational execution. Automating onboarding from CSV, building a controlled help desk toolkit, and enabling remoting through policy all reflect how real environments scale without relying on manual work or excessive administrative access. 

The biggest takeaway from this phase was that automation only matters when it is paired with correct permission design and verification. Debugging the account unlock issue down to attribute-level access reinforced how Active Directory enforces security under the hood and why least privilege requires more than wizard defaults. 

Overall this phase shows how PowerShell can be used not just to automate tasks, but to validate infrastructure, prove policy application, and support consistent help desk workflows in an enterprise domain.

