# Input bindings are passed in via param block.
param($Timer)

# Get the current universal time in the default string format
$currentUTCtime = (Get-Date).ToUniversalTime()

# The 'IsPastDue' porperty is 'true' when the current function invocation is later than scheduled.
if ($Timer.IsPastDue) {
    Write-Host "PowerShell timer is running late!"
}

$appID = "<Your App ID>"

$password = "<Your AAD app Secret>"

$tenantID = "<Your Tenant ID>"

$subscriptionID = "<Your Subscription ID>"

$secpasswd = ConvertTo-SecureString $password -AsPlainText -Force

$mycreds = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $appID, $secpasswd

Connect-AzAccount -ServicePrincipal -TenantID $tenantID -SubscriptionId $subscriptionID -Credential $mycreds

Restart-AzWebApp -ResourceGroupName "<Your Resource Group>" -Name "<Your App Name>"

# Write an information log with the current time.
Write-Host "PowerShell timer trigger function ran! TIME: $currentUTCtime"
