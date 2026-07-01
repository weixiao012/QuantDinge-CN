param(
  [Parameter(Mandatory = $true)]
  [string]$Email
)

$ErrorActionPreference = "Stop"

$Body = @{ email = $Email } | ConvertTo-Json
$Response = Invoke-RestMethod -Method Post -Uri "http://localhost:8888/api/auth/send-code" -ContentType "application/json" -Body $Body
$Response | ConvertTo-Json -Depth 5
