. (Join-Path $PSScriptRoot functionsandscripts4.ps1)
. (Join-Path $PSScriptRoot funcrtionsandscripts5.ps1)

clear

$loginoutDot = getDaysForEventLog -days 50
$loginoutDot

$powerstateDot = getPowerLogs -powerDays 50
$powerstateDot