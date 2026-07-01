param(
  [Parameter(Mandatory = $true)]
  [string]$TunnelName,

  [Parameter(Mandatory = $true)]
  [string]$Hostname
)

$ErrorActionPreference = "Stop"

$Cloudflared = "C:\Program Files (x86)\cloudflared\cloudflared.exe"
$ProjectRoot = Split-Path -Parent $PSScriptRoot
$ConfigDir = Join-Path $ProjectRoot "deploy\cloudflare"
$ConfigPath = Join-Path $ConfigDir "config.yml"

if (-not (Test-Path -LiteralPath $Cloudflared)) {
  throw "cloudflared not found: $Cloudflared"
}

New-Item -ItemType Directory -Force -Path $ConfigDir | Out-Null

& $Cloudflared tunnel create $TunnelName

$TunnelId = (& $Cloudflared tunnel list --output json | ConvertFrom-Json | Where-Object { $_.name -eq $TunnelName } | Select-Object -First 1 -ExpandProperty id)
if (-not $TunnelId) {
  throw "Could not locate tunnel id for $TunnelName"
}

$CredentialFile = Join-Path $env:USERPROFILE ".cloudflared\$TunnelId.json"

@"
tunnel: $TunnelId
credentials-file: $CredentialFile

ingress:
  - hostname: $Hostname
    service: http://localhost:8888
  - service: http_status:404
"@ | Set-Content -LiteralPath $ConfigPath -Encoding UTF8

& $Cloudflared tunnel route dns $TunnelName $Hostname

Write-Host "Tunnel created." -ForegroundColor Green
Write-Host "Config: $ConfigPath"
Write-Host "Run: `"$Cloudflared`" tunnel --config `"$ConfigPath`" run"
