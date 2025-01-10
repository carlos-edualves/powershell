#TibcoEmsDogstatsdCollector| script feito para coletar dados do tibco hawk e postar para o agent datadog via dogstatsd em udp localhost 8125 (criado por carlos.alves 138150)
$tibcoarray =@(
'tibco.messageMemory'
,'tibco.connectionCount' 
,'tibco.diskReadRate' 
,'tibco.diskWriteRate' 
,'tibco.outboundMessageCount' 
,'tibco.pendingMessageSize' 
,'tibco.inboundMessageCount' 
,'tibco.outboundMessageRate' 
,'tibco.queueCount' 
,'tibco.asyncDBSize' 
,'tibco.inboundMessageRate' 
,'tibco.inboundBytesRate' 
,'tibco.pendingMessageCount' 
,'tibco.outboundBytesRate'
)
$metricvalue = 0
foreach ($i in $tibcoarray){
    function dogstatsd($metric) {
        $udpClient = New-Object System.Net.Sockets.UdpClient
        $udpClient.Connect('127.0.0.1', '8125')
        $encodedData=[System.Text.Encoding]::ASCII.GetBytes($metric) 
        $bytesSent=$udpClient.Send($encodedData,$encodedData.Length) 
        $udpClient.Close()
            }
        $tags = "|#environment:prd,host:srv-server01,produto:tibcoems" # Datadog tags
        $metric = "$i" + ":" + $args[$metricvalue] + "|g" + $tags
        dogstatsd($metric)
        $(get-date),$i,$args[$metricvalue] -join " - " >> "c:\scripts\$((Get-Date).Day)-$((Get-Date).Month)-$((Get-Date).Year)Output_coleta.txt" 
        $metricvalue ++
}
#ordem dos argumentos
#${messageMemory} ${connectionCount} ${diskReadRate} ${diskWriteRate} ${outboundMessageCount} ${pendingMessageSize} ${inboundMessageCount} ${outboundMessageRate} ${queueCount} ${asyncDBSize} ${inboundMessageRate} ${inboundBytesRate} ${pendingMessageCount} ${outboundBytesRate}