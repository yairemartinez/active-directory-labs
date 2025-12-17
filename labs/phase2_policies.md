# Phase 2 – User Access and Policies

This phase focuses on controlling user access with Group Policy and shared resources.  
The goal is to manage drive mappings, shared folders, shared printers, and user restrictions through standardized policies.

## Objectives
- Create and secure shared folders
- Map network drives with GPO
- Deploy a shared printer to users
- Restrict Control Panel access for standard users

## Key Tasks
1. Create a Security Group for Finance users.
2. Share the Finance folder and assign permissions.
3. Create a GPO to map the Finance drive for group members.
4. Install and share a test printer on the Domain Controller.
5. Deploy the printer using Group Policy Preferences.
6. Apply a Control Panel restriction policy to the user OU.
7. Test all changes using the jdoe account.

# Lab 6 – Map a Drive with GPO
**Purpose:** Automatically assign shared network resources to users by mapping a drive letter through Group Policy.

**Summary:**  
In this lab, I created a Group Policy Object named **MapFinanceDrive** to automatically map the Finance shared folder to drive letter **F:** for authorized users. Using Group Policy Management, I configured a Drive Maps preference pointing to the UNC path `\\DC01\Finance` and set the action to **Replace**, ensuring the drive mapping remained consistent across logins. I scoped the GPO so that it applied only to members of **FinanceGroup**, allowing the mapping to follow the user rather than the device. After applying the updated policy with **gpupdate /force**, I logged in as Jane Doe and confirmed that the Finance Drive appeared under Network Locations. A comparison test with a non-member account (Helpdesk1) demonstrated that the drive was not mapped for unauthorized users, validating proper security scoping and GPO functionality.

**Screenshots:**  
GPO configuration for mapping the Finance Drive (F:) via Drive Maps:  

<img width="600" height="400" alt="image" src="https://github.com/user-attachments/assets/acf1a0f0-5c5c-4fc5-bb11-de09c452def5" />

Client-side validation: Jane Doe receives the mapped Finance Drive, Helpdesk1 does not:  

<img width="600" height="400" alt="image" src="https://github.com/user-attachments/assets/5163dfdc-c6be-43c3-92e0-886282cd3c49" />

**Reflection:**  
This lab demonstrated how Group Policy Preferences streamline access to shared resources and eliminate the need for manual drive mappings. It also highlighted the importance of using security groups to enforce precise, role-based access control.

# Lab 7 – Deploy a Printer via GPO
**Purpose:** Automatically deploy shared printers to authorized users through Group Policy to simplify workstation setup and enforce role-based access.

**Summary:**  
In this lab, I configured a shared printer on the Domain Controller using an existing printer device and published it as **FinancePrinter**. Printer sharing was enabled and the device was listed in Active Directory so it could be deployed via Group Policy. I then created a Group Policy Object named **DeployFinancePrinter** and configured a Shared Printer preference under User Configuration → Preferences → Control Panel Settings → Printers. The GPO was scoped to the **FinanceGroup**, ensuring only authorized users received the printer automatically. After applying policy updates on client machines, I verified that Finance users received the printer while a non-member account did not, confirming correct policy targeting and access control.

**Screenshots:**  
Server-side configuration showing the printer shared as FinancePrinter:  

<img width="600" height="400" alt="ffd25470-9cae-41a1-8d59-e11481a81990" src="https://github.com/user-attachments/assets/9bc090f6-9ddc-49cc-9113-f1767ad12cd3" />

Client-side validation: Finance user receives the printer automatically, while a non-member user does not:  

<img width="600" height="400" alt="aa57f0c3-c88b-404f-b2ee-4972da734013" src="https://github.com/user-attachments/assets/f4aa3b3f-3c0e-4de6-b15f-b3a90921b4fe" />

**Reflection:**  
This lab demonstrated how Group Policy can automate printer deployment and reduce manual configuration overhead. It also reinforced the importance of scoping policies to security groups to ensure resources are delivered only to the appropriate users.

# Lab 8 – Add a Second Windows 10 Client
**Purpose:** Confirm that user-based Group Policy settings and access controls persist consistently across multiple domain-joined workstations.

**Summary:**  
In this lab, I validated multi-client policy behavior by logging into a second domain-joined Windows 10 workstation using existing domain user accounts. The client had already been joined to the **lab.local** domain using the same process documented in Lab 1. When logging in as a Finance user, previously configured Group Policies—including the mapped Finance drive and deployed printer—applied automatically without additional configuration. Logging in with a non-member account confirmed that restricted users did not receive Finance-specific resources. This demonstrated that policies were applied based on user identity rather than device-specific configuration.

**Reflection:**  
This lab reinforced the effectiveness of centralized user-based policy management in Active Directory environments. It also demonstrated how consistent configuration across multiple endpoints simplifies administration and scales cleanly in real-world deployments.

# Lab 9 – Folder Redirection / Roaming Profile
**Purpose:** Centralize user data by redirecting user folders to the server so files persist across multiple domain-joined workstations.

**Summary:**  
In this lab, I configured folder redirection to centralize user Documents on the Domain Controller using a shared directory named **UserProfiles**. The folder was shared with appropriate permissions and made accessible via the UNC path `\\DC01\UserProfiles`. Using Group Policy Management, I created a policy to redirect the **Documents** folder for users in the LabUsers OU, configuring it to create a separate folder for each user under the root share. After applying the policy, I logged in as a domain user and confirmed that Documents were stored on the server rather than the local machine. Logging into a different domain-joined workstation with the same account showed the same files immediately available, confirming successful folder redirection across devices.

**Screenshots:**  
Server-side configuration showing the UserProfiles share and permissions:  

<img width="600" height="400" alt="image" src="https://github.com/user-attachments/assets/6e1ed0f9-2db1-4766-bd36-a5527c8665db" />

GPO configuration redirecting user Documents to the server:  

<img width="600" height="400" alt="image" src="https://github.com/user-attachments/assets/6c66813c-6dff-4e97-9d71-91cc7af6906e" />

Client-side validation showing Documents redirected to the network location:  

<img width="600" height="400" alt="image" src="https://github.com/user-attachments/assets/ecbce5a8-a12e-4d90-ac89-e8f164817d05" />

**Reflection:**  
This lab demonstrated how folder redirection improves data availability, simplifies backups, and reduces dependency on individual workstations. It also reinforced the value of centralized storage in environments where users access multiple devices.

# Lab 10 – Password and Account Policy Hardening
**Purpose:** Strengthen domain security by enforcing consistent password complexity and account lockout policies across all users.

**Summary:**  
In this lab, I hardened domain authentication by modifying the **Default Domain Policy** to enforce stronger password and account controls. Password complexity requirements were enabled, the minimum password length was increased, password history was enforced, and a maximum password age was configured to reduce credential reuse. These changes ensured all domain users were subject to consistent security standards. To validate enforcement, I attempted authentication with invalid credentials from a client workstation, which resulted in delayed login attempts and lockout behavior. This confirmed that the updated password and account policies were actively protecting the domain.

**Screenshots:**  
Default Domain Policy showing enforced password complexity, history, and age requirements:  

<img width="600" height="400" alt="b39b58e5-b9f6-4696-89e8-9fda78c16313" src="https://github.com/user-attachments/assets/aa14f0f3-43e3-43d0-871d-417efe0e9e20" />

Client-side validation showing delayed login attempts after invalid credentials:  

<img width="600" height="400" alt="24a5ddd6-805a-4599-bed8-84ca12c8105a" src="https://github.com/user-attachments/assets/bbb9d68d-50b4-4896-a826-6905f1801e54" />

**Reflection:**  
This lab demonstrated how domain-wide policies significantly improve security posture by reducing weak passwords and brute-force attempts. It also reinforced the importance of validating security controls from an end-user perspective.


