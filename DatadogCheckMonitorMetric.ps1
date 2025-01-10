#SCRIPT PARA CHECKAR SE EXISTE MONITOR PARA UMA MÉTRICA ESPECÍFICA
$Api_Key = ""
$App_Key = ""
$url = "https://api.datadoghq.com/api/v1/monitor?api_key=$Api_Key&application_key=$App_Key"
$monitors = Invoke-RestMethod -Uri $url -Method Get
$count=0
foreach ($monitor in $monitors){
        $monitor_query = $monitor.query | Select-String -Pattern ".*azure.vm.*" -AllMatches | foreach-object { $_.Matches } | foreach-object { $_.Value } | Get-Unique
        if ($monitor_query){          
                    #Invoke-RestMethod -Method Put -Uri $url_message -Body $body_message
                    #write-host "-----------------------------------------------------"
                    write-host $monitor.name " | " -ForegroundColor cyan -NoNewline
                    write-host $monitor.query -ForegroundColor magenta 
                    #write-host "-----------------------------------------------------"
                    $count++ 
         }


}
$count