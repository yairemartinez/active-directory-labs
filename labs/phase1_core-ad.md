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

Client joined to the **lab.local** domain:
<img width="600" height="400" alt="Screenshot 2025-12-01 155907" src="https://github.com/user-attachments/assets/c5ab4d88-298b-428a-ac78-d35d357ecb63" />

Computer object visible in Active Directory Users and Computers:
<img width="600" height="400" alt="Screenshot from 2025-12-01 23-49-24" src="https://github.com/user-attachments/assets/c4483d10-dab1-4d07-a4c4-c3fde587bd08" />

**Reflection:**  
This lab reinforced how DNS underpins Active Directory functionality and highlighted the proper workflow for onboarding new workstations. It also demonstrated the value of verification steps such as DNS testing and confirming AD computer objects.

