$A = Get-Content C:\xampp\apache\logs\*.log | Select-string 'error'
$A