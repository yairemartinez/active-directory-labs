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

# Lab 1 – Join Windows 10 to the Domain
**Purpose:** Ensure a Windows 10 workstation can be integrated into an Active Directory environment using proper DNS and domain-join procedures.

**Summary:**  
In this lab, I configured a Windows 11 client to use the Domain Controller as its DNS server, enabling proper domain discovery. I then initiated the domain join process by accessing the system settings and specifying the domain name **lab.local**. After providing domain administrator credentials, the workstation successfully joined the domain and rebooted. Upon restart, I validated the join by signing in with a domain account and confirming that the domain relationship was fully established. Additional verification included checking the computer object in Active Directory Users and Computers (ADUC) and confirming DNS resolution back to the Domain Controller.

**Screenshot:**  
Client joined to the **lab.local** domain:

<img width="600" height="400" alt="Screenshot 2025-12-02 131431" src="https://github.com/user-attachments/assets/53bdf368-8f47-4915-a933-5f1775d71f63" />

Computer object visible in Active Directory Users and Computers:

<img width="600" height="400" alt="Screenshot from 2025-12-01 23-49-24" src="https://github.com/user-attachments/assets/c4483d10-dab1-4d07-a4c4-c3fde587bd08" />

**Reflection:**  
This lab reinforced how DNS underpins Active Directory functionality and highlighted the proper workflow for onboarding new workstations. It also demonstrated the value of verification steps such as DNS testing and confirming AD computer objects.

# Lab 2 – Create and Manage Users
**Purpose:** Establish the foundational process for creating, organizing, and managing user accounts within Active Directory.

**Summary:**  
In this lab, I created a new user account, **Jane Doe**, inside the **LabUsers** organizational unit using Active Directory Users and Computers (ADUC). I assigned an initial password and enabled “User must change password at next logon” to enforce proper credential hygiene. During testing, the Windows 11 client initially attempted to authenticate using my host network because IPv6 routing caused DNS lookups to bypass the Domain Controller. After disabling IPv6 on the VM’s network adapter, the system correctly used the DC’s DNS server, allowing me to log in successfully as Jane Doe. This validated that user authentication, OU placement, and domain DNS behavior were all functioning correctly.

**Screenshot:**  
ADUC showing the newly created Jane Doe user in the LabUsers OU:  

<img width="600" height="400" alt="Screenshot from 2025-12-02 14-18-44" src="https://github.com/user-attachments/assets/bb1d83af-a77e-4b4f-a9b9-71bbb278bb88" />

**Reflection:**  
This lab reinforced proper user lifecycle management and highlighted how DNS and network configuration directly affect domain authentication. Correctly resolving the IPv6 issue also demonstrated the importance of troubleshooting in real-world AD environments.



