<#
.SYNOPSIS
  Sets up an Undeify team member's Windows machine: shared vault, Obsidian, Junior's boot file,
  Claude Code memory redirect, and a "Chat with Junior" Desktop launcher.

.DESCRIPTION
  Safe to re-run. It never overwrites an existing CLAUDE.md, MEMORY.md or launcher, and it backs up
  Obsidian's obsidian.json before adding the vault to it. See Onboarding.md in this folder.

  Run it with:
    powershell -ExecutionPolicy Bypass -File "$HOME\Undeify\08 - Resources\Onboarding\onboard.ps1"
#>
[CmdletBinding()]
param(
  [string]$Name,
  [string]$RepoUrl,
  [string]$VaultDir = (Join-Path $HOME 'Undeify'),
  [string]$AgentDir = (Join-Path $HOME 'my-agent'),
  [string]$ObsidianConfigDir = (Join-Path $env:APPDATA 'obsidian'),
  [string]$ClaudeProjectsDir = (Join-Path $HOME '.claude\projects'),
  [string]$DesktopDir = [Environment]::GetFolderPath('Desktop'),
  [string]$SkillsDir = (Join-Path $HOME '.claude\skills'),
  # Extra plugins from kit\plugins.json to install on top of the core kit, e.g. -Extras supabase,sentry or -Extras all
  [string[]]$Extras = @(),
  [switch]$DryRun,        # print what plugins would be installed, install nothing
  [switch]$SkipPlugins
)

$ErrorActionPreference = 'Stop'
$utf8 = New-Object System.Text.UTF8Encoding($false)

function Say($m)  { Write-Host "==> $m" -ForegroundColor Cyan }
function Warn($m) { Write-Host "!!  $m" -ForegroundColor Yellow }
function Have($c) { [bool](Get-Command $c -ErrorAction SilentlyContinue) }
function Refresh-Path {
  $env:Path = [Environment]::GetEnvironmentVariable('Path','Machine') + ';' + [Environment]::GetEnvironmentVariable('Path','User')
}

# 0. Who is this for
if (-not $Name) { $Name = Read-Host "What's your first name?" }
$Name = $Name.Trim()
if ($Name -notmatch "^[\p{L} .'-]{1,40}$") { throw "That name has characters I won't put in a config file. Use letters only." }

# 1. Git
if (-not (Have git)) {
  if (-not (Have winget)) { throw "Git is missing and winget isn't available. Install Git from https://git-scm.com and run this again." }
  Say 'Installing Git...'
  winget install --id Git.Git -e --silent --accept-package-agreements --accept-source-agreements
  Refresh-Path
  if (-not (Have git)) { throw 'Git installed but this window cannot see it yet. Close this window, open a new PowerShell, and run the script again.' }
}

# 2. The vault
if (Test-Path (Join-Path $VaultDir '.git')) {
  Say "Vault already at $VaultDir. Pulling the latest..."
  git -C $VaultDir pull --ff-only
  if ($LASTEXITCODE -ne 0) { throw 'git pull failed. Resolve it in the vault folder, then run this again.' }
} else {
  if ((Test-Path $VaultDir) -and (Get-ChildItem $VaultDir -Force | Select-Object -First 1)) {
    throw "$VaultDir exists and isn't the Undeify vault. Move it or pass -VaultDir with another path."
  }
  if (-not $RepoUrl) { $RepoUrl = Read-Host 'Paste the private vault repo URL' }
  Say "Cloning the vault to $VaultDir (GitHub may ask you to sign in)..."
  git clone $RepoUrl $VaultDir
  if ($LASTEXITCODE -ne 0) { throw 'git clone failed. Check the URL and that you have been added to the repo.' }
}
# Turn on the vault's secret-scan hook: commits that add keys, tokens or .env files are blocked.
git -C $VaultDir config core.hooksPath .githooks
$tplPath = Join-Path $VaultDir '08 - Resources\Onboarding\CLAUDE.template.txt'
if (-not (Test-Path $tplPath)) { throw "Boot-file template not found at $tplPath. Is this the Undeify vault?" }

# 3. Obsidian
$obsExe = Join-Path $env:LOCALAPPDATA 'Programs\Obsidian\Obsidian.exe'
if (Test-Path $obsExe) {
  Say 'Obsidian is already installed.'
} elseif (Have winget) {
  Say 'Installing Obsidian...'
  winget install --id Obsidian.Obsidian --silent --accept-package-agreements --accept-source-agreements
} else {
  Warn 'winget is not available. Install Obsidian from https://obsidian.md, then run this script again.'
}

# 4. Junior's boot file
New-Item -ItemType Directory -Force -Path $AgentDir | Out-Null
$claudeMd = Join-Path $AgentDir 'CLAUDE.md'
$boot = (Get-Content -Raw -Encoding UTF8 $tplPath).Replace('{{NAME}}', $Name).Replace('{{VAULT_PATH}}', $VaultDir)
if (Test-Path $claudeMd) {
  if ((Get-Content -Raw -Encoding UTF8 $claudeMd) -ceq $boot) {
    Say 'Junior''s boot file is already up to date.'
  } else {
    [IO.File]::WriteAllText("$claudeMd.new", $boot, $utf8)
    Warn "A different CLAUDE.md already exists in $AgentDir, so I left it alone. The current template is CLAUDE.md.new; compare and merge by hand."
  }
} else {
  [IO.File]::WriteAllText($claudeMd, $boot, $utf8)
  Say "Wrote Junior's boot file to $claudeMd"
}

# 5. One memory, not two: point Claude Code's own memory at the vault
$projName = $AgentDir -replace '[^a-zA-Z0-9]', '-'
$memDir = Join-Path $ClaudeProjectsDir "$projName\memory"
$memFile = Join-Path $memDir 'MEMORY.md'
if (Test-Path $memFile) {
  Say 'Claude Code memory redirect already exists; leaving it.'
} else {
  New-Item -ItemType Directory -Force -Path $memDir | Out-Null
  $redirect = @'
There is no separate memory layer here. The single source of truth is the Obsidian vault.

Sources of truth, in load order:
- CLAUDE.md (boot config, in the working folder — not the vault) — startup sequence + the rules that can't lapse.
- VAULT-INDEX.md (vault root) — profile, full rules, the system map.
- Everything else lives in its contextual home in the vault.

To remember something, write it to its place in the vault, never here.
'@
  [IO.File]::WriteAllText($memFile, $redirect, $utf8)
  Say "Wrote the memory redirect to $memFile"
}

# 6. Register the vault with Obsidian
$cfgFile = Join-Path $ObsidianConfigDir 'obsidian.json'
$defaultCfg = ($ObsidianConfigDir -eq (Join-Path $env:APPDATA 'obsidian'))
if ($defaultCfg -and (Get-Process -Name Obsidian -ErrorAction SilentlyContinue)) {
  throw 'Obsidian is running. Close it completely (check the system tray) and run this script again.'
}
New-Item -ItemType Directory -Force -Path $ObsidianConfigDir | Out-Null
if (Test-Path $cfgFile) {
  Copy-Item $cfgFile "$cfgFile.bak" -Force
  $cfg = Get-Content -Raw $cfgFile | ConvertFrom-Json
} else {
  $cfg = [pscustomobject]@{ vaults = [pscustomobject]@{} }
}
if (-not $cfg.PSObject.Properties['vaults']) { $cfg | Add-Member -NotePropertyName vaults -NotePropertyValue ([pscustomobject]@{}) }
$already = $cfg.vaults.PSObject.Properties | Where-Object { $_.Value.path -eq $VaultDir }
if ($already) {
  Say 'Vault is already registered with Obsidian.'
} else {
  $id = -join ((1..16) | ForEach-Object { '{0:x}' -f (Get-Random -Maximum 16) })
  $ts = [int64][DateTimeOffset]::UtcNow.ToUnixTimeMilliseconds()
  $cfg.vaults | Add-Member -NotePropertyName $id -NotePropertyValue ([pscustomobject]@{ path = $VaultDir; ts = $ts; open = $true })
  [IO.File]::WriteAllText($cfgFile, ($cfg | ConvertTo-Json -Depth 6), $utf8)
  # Verify by reading the path back out of the file and checking it exists on disk
  $back = Get-Content -Raw $cfgFile | ConvertFrom-Json
  $entry = $back.vaults.PSObject.Properties | Where-Object { $_.Value.path -eq $VaultDir }
  if (-not $entry -or -not (Test-Path $entry.Value.path)) {
    if (Test-Path "$cfgFile.bak") { Copy-Item "$cfgFile.bak" $cfgFile -Force }
    throw 'Could not verify the Obsidian registration, so I restored the backup. Open Obsidian and use "Open folder as vault" instead.'
  }
  Say 'Registered the vault with Obsidian.'
}

# 6b. The "load junior" skill, so Junior loads inside any codebase (VS Code or terminal)
#     and the "kill junior" skill, so anyone can switch it off
foreach ($skill in 'junior', 'junior-off') {
  $skillSrc = Join-Path $VaultDir "08 - Resources\Onboarding\$skill-SKILL.txt"
  $skillDst = Join-Path $SkillsDir "$skill\SKILL.md"
  if (-not (Test-Path $skillSrc)) {
    Warn "$skill-SKILL.txt is missing from the vault; skipping the $skill skill."
    continue
  }
  New-Item -ItemType Directory -Force -Path (Split-Path $skillDst) | Out-Null
  $skillText = Get-Content -Raw -Encoding UTF8 $skillSrc
  if ((Test-Path $skillDst) -and ((Get-Content -Raw -Encoding UTF8 $skillDst) -ceq $skillText)) {
    Say "The $skill skill is already up to date."
  } else {
    [IO.File]::WriteAllText($skillDst, $skillText, $utf8)
    Say "Installed the $skill skill at $skillDst"
  }
}

# 6c. Handoff nudge: after a successful `git commit`, remind Claude to save "where we stopped" (only acts if Junior is loaded)
$hookSrc = Join-Path $VaultDir '08 - Resources\Onboarding\junior-handoff-nudge.json'
if (Test-Path $hookSrc) {
  $claudeHome = Split-Path $SkillsDir
  $hookDir = Join-Path $claudeHome 'hooks'
  New-Item -ItemType Directory -Force -Path $hookDir | Out-Null
  Copy-Item $hookSrc (Join-Path $hookDir 'junior-handoff-nudge.json') -Force
  $settingsFile = Join-Path $claudeHome 'settings.json'
  $hookCmd = 'cat "$HOME/.claude/hooks/junior-handoff-nudge.json"'
  $settings = [pscustomobject]@{}
  $parsed = $true
  if (Test-Path $settingsFile) {
    try { $settings = Get-Content -Raw $settingsFile | ConvertFrom-Json } catch { $parsed = $false }
  }
  if (-not $parsed) {
    Warn "Could not read $settingsFile as JSON, so I left it alone. Add the handoff hook by hand (see Onboarding.md)."
  } else {
    if (-not $settings.PSObject.Properties['hooks']) { $settings | Add-Member -NotePropertyName hooks -NotePropertyValue ([pscustomobject]@{}) }
    $existing = @()
    if ($settings.hooks.PSObject.Properties['PostToolUse']) { $existing = @($settings.hooks.PostToolUse) }
    $present = $existing | Where-Object { $_.hooks | Where-Object { $_.command -eq $hookCmd } }
    if ($present) {
      Say 'Handoff nudge hook is already in your Claude settings.'
    } else {
      if (Test-Path $settingsFile) { Copy-Item $settingsFile "$settingsFile.bak" -Force }
      $entry = [pscustomobject]@{
        matcher = 'Bash'
        hooks   = @([pscustomobject]@{ type = 'command'; command = $hookCmd; 'if' = 'Bash(git commit *)'; timeout = 10 })
      }
      $all = @($existing) + $entry
      if ($settings.hooks.PSObject.Properties['PostToolUse']) { $settings.hooks.PostToolUse = $all }
      else { $settings.hooks | Add-Member -NotePropertyName PostToolUse -NotePropertyValue $all }
      [IO.File]::WriteAllText($settingsFile, ($settings | ConvertTo-Json -Depth 20), $utf8)
      try { $null = Get-Content -Raw $settingsFile | ConvertFrom-Json; Say 'Added the handoff nudge hook to your Claude settings.' }
      catch {
        if (Test-Path "$settingsFile.bak") { Copy-Item "$settingsFile.bak" $settingsFile -Force }
        Warn 'The settings edit did not verify, so I restored your backup. Add the handoff hook by hand (see Onboarding.md).'
      }
    }
  }
}

# 6d. The baseline kit every Junior gets: the marketing skill (a reviewed, vendored copy) and the core plugins
$kitDir = Join-Path $VaultDir '08 - Resources\Onboarding\kit'
$mkZip = Join-Path $kitDir 'jaredrhod-marketing.zip'
$mkDst = Join-Path $SkillsDir 'jaredrhod-marketing'
if (Test-Path (Join-Path $mkDst 'SKILL.md')) {
  Say 'The marketing skill is already installed.'
} elseif (Test-Path $mkZip) {
  $tmp = Join-Path ([IO.Path]::GetTempPath()) ('jrm-' + [guid]::NewGuid().ToString('N'))
  try {
    Expand-Archive -Path $mkZip -DestinationPath $tmp
    $inner = Join-Path $tmp 'jaredrhod-marketing'
    if (-not (Test-Path (Join-Path $inner 'SKILL.md'))) { throw 'unexpected zip layout' }
    New-Item -ItemType Directory -Force -Path $mkDst | Out-Null
    Copy-Item (Join-Path $inner '*') $mkDst -Recurse -Force
    Say "Installed the marketing skill at $mkDst"
  } catch { Warn "Could not install the marketing skill: $($_.Exception.Message)" }
  finally { if (Test-Path $tmp) { Remove-Item $tmp -Recurse -Force } }
} else {
  Warn 'kit\jaredrhod-marketing.zip is missing from the vault; skipping the marketing skill.'
}

$kitJson = Join-Path $kitDir 'plugins.json'
if ($SkipPlugins) {
  Say 'Skipping plugins (-SkipPlugins).'
} elseif (-not (Test-Path $kitJson)) {
  Warn 'kit\plugins.json is missing from the vault; skipping plugins.'
} elseif (-not (Have claude)) {
  Warn 'Claude Code is not on PATH, so plugins were skipped. Install Claude Code, then run this script again.'
} else {
  $kit = Get-Content -Raw -Encoding UTF8 $kitJson | ConvertFrom-Json
  $claudeHome = Split-Path $SkillsDir
  $mk = $kit.marketplace
  $installedFile = Join-Path $claudeHome 'plugins\installed_plugins.json'
  $installed = @()
  if (Test-Path $installedFile) {
    try { $installed = @((Get-Content -Raw $installedFile | ConvertFrom-Json).plugins.PSObject.Properties.Name) } catch { }
  }
  $mcpNames = @()
  $cj = Join-Path $HOME '.claude.json'
  if (Test-Path $cj) {
    try { $mcpNames = @((Get-Content -Raw $cj | ConvertFrom-Json).mcpServers.PSObject.Properties.Name) } catch { }
  }
  $knownFile = Join-Path $claudeHome 'plugins\known_marketplaces.json'
  $haveMk = (Test-Path $knownFile) -and ((Get-Content -Raw $knownFile) -match [regex]::Escape($mk))
  if (-not $haveMk -and $mk -eq 'claude-plugins-official' -and -not $DryRun) {
    Say 'Adding the official plugin marketplace...'
    claude plugin marketplace add anthropics/claude-plugins-official
  }
  $Extras = @($Extras | ForEach-Object { $_ -split ',' } | Where-Object { $_ })
  $want = @($kit.core)
  if ($Extras -contains 'all') { $want += @($kit.extras) }
  else {
    foreach ($e in $Extras) {
      $hit = $kit.extras | Where-Object { $_.plugin -eq $e }
      if ($hit) { $want += $hit } else { Warn "Unknown extra '$e'. Options: $((@($kit.extras) | ForEach-Object { $_.plugin }) -join ', ')" }
    }
  }
  foreach ($p in $want) {
    $id = "$($p.plugin)@$mk"
    if ($installed -contains $id) { Say "$($p.plugin) is already installed."; continue }
    if ($p.skipIfMcpServer -and ($mcpNames -contains $p.skipIfMcpServer)) {
      Say "$($p.plugin): you already have a '$($p.skipIfMcpServer)' MCP server set up, so I didn't add a duplicate."
      continue
    }
    if ($DryRun) { Say "[dry run] would install $id"; continue }
    Say "Installing $id ..."
    claude plugin install $id --scope user
    if ($LASTEXITCODE -ne 0) { Warn "Could not install $id. Try it by hand: claude plugin install $id"; continue }
    if ($p.needs) { Warn "$($p.plugin) needs: $($p.needs)" }
  }
}

# 7. Desktop launcher
$launcher = Join-Path $DesktopDir 'Chat with Junior.bat'
if (Test-Path $launcher) {
  Say 'Launcher already on the Desktop.'
} else {
  [IO.File]::WriteAllText($launcher, "@echo off`r`ncd /d `"$AgentDir`"`r`nclaude`r`n", $utf8)
  Say "Created $launcher"
}

# 8. Final checks and next steps
Write-Host ''
if (-not (Have claude)) {
  Warn 'Claude Code is not installed (or not on PATH). Install it, sign in once, then use the launcher.'
}
if (-not (git config --global user.name)) {
  Warn 'Git has no name set. Run:  git config --global user.name "Your Name"  and  git config --global user.email "you@example.com"'
}
Write-Host "Done, $Name." -ForegroundColor Green
Write-Host '  1. Open Obsidian. It should open straight into the Undeify vault.'
Write-Host '  2. Open any project in VS Code, start Claude Code, and type:  load junior   (or /junior).'
Write-Host '     Want Junior off?  Type:  kill junior   (or /junior-off).'
Write-Host '     No VS Code handy? Double-click "Chat with Junior" on your Desktop instead.'
Write-Host '  3. On your first session Junior asks a few questions to write your profile into the vault.'
Write-Host "  4. If Junior doesn't greet you by name, tell Isaac."
