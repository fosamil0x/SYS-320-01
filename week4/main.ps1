(Join-Path $PSScriptRoot Apache-Logs.ps1)
clear

$results = getIPForPageVisit -page page1.html -http 200 -browser Chrome
$results