# Sync skills from D:\life\skills to Claude Code, Cursor, and a ChatGPT upload zip.
# Edit only the copy in D:\life\skills\<name>. Then run:
#   powershell -ExecutionPolicy Bypass -File D:\life\skills\sync.ps1
# Optional: -Skill style-guide  (default: every folder with SKILL.md)

param([string]$Skill = "")

$ErrorActionPreference = "Stop"
$root   = $PSScriptRoot
$claude = Join-Path $env:USERPROFILE ".claude\skills"
$cursor = Join-Path $env:USERPROFILE ".cursor\skills"
$dist   = Join-Path $root "dist"
$utf8   = New-Object System.Text.UTF8Encoding($false)
Add-Type -AssemblyName System.IO.Compression, System.IO.Compression.FileSystem

function Split-Skill([string]$text) {
    # Returns @(frontmatterLines, body)
    $m = [regex]::Match($text, '(?s)\A---\r?\n(.*?)\r?\n---\r?\n(.*)\z')
    if (-not $m.Success) { throw "SKILL.md has no frontmatter" }
    return @($m.Groups[1].Value, $m.Groups[2].Value)
}

function Copy-Tree([string]$src, [string]$dst) {
    if (Test-Path $dst) { Remove-Item $dst -Recurse -Force }
    Copy-Item $src $dst -Recurse
}

$skills = Get-ChildItem $root -Directory | Where-Object { $_.Name -ne "dist" -and (Test-Path (Join-Path $_.FullName "SKILL.md")) }
if ($Skill) { $skills = $skills | Where-Object { $_.Name -eq $Skill } }
if (-not $skills) { throw "No skill found" }
New-Item -ItemType Directory -Force $dist, $claude, $cursor | Out-Null

foreach ($s in $skills) {
    $name = $s.Name
    $text = [IO.File]::ReadAllText((Join-Path $s.FullName "SKILL.md"), $utf8)
    $fm, $body = Split-Skill $text

    # Claude Code: as written.
    $c = Join-Path $claude $name
    Copy-Tree $s.FullName $c

    # Cursor: same files, Cursor spelling of the slash-command key.
    $k = Join-Path $cursor $name
    Copy-Tree $s.FullName $k
    $fmCursor = $fm -replace '(?m)^user-invocable:', 'user-invokable:'
    [IO.File]::WriteAllText((Join-Path $k "SKILL.md"), "---`n$fmCursor`n---`n$body", $utf8)

    # ChatGPT: zip with one folder; frontmatter keeps only name and description,
    # so ChatGPT can pick the skill from its description.
    $keep = [regex]::Match($fm, '(?ms)^name:.*?(?=^\S|\z)').Value.TrimEnd() + "`n" +
            [regex]::Match($fm, '(?ms)^description:.*?(?=^\S|\z)').Value.TrimEnd()
    $zip = Join-Path $dist "$name.zip"
    if (Test-Path $zip) { Remove-Item $zip -Force }
    $za = [IO.Compression.ZipFile]::Open($zip, 'Create')
    try {
        Get-ChildItem $s.FullName -Recurse -File | ForEach-Object {
            $rel = $_.FullName.Substring($s.FullName.Length + 1) -replace '\\', '/'
            $entry = $za.CreateEntry("$name/$rel")
            $w = $entry.Open()
            try {
                if ($rel -eq "SKILL.md") {
                    $bytes = $utf8.GetBytes("---`n$keep`n---`n$body")
                } else {
                    $bytes = [IO.File]::ReadAllBytes($_.FullName)
                }
                $w.Write($bytes, 0, $bytes.Length)
            } finally { $w.Dispose() }
        }
    } finally { $za.Dispose() }

    "{0}: Claude -> {1}; Cursor -> {2}; ChatGPT zip -> {3}" -f $name, $c, $k, $zip
}
