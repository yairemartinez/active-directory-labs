param(
  [Parameter(Mandatory)][string]$User
)

Import-Module ActiveDirectory

Write-Host "=== Help Desk Toolkit ===" -ForegroundColor Cyan
Write-Host "[1] Unlock account"
Write-Host "[2] Reset password"
Write-Host "[3] Add to group"
Write-Host "[4] Exit"
$choice = Read-Host "Select an option"

switch ($choice) {
  '1' {
    Unlock-ADAccount -Identity $User
    Write-Host "Unlocked $User" -ForegroundColor Green
  }
  '2' {
    $p = Read-Host "Enter new password" -AsSecureString
    Set-ADAccountPassword -Identity $User -NewPassword $p -Reset
    Write-Host "Password reset for $User" -ForegroundColor Green
    $force = Read-Host "Force change at next logon? (Y/N)"
    if ($force -match '^[Yy]') { Set-ADUser $User -ChangePasswordAtLogon $true }
  }
  '3' {
    $g = Read-Host "Enter group name"
    Add-ADGroupMember -Identity $g -Members $User
    Write-Host "Added $User to $g" -ForegroundColor Green
  }
  default {
    Write-Host "Goodbye."
  }
}
