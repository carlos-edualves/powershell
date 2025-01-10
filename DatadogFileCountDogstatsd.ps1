$folderPath = "C:\Users\Administrator\Downloads"
$fileCount = (Get-ChildItem -Path $folderPath -File).Count
$fileCount
    function dogstatsd($metric) {
        $udpClient = New-Object System.Net.Sockets.UdpClient
        $udpClient.Connect('127.0.0.1', '8125')
        $encodedData=[System.Text.Encoding]::ASCII.GetBytes($metric)
        $bytesSent=$udpClient.Send($encodedData,$encodedData.Length)
        $udpClient.Close()
            }
        $tags = "|#environment:legado-hom,host:srv-sieghom01" # Datadog tag
        $metric = "baixanf.filecount" + ":" + $fileCount + "|g" + $tags # metric
        $metric
        #dogstatsd($metric)