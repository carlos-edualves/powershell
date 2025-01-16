$values = Get-clusterResource -Name "<nodes-names>" | select-Object name,state

function dogstatsd($serviceCheck) {
    $udpClient = New-Object System.Net.Sockets.UdpClient
    $udpClient.Connect('127.0.0.1', '8125')
    $encodedData = [System.Text.Encoding]::ASCII.GetBytes($serviceCheck)
    $udpClient.Send($encodedData, $encodedData.Length)
    $udpClient.Close()
}

foreach ($value in $values) {
    $servico=$value.name
    $status=$value.state
    if ($status -eq "Online"){$status=0}else{$status=2}
    $serviceCheck = "_sc|$servico|$status"
    dogstatsd($serviceCheck)
    write-host "Payload sent: " $serviceCheck
}