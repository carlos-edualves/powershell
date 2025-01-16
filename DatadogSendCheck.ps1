$values = get-service -name "xb*" | select-object name, status

function dogstatsd($serviceCheck) {
    $udpClient = New-Object System.Net.Sockets.UdpClient
    $udpClient.Connect('127.0.0.1', '8125')
    $encodedData = [System.Text.Encoding]::ASCII.GetBytes($serviceCheck)
    $udpClient.Send($encodedData, $encodedData.Length)
    $udpClient.Close()
}

foreach ($value in $values) {
    $servico=$value.name
    $status=$value.Status
    if ($status -eq "running"){$status=0}else{$status=2}
    $serviceCheck = "_sc|$servico|$status"
    dogstatsd($serviceCheck)
    $serviceCheck
}








