$ErrorActionPreference = "Stop"

$ProjectRoot = Split-Path -Parent $PSScriptRoot
$Publish = Join-Path $ProjectRoot "github-publish"
$WorkspaceRoot = Split-Path -Parent $ProjectRoot

if (Test-Path -LiteralPath $Publish) {
  $Resolved = (Resolve-Path -LiteralPath $Publish).Path
  if (-not $Resolved.StartsWith($ProjectRoot, [System.StringComparison]::OrdinalIgnoreCase)) {
    throw "Refusing to remove unexpected path: $Resolved"
  }
  Remove-Item -LiteralPath $Publish -Recurse -Force
}

New-Item -ItemType Directory -Force -Path $Publish | Out-Null

Copy-Item -LiteralPath (Join-Path $WorkspaceRoot "AGENTS.md") -Destination $Publish
Copy-Item -Path (Join-Path $WorkspaceRoot "*.md") -Destination $Publish

Copy-Item -LiteralPath (Join-Path $ProjectRoot "README.md") -Destination $Publish

foreach ($dir in @("docs", "scripts", "assets", "deliverables", "logs")) {
  Copy-Item -LiteralPath (Join-Path $ProjectRoot $dir) -Destination (Join-Path $Publish $dir) -Recurse -Force
}

New-Item -ItemType Directory -Force -Path (Join-Path $Publish "source") | Out-Null

function Copy-Snapshot($From, $To) {
  robocopy $From $To /E /XD .git node_modules dist .next .vite .cache github-publish /XF .env backend.env .env.local .env.production.local | Out-Host
  if ($LASTEXITCODE -gt 7) {
    throw "robocopy failed: $From"
  }
}

Copy-Snapshot (Join-Path $ProjectRoot "source\QuantDinger") (Join-Path $Publish "source\QuantDinger")
Copy-Snapshot (Join-Path $ProjectRoot "source\QuantDinger-Vue") (Join-Path $Publish "source\QuantDinger-Vue")

@(
  "backend.env",
  ".env",
  ".env.local",
  ".env.*.local",
  "node_modules/",
  "dist/",
  ".next/",
  ".vite/",
  ".cache/",
  "*.log",
  "deploy/cloudflare/config.yml"
) | Set-Content -LiteralPath (Join-Path $Publish ".gitignore") -Encoding UTF8

Write-Host "Publish snapshot created: $Publish" -ForegroundColor Green
