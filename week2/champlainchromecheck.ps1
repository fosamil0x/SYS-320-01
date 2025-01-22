$find_chrome = get-process | where-object { ($_.Name -like "*chrome*") }
$web = "https://champlain.edu"

if ($find_chrome) {
    $chrome_id = (get-process -Name "chrome").id
    Stop-Process -Id $chrome_id}
else {
    Start-Process -FilePath "chrome.exe" -Argument $web
}