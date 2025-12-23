param(
  [string]$CsvPath = ".\new_users.csv",
  [string]$DefaultPassword = "P@ssw0rd123!"
)

Import-Module ActiveDirectory

$users = Import-Csv $CsvPath

foreach ($u in $users) {
  $sam  = $u.User.Trim()
  $name = "$($u.First.Trim()) $($u.Last.Trim())"
  $ou   = $u.OU.Trim()
  $upn  = "$sam@lab.local"

  try {
    # --- Validate OU exists (catch bad DN early) ---
    Get-ADOrganizationalUnit -Identity $ou -ErrorAction Stop | Out-Null

    # --- Skip if user already exists ---
    if (Get-ADUser -Filter "SamAccountName -eq '$sam'" -ErrorAction SilentlyContinue) {
      Write-Host "SKIP: $sam already exists" -ForegroundColor Yellow
      continue
    }

    # --- Create user ---
    New-ADUser `
      -Name $name `
      -GivenName $u.First `
      -Surname $u.Last `
      -SamAccountName $sam `
      -UserPrincipalName $upn `
      -Path $ou `
      -AccountPassword (ConvertTo-SecureString $DefaultPassword -AsPlainText -Force) `
      -Enabled $true `
      -ChangePasswordAtLogon $true

    # --- Groups (create if missing, then add) ---
    if ($u.Groups) {
      $groups = $u.Groups -split ";" | ForEach-Object { $_.Trim() } | Where-Object { $_ }

      foreach ($g in $groups) {
        # Create group if it does not exist
        if (-not (Get-ADGroup -Identity $g -ErrorAction SilentlyContinue)) {
          Write-Host "  Creating group $g since it does not exist..." -ForegroundColor Cyan
          New-ADGroup -Name $g -GroupScope Global -GroupCategory Security -Path "OU=LabUsers,DC=lab,DC=local"
        }

        Add-ADGroupMember -Identity $g -Members $sam -ErrorAction Stop
      }
    }

    Write-Host "Created $sam successfully" -ForegroundColor Green
  }
  catch {
    Write-Host "ERROR for $sam : $($_.Exception.Message)" -ForegroundColor Red
  }
}
