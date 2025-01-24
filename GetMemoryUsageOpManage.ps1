$deviceName = $args[0];
$username = $args[1];
$password = $args[2] | ConvertTo-SecureString -asPlainText -Force;
$credential = New-Object System.Management.Automation.PSCredential($username,$password);

$memorys = Invoke-Command -ComputerName $deviceName -Credential $credential -ScriptBlock {Get-WmiObject win32_process -Filter "name = 'w3wp.exe'" | sort-object -descending WS | Select-Object WS,CommandLine}

Write-host "Data:";
 foreach($memory in $memorys){ 
    $appname = $memory.CommandLine | Select-String -Pattern '(?<=-ap.").*(?=".-v)' -AllMatches | ForEach-Object {$_.Matches} | ForEach-Object {$_.Value} 
    write-host $appname "`t " -NoNewline ; write-host ($memory.WS / 1GB) 
    }
exit 0;