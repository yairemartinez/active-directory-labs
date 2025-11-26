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

## Notes
Document the exact GPO paths, scope settings, and test results.  
Include screenshots showing the mapped drive and printer appearing automatically.

## Reflection
This phase highlights how centralized policies reduce configuration time.  
Revisiting and documenting it makes the GPO workflow easier to repeat and troubleshoot.
