# Input bindings are passed in via param block.
param($Timer)

# Get the current universal time in the default string format
$currentUTCtime = (Get-Date).ToUniversalTime()

# The 'IsPastDue' porperty is 'true' when the current function invocation is later than scheduled.
if ($Timer.IsPastDue) {
    Write-Host "PowerShell timer is running late!"
}

$appID = "543adfd8-d9d7-4a0c-9015-c1718d6a4ac9"

$password = "G0Q7Q~.anAvjQadCyjvEeKbIbfpGhVDMuuJEF"

$tenantID = "72f988bf-86f1-41af-91ab-2d7cd011db47"

$subscriptionID = "504215e5-c473-41bd-ad45-ab065b50d098"

$secpasswd = ConvertTo-SecureString $password -AsPlainText -Force

$mycreds = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $appID, $secpasswd

Connect-AzAccount -ServicePrincipal -TenantID $tenantID -SubscriptionId $subscriptionID -Credential $mycreds

Restart-AzWebApp -ResourceGroupName "SethB-TestAppsRG" -Name "PStest-sethb"

# Write an information log with the current time.
Write-Host "PowerShell timer trigger function ran! TIME: $currentUTCtime"
