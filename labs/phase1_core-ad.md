# Phase 1 – Core AD and Client Join

This phase documents domain creation and basic client integration.  
I originally completed these labs earlier and am now redoing them to record each step clearly.

**Goal:** Join Windows 11 clients to the lab.local domain, create users, and apply a basic Group Policy Object.

**Key Tasks**
- Join Windows 11 client to domain  
- Create organizational unit “LabUsers”  
- Create user “jdoe” and test login  
- Reset and unlock user passwords  
- Create FinanceGroup and assign permissions  

# Lab 1 – Join Windows 11 to the Domain
**Purpose:** Ensure a Windows 11 workstation can be integrated into an Active Directory environment using proper DNS and domain-join procedures.

### Summary  
In this lab, I configured a Windows 11 client to use the Domain Controller as its DNS server, enabling proper domain discovery. I then initiated the domain join process by accessing the system settings and specifying the domain name **lab.local**.

After providing domain administrator credentials, the workstation successfully joined the domain and rebooted. Upon restart, I validated the join by signing in with a domain account and confirming that the domain relationship was fully established. Additional verification included checking the computer object in Active Directory Users and Computers (ADUC) and confirming DNS resolution back to the Domain Controller.

### Screenshot:
**Client joined to the **lab.local** domain:**

<img width="600" height="400" alt="Screenshot 2025-12-02 131431" src="https://github.com/user-attachments/assets/53bdf368-8f47-4915-a933-5f1775d71f63" />

---

**Computer object visible in Active Directory Users and Computers:**

<img width="600" height="400" alt="Screenshot from 2025-12-01 23-49-24" src="https://github.com/user-attachments/assets/c4483d10-dab1-4d07-a4c4-c3fde587bd08" />

### Reflection:
This lab reinforced how DNS underpins Active Directory functionality and highlighted the proper workflow for onboarding new workstations. It also demonstrated the value of verification steps such as DNS testing and confirming AD computer objects.

# Lab 2 – Create and Manage Users
**Purpose:** Establish the foundational process for creating, organizing, and managing user accounts within Active Directory.

### Summary
In this lab, I created a new user account, **Jane Doe**, inside the **LabUsers** organizational unit using Active Directory Users and Computers (ADUC). I assigned an initial password and enabled “User must change password at next logon” to enforce proper credential hygiene. 

During testing, the Windows 11 client initially attempted to authenticate using my host network because IPv6 routing caused DNS lookups to bypass the Domain Controller. After disabling IPv6 on the VM’s network adapter, the system correctly used the DC’s DNS server, allowing me to log in successfully as Jane Doe. This validated that user authentication, OU placement, and domain DNS behavior were all functioning correctly.

### Screenshot 
**ADUC showing the newly created Jane Doe user in the LabUsers OU:**  

<img width="600" height="400" alt="Screenshot from 2025-12-02 14-18-44" src="https://github.com/user-attachments/assets/bb1d83af-a77e-4b4f-a9b9-71bbb278bb88" />

### Reflection  
This lab reinforced proper user lifecycle management and highlighted how DNS and network configuration directly affect domain authentication. Correctly resolving the IPv6 issue also demonstrated the importance of troubleshooting in real-world AD environments.

## Lab 3 – Password Reset and Account Lockout
**Purpose:** Demonstrate how to identify, unlock, and reset a user account that has been locked out or has forgotten their password.

### Summary
In this lab, I simulated an account lockout by entering incorrect credentials five times on the domain-joined Windows 11 client. The client became stuck on a loading/login screen, indicating that the user account had triggered the lockout threshold defined in the domain policy. 

Using Active Directory Users and Computers (ADUC), I accessed the user properties to verify the lockout status and initiate a secure password reset. I then unlocked the account and enabled the “User must change password at next logon” setting, allowing the user to choose a new password that meets domain complexity requirements. After completing the reset, I confirmed that the user could log in successfully again, restoring normal access.

### Screenshot  
**ADUC showing password reset and unlock options for the locked-out account:**

<img width="600" height="400" alt="Screenshot from 2025-12-02 16-01-27" src="https://github.com/user-attachments/assets/cebabccf-de94-4589-b8d3-5b5a6dbf01a7" />

### Reflection
This lab reinforced the core help desk workflow for quickly resolving user lockout incidents while maintaining secure password practices. It also highlighted how account lockout thresholds directly affect user experience and why rapid remediation is essential in production environments.

## Lab 4 – Group Membership
**Purpose:** Demonstrate how to manage user access to shared resources through security group membership within Active Directory.

### Summary: 
In this lab, I created a security group named **FinanceGroup** to manage permission assignments for a shared finance directory. I added both Jane Doe and John Doe to the group, ensuring they would inherit access rights without modifying their individual user accounts.

On the Domain Controller, I created and shared a folder located at **C:\Finance**, granting access exclusively to FinanceGroup in accordance with least-privilege principles. I then logged into a Windows 11 client as Jane Doe to confirm she could access the shared resource, while a non-member user (Helpdesk1) was unable to do so. These tests verified that group membership and NTFS/share permissions were functioning correctly.

### Screenshots: 
**ADUC showing FinanceGroup membership (Jane Doe and John Doe):**

<img width="600" height="400" alt="Screenshot from 2025-12-02 18-50-24" src="https://github.com/user-attachments/assets/f70cfafc-9804-4e4a-bc1d-de9a52235660" />

---

**Client-side validation: Jane Doe can access the Finance share, while Helpdesk1 cannot:**  

<img width="600" height="400" alt="Screenshot 2025-12-02 185750" src="https://github.com/user-attachments/assets/c8f4f028-4b40-4982-a03c-d940fde895df" />

### Reflection 
This lab demonstrated how security groups centralize and simplify permission management while maintaining strong access control practices. Testing both permitted and denied access reinforced the importance of verifying group-based permissions from a user’s perspective.

## Lab 5 – Basic GPO: Restrict Control Panel
**Purpose:** Enforce organizational restrictions by blocking standard domain users from accessing the Windows Control Panel using Group Policy.

### Summary 
In this lab, I created a Group Policy Object (GPO) named **NoControlPanel** to restrict access to the Control Panel and PC Settings for users in the **LabUsers** OU. Using the Group Policy Management Console, I enabled the setting **“Prohibit access to Control Panel and PC settings”** under User Configuration → Policies → Administrative Templates → Control Panel. 

After linking the GPO to the LabUsers OU, I logged into the Windows 11 client as Jane Doe and applied the policy using **gpupdate /force**. When attempting to open Control Panel or Settings, the system displayed the expected restriction message, confirming the GPO was successfully enforced. Validation also confirmed that administrative accounts remained unaffected, demonstrating proper scope and policy targeting.

### Screenshots  
**GPO setting enabled for prohibiting Control Panel access:**  

<img width="600" height="400" alt="Screenshot from 2025-12-02 20-47-48" src="https://github.com/user-attachments/assets/65651302-95c7-41ce-ae19-41c5938ee8e6" />

---

**Client-side validation showing restriction message when attempting to open Control Panel:**  

<img width="600" height="400" alt="Screenshot 2025-12-02 204917" src="https://github.com/user-attachments/assets/bc208e59-94c1-4fdd-af2a-53759eb707bb" />

### Reflection  
This lab demonstrated how Group Policy can restrict user access to sensitive system settings without impacting administrators. It reinforced the importance of linking GPOs at the correct OU level to ensure precise and intentional policy application.


## Final Thoughts for Phase 1
Phase 1 provided a complete walkthrough of domain joining, basic user and group administration, and introductory GPO enforcement. Documenting each step clarified how these foundational pieces fit together and strengthened troubleshooting habits that apply directly to real-world IT support environments.
