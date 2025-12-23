# Phase 4 – Security Hardening

This phase focuses on baseline security controls that can be applied in small enterprise environments.  
The goal is to demonstrate practical experience with LAPS, BitLocker, and account audit policies.

### Objectives
- Deploy Windows LAPS with password escrow in Active Directory
- Configure BitLocker with AD recovery key backup
- Enable and review account lockout auditing

### Key Tasks
1. Add LAPS ADMX templates to the Central Store if required.
2. Configure a LAPS GPO to back up passwords in AD and set rotation frequency.
3. Verify password retrieval from the Domain Controller.
4. Configure BitLocker policies for VM-friendly encryption and escrow keys to AD.
5. Enable auditing for logon failures and account lockouts.
6. Trigger a test lockout and review Event ID 4740 on the Domain Controller.

## Lab 15 – Windows LAPS Deployment
**Purpose:** Secure local administrator accounts by enforcing unique, rotating passwords stored centrally in Active Directory.

### Summary
In this lab, I deployed Windows Local Administrator Password Solution (LAPS) to eliminate the security risk of shared local administrator passwords across domain-joined systems. 

I first configured Group Policy to enable LAPS, defining password complexity, length, and rotation interval to meet modern security standards. The policy was scoped to the LabComputers organizational unit to ensure only intended workstations were affected. 

I then verified that client systems successfully applied the policy and generated unique local administrator passwords. Using PowerShell, I retrieved the stored passwords from Active Directory to confirm successful encryption, storage, and access control. 

Finally, I validated that each workstation had a distinct password and that only authorized principals (Domain Admins) could decrypt and view the credentials.

### Screenshots
**Group Policy Management Editor showing LAPS password settings and policy configuration:**  

<img width="600" height="400" alt="Screenshot from 2025-12-19 00-57-24" src="https://github.com/user-attachments/assets/ee112bab-4c72-4126-bc75-798b718f8e44" />

---

**PowerShell output confirming successful retrieval of unique local administrator passwords for different workstations:**  

<img width="600" height="400" alt="Screenshot from 2025-12-19 01-11-05" src="https://github.com/user-attachments/assets/70b20a8f-857f-49a2-aa0c-f9048127feab" />

### Reflection
This lab reinforced the importance of preventing credential reuse and limiting lateral movement opportunities in Active Directory environments. It also demonstrated how LAPS provides centralized visibility and control over privileged local accounts while maintaining strict access boundaries.


## Lab 16 – BitLocker with Active Directory Escrow
**Purpose:** Protect endpoint data at rest by enforcing BitLocker Drive Encryption on domain joined systems while ensuring recovery options exist for administrative recovery scenarios.

### Summary
In this lab, I enforced BitLocker settings through Group Policy and validated encryption behavior on two domain joined Windows 11 workstations. I created and linked a dedicated GPO to the **LabComputers OU** and configured BitLocker OS drive policies to standardize how encryption is applied across endpoints.

After policy configuration, I enabled BitLocker on both clients and verified the full lifecycle using `manage-bde`: confirming the systems started **fully decrypted**, then moved into **encryption in progress**, and finally reached **fully encrypted** state. Once encryption completed, I added a **numerical recovery password** as an additional key protector to support real-world recovery needs (boot integrity failure, hardware validation issues, TPM changes, etc.).

> Note: In this VirtualBox lab environment, BitLocker behavior is affected by virtual TPM/firmware emulation and can be less consistent than physical enterprise hardware. In production, escrow and recovery validation would be tested end-to-end on supported devices and TPM-backed hardware.

### Screenshots

**The GPO (“BitLocker-OS-Drives”) linked to the LabComputers OU and the OS drive settings configured inside the Group Policy Management Editor:**  

<img width="600" height="400" alt="Screenshot from 2025-12-20 13-50-18" src="https://github.com/user-attachments/assets/406fdc7f-e6d3-4a24-ae8d-f53bac1ad0e5" />

---

**Baseline validation (BitLocker OFF → protector added / encryption initiated):** 

<img width="600" height="400" alt="Screenshot 2025-12-19 231528" src="https://github.com/user-attachments/assets/9310af9c-b781-4ccf-9924-35ac241b61d5" />

---

**Encryption in progress on both clients (mid-process validation):**  

<img width="600" height="400" alt="Screenshot 2025-12-19 233151" src="https://github.com/user-attachments/assets/93a4a4ad-9a16-4958-b65d-77cd4a25b7d0" />

---

**Encryption completed + recovery password generated (recovery readiness):**  

<img width="600" height="400" alt="Screenshot 2025-12-19 234145" src="https://github.com/user-attachments/assets/cc5a8d92-f440-4d23-b2b7-b6eb5d6c8585" />


### Reflection
This lab reinforced that endpoint encryption is not just “turning BitLocker on”—it’s enforcing consistent settings through centralized policy and validating outcomes on endpoints. Seeing the full progression (decrypted → encrypting → fully encrypted) made the process measurable and repeatable.

It also highlighted a real constraint: virtualization can introduce edge cases with BitLocker/TPM behavior that you wouldn’t typically see on supported enterprise hardware. In a production environment, I would validate escrow and recovery workflows using physical TPM-backed devices, confirm keys are centrally recoverable, and standardize deployment through imaging and compliance reporting.

## Lab 17 – Account Lockout Investigation
**Purpose:** Develop the ability to triage and investigate real Active Directory account lockouts by enabling advanced auditing, identifying the source of failed authentication attempts, and performing basic root cause analysis (RCA).

### Summary
In this lab, I configured Advanced Audit Policy settings on the Domain Controller to capture detailed account lockout events. Specifically, Account Logon and Account Management auditing were enabled to ensure lockout activity was recorded in the Security event log. This configuration provides the visibility required to investigate user authentication issues in enterprise environments.

To simulate a real-world incident, repeated failed authentication attempts were performed against a domain user account, resulting in an account lockout. The Domain Controller was then examined using Event Viewer, filtering for **Event ID 4740**, which records account lockout events. Each event clearly identified the affected user account and, critically, the **caller computer name** responsible for triggering the lockout.

To streamline future investigations, a **Custom Event Viewer View** was created to permanently track account lockout activity. This custom view filters Security logs by Event ID 4740, allowing rapid identification of lockouts without manually searching through thousands of events. The view can be exported and reused across environments, supporting consistent operational workflows.

Analysis of the captured event data confirmed the lockout source originated from a specific workstation, demonstrating how centralized logging enables precise root cause identification without requiring access to the affected endpoint.

### Screenshot

**Advanced Audit Policy Configuration – Account Logon and Account Management auditing enabled via Group Policy on the Domain Controller:**

<img width="600" height="400" alt="Screenshot from 2025-12-20 15-57-11" src="https://github.com/user-attachments/assets/21c69f64-27a1-4f29-bde1-818330d78efd" />

---

**Event Viewer – Event ID 4740 – Security log entry showing the locked-out account and the caller computer name responsible for the lockout:**

<img width="600" height="400" alt="Screenshot from 2025-12-20 20-07-09" src="https://github.com/user-attachments/assets/ca925729-3f5c-4a6c-a5e4-66e86697e297" />

---

**Custom Event Viewer View – Dedicated “Account Lockouts” view filtered on Event ID 4740 for rapid triage and ongoing monitoring:**

<img width="600" height="400" alt="Screenshot from 2025-12-20 20-17-26" src="https://github.com/user-attachments/assets/48c52e26-1936-47ed-b89f-39c56af31a85" />


### Reflection
This lab reinforced the importance of proactive auditing and centralized logging in Active Directory environments. Rather than relying on user reports or guesswork, account lockout investigations can be resolved quickly by examining authoritative data from the Domain Controller. Identifying the caller computer name is especially valuable, as lockouts are often caused by cached credentials, scheduled tasks, mapped drives, or outdated passwords on secondary devices.

Creating a reusable Custom Event Viewer View mirrors real enterprise practices, where help desk and security teams rely on standardized tools to reduce response time and improve accuracy. This lab demonstrated how proper audit configuration transforms authentication failures from a frustrating mystery into a straightforward, evidence-driven investigation.

## Final Thoughts

Phase 4 focused on enforcing security controls that directly reduce risk in Active Directory environments. Deploying LAPS, enforcing BitLocker with recovery options, and enabling detailed account lockout auditing demonstrated how identity, endpoint, and logging controls work together to strengthen defensive posture.

A key takeaway from this phase was that security controls must be both enforced and verifiable. Retrieving LAPS passwords, validating BitLocker encryption states, and tracing lockout events to their source all emphasized the importance of confirmation rather than assumption. Security features only provide value when administrators can confidently validate their behavior.

Overall, this phase reinforced a practical approach to security hardening centralized policy, least privilege, auditability, and recovery readiness aligned with real-world operational and incident response requirements.
