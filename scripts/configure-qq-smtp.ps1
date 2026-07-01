$ErrorActionPreference = "Stop"

$ProjectRoot = Split-Path -Parent $PSScriptRoot
$BackendEnv = Join-Path $ProjectRoot "source\QuantDinger\backend.env"
$Docker = "C:\Program Files\Docker\Docker\resources\bin\docker.exe"

if (-not (Test-Path -LiteralPath $BackendEnv)) {
  throw "backend.env not found: $BackendEnv"
}

function Set-EnvValue($Path, $Key, $Value) {
  $lines = [System.Collections.Generic.List[string]](Get-Content -LiteralPath $Path)
  $found = $false
  for ($i = 0; $i -lt $lines.Count; $i++) {
    if ($lines[$i] -match "^$([regex]::Escape($Key))=") {
      $lines[$i] = "$Key=$Value"
      $found = $true
      break
    }
  }
  if (-not $found) {
    $lines.Add("$Key=$Value")
  }
  Set-Content -LiteralPath $Path -Value $lines -Encoding UTF8
}

$Email = Read-Host "QQ email, for example 123456@qq.com"
$SecureCode = Read-Host "QQ SMTP authorization code" -AsSecureString
$Ptr = [Runtime.InteropServices.Marshal]::SecureStringToBSTR($SecureCode)
try {
  $AuthCode = [Runtime.InteropServices.Marshal]::PtrToStringBSTR($Ptr)
} finally {
  [Runtime.InteropServices.Marshal]::ZeroFreeBSTR($Ptr)
}

if (-not $Email -or -not $AuthCode) {
  throw "Email and authorization code are required."
}

Set-EnvValue $BackendEnv "SMTP_HOST" "smtp.qq.com"
Set-EnvValue $BackendEnv "SMTP_PORT" "465"
Set-EnvValue $BackendEnv "SMTP_USER" $Email
Set-EnvValue $BackendEnv "SMTP_FROM" $Email
Set-EnvValue $BackendEnv "SMTP_PASSWORD" $AuthCode
Set-EnvValue $BackendEnv "SMTP_USE_TLS" "false"
Set-EnvValue $BackendEnv "SMTP_USE_SSL" "true"

& $Docker restart quantdinger-backend | Out-Host
Write-Host "QQ SMTP configured. Backend restarted." -ForegroundColor Green
