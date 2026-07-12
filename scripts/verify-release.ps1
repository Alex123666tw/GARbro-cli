param(
    [string]$BinDirectory = (Join-Path $PSScriptRoot '..\bin\Release'),
    [string]$ExpectedCliVersion = '0.1.1.0'
)

$ErrorActionPreference = 'Stop'
$bin = (Resolve-Path $BinDirectory).Path
$exe = Join-Path $bin 'GARbro.Console.exe'
$gameResPath = Join-Path $bin 'GameRes.dll'
$arcFormatsPath = Join-Path $bin 'ArcFormats.dll'

foreach ($path in @($exe, $gameResPath, $arcFormatsPath)) {
    if (-not (Test-Path -LiteralPath $path -PathType Leaf)) {
        throw "Required release file is missing: $path"
    }
}

function Invoke-GarbroCli {
    param([string[]]$Arguments)

    $startInfo = New-Object Diagnostics.ProcessStartInfo
    $startInfo.FileName = $exe
    $startInfo.Arguments = $Arguments -join ' '
    $startInfo.UseShellExecute = $false
    $startInfo.RedirectStandardOutput = $true
    $startInfo.RedirectStandardError = $true

    $process = [Diagnostics.Process]::Start($startInfo)
    $stdout = $process.StandardOutput.ReadToEnd()
    $stderr = $process.StandardError.ReadToEnd()
    $process.WaitForExit()
    [pscustomobject]@{ ExitCode = $process.ExitCode; Stdout = $stdout; Stderr = $stderr }
}

$help = Invoke-GarbroCli @('--help')
if ($help.ExitCode -ne 0 -or $help.Stdout -notmatch 'Usage:') {
    throw 'Help smoke test failed.'
}
if ($help.Stderr -notmatch [regex]::Escape("GARbro-cli version $ExpectedCliVersion")) {
    throw "CLI version banner does not report $ExpectedCliVersion."
}

$formats = Invoke-GarbroCli @('f', '-q')
if ($formats.ExitCode -ne 0 -or [string]::IsNullOrWhiteSpace($formats.Stdout)) {
    throw 'Format-list smoke test failed.'
}

$gameRes = [Reflection.Assembly]::LoadFrom($gameResPath)
$arcFormats = [Reflection.Assembly]::LoadFrom($arcFormatsPath)
if ($null -eq $arcFormats.GetType('GameRes.Cryptography.Blowfish', $false)) {
    throw 'The MIT Blowfish implementation is missing from ArcFormats.dll.'
}
foreach ($gplType in @(
    'GameRes.Formats.Kogado.CocotteEncoder',
    'GameRes.Formats.Kogado.CRangeCoder'
)) {
    if ($null -ne $arcFormats.GetType($gplType, $false)) {
        throw "Default ArcFormats.dll unexpectedly contains GPL opt-in type: $gplType"
    }
}

Write-Host "Release verification passed for GARbro-cli $ExpectedCliVersion."
