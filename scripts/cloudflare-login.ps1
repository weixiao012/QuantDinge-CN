$ErrorActionPreference = "Stop"

$Cloudflared = "C:\Program Files (x86)\cloudflared\cloudflared.exe"
if (-not (Test-Path -LiteralPath $Cloudflared)) {
  throw "cloudflared not found: $Cloudflared"
}

& $Cloudflared tunnel login
