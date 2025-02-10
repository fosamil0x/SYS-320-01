$a = Get-ChildItem C:\xampp\apache\logs\*.log | Select-String 'error'
$a | Select-Object -Last 5